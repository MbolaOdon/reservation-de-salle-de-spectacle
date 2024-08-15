<?php
require_once(ROOT . 'app/Database.php');
class SalleController extends Controller
{
    private $salleModel;
    private Database $database;

    public function __construct()
    {
        $this->salleModel = $this->model('Salle');
    }
    public function getAll()
    {

        if ($_SERVER['REQUEST_METHOD'] != 'GET') {

            $data = ['status' => 405, 'message' => $_SERVER["REQUEST_METHOD"] . "Method Not Allowed",];

            return response($data, 405);
        }

        $salle = new Salle();
        $rows = $salle->all();

        return response($rows, 200);
    }
    public function getSalleDetails($id){
        if ($_SERVER['REQUEST_METHOD'] != 'GET') {

            $data = ['status' => 405, 'message' => $_SERVER["REQUEST_METHOD"] . "Method Not Allowed",];

            return response($data, 405);
        }

        $salle = new Salle();
        $rows = $salle->details($id);

        return response($rows, 200);
    }
    public function add($id, $request)
    {
        if ($_SERVER['REQUEST_METHOD'] != 'POST') {

            $data = ['status' => 405, 'message' => $_SERVER["REQUEST_METHOD"] . "Method Not Allowed",];

            return response($data, 405);
        }
        //return response($request, 405);
        $salle = new Salle();$longLatitude = '';
        $salle->save(
            $request['titre'],
            $request['subTitre'],
            $request['Description'],
            $request['prix'],
            $request['occupation'],
            $request['localName'],
            $request['longLatitude '],
            $request['nbrPlace'],
            $request['star'],
            $request['typeSalle'],
            $request['idPro']
        );
        
    }

    public function modify($id, $request)
    {
        if ($_SERVER['REQUEST_METHOD'] != 'PUT') {

            $data = ['status' => 405, 'message' => $_SERVER["REQUEST_METHOD"] . "Method Not Allowed",];

            return response($data, 405);
        }
        $salle = new Salle();
        $salle->update(
            $id,
            $request['titre'],
            $request['subTitre'],
            $request['Description'],
            $request['prix'],
            $request['occupation'],
            $request['localName'],
            $request['longLatitude'],
            $request['nbrPlace'],
            $request['star'],
            $request['typeSalle'],
            $request['idPro']
        );
    }


    public function destroy($id)
    {
        if ($_SERVER['REQUEST_METHOD'] != 'DELETE') {

            $data = ['status' => 405, 'message' => $_SERVER["REQUEST_METHOD"] . "Method Not Allowed",];

            return response($data, 405);
        }
        $salle = new Salle();
        if ($salle->find(intval($id))) {
            if (!$salle->delete(intval($id))) {
                $data = [
                    'status' => 500,
                    'message' => "Error deleting Salle"
                ];
                return response($data, 500);
            };

            $data = ['status' => 200, 'message' => "Salle deleted ",];
            return response($data, 200);
        } else {
            $data = ['status' => 404, 'message' => 'Salle not found',];
            return response($data, 404);
        }
    }
    public function destroys($ids)
    {
        if ($_SERVER['REQUEST_METHOD'] != 'DELETE') {

            $data = ['status' => 405, 'message' => $_SERVER["REQUEST_METHOD"] . "Method Not Allowed",];

            return response($data, 405);
        }
        $salle = new Salle();
        $ids = isset($ids) ? $ids : [];
        if (empty($ids)) {
            $data = [
                'status' => 400,
                'message' => 'No IDs provided'
            ];
            return response($data, 400);
        }

        $salle->deleteMany($ids);

        $data = [
            'status' => 200,
            'message' => 'Salles deleted successfully'
        ];
        return response($data, 200);
    }


    public function getViewSalle() {

        if ($_SERVER['REQUEST_METHOD'] != 'GET') {

            $data = ['status' => 405, 'message' => $_SERVER["REQUEST_METHOD"] . "Method Not Allowed",];

            return response($data, 405);
        }

        $salle = new Salle();
        $rows = $salle->viewSalle();

        return response($rows, 200);
    }

   public function uploadSalle($id) {
    $targetDir = ROOT . 'public/uploads/salles/';
    $allowedExtensions = ['jpeg', 'jpg', 'png', 'gif'];
    $maxFileSize = 5 * 1024 * 1024; // 5 MB

    if (!isset($_FILES['image']) || $_FILES['image']['error'] != UPLOAD_ERR_OK) {
        return $this->jsonResponse(['status' => 'fail', 'message' => 'Aucune image n\'a été téléchargée.'], 400);
    }

    $file = $_FILES['image'];
    $fileName = $file['name'];
    $fileSize = $file['size'];
    $fileTmp = $file['tmp_name'];
    $fileExtension = strtolower(pathinfo($fileName, PATHINFO_EXTENSION));

    if (!in_array($fileExtension, $allowedExtensions)) {
        return $this->jsonResponse(['status' => 'fail', 'message' => 'Extension de fichier non valide.'], 400);
    }

    if ($fileSize > $maxFileSize) {
        return $this->jsonResponse(['status' => 'fail', 'message' => 'La taille du fichier dépasse la limite de 5 Mo.'], 400);
    }

    if (!is_dir($targetDir)) {
        mkdir($targetDir, 0755, true);
    }

    $newFileName = uniqid() . '.' . $fileExtension;
    $targetFile = $targetDir . $newFileName;

    if (move_uploaded_file($fileTmp, $targetFile)) {
        try {
            $db = new Database();
            $db->open();
            $stmt = $db->mysqli->prepare("INSERT INTO photos (design, interne_design, idSalle) VALUES (?, ?, ?)");
            $stmt->bind_param("ssi", $newFileName, $newFileName, $id);
            $stmt->execute();
            $stmt->close();
            $db->close();

            return $this->jsonResponse([
                'status' => 'success',
                'message' => 'Image téléchargée avec succès.',
                'filename' => $newFileName
            ], 200);
        } catch (Exception $e) {
            unlink($targetFile);
            return $this->jsonResponse(['status' => 'fail', 'message' => 'Erreur de base de données: ' . $e->getMessage()], 500);
        }
    } else {
        return $this->jsonResponse(['status' => 'fail', 'message' => 'Échec du téléchargement du fichier.'], 500);
    }
}

private function jsonResponse($data, $statusCode = 200) {
    header('Content-Type: application/json');
    http_response_code($statusCode);
    echo json_encode($data);
    exit;
}
}
