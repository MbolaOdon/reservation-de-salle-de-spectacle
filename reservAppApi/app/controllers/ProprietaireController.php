<?php
class ProprietaireController extends Controller
{
    private $propModel;

    public function __construct()
    {
        $this->propModel = $this->model('Proprietaire');
    }

    public function register($id, $request)
    {
        if ($_SERVER['REQUEST_METHOD'] != 'POST') {

            $data = ['status' => 405, 'message' => $_SERVER["REQUEST_METHOD"] . "Method Not Allowed",];

            return response($data, 405);
        }
        $client =  new Proprietaire();
        $client->save(
            $request['nomPrenom'],
            $request['phone'],
            $request['adresse'],
            $request['email'],
            $request['password'],
            $request['password_confirmed']
        );
        //return response($request);

    }
    public function login($id, $request)
    {
        if ($_SERVER['REQUEST_METHOD'] != 'POST') {

            $data = ['status' => 405, 'message' => $_SERVER["REQUEST_METHOD"] . "Method Not Allowed",];

            return response($data, 405);
        }
        $client =  new Proprietaire();
        $client->login_check(
            $_POST['login'],
            $_POST['password'],

        );
    }

    public function getAll()
    {
        if ($_SERVER['REQUEST_METHOD'] != 'GET') {

            $data = ['status' => 405, 'message' => $_SERVER["REQUEST_METHOD"] . "Method Not Allowed",];

            return response($data, 405);
        }
        $client = new Proprietaire();
        $rows = $client->all();

        return response($rows, 200);
    }

    public function modify()
    {
        $client = new Proprietaire();
    }

    public function destroy($id)
    {
        if ($_SERVER['REQUEST_METHOD'] != 'DELETE') {

            $data = ['status' => 405, 'message' => $_SERVER["REQUEST_METHOD"] . "Method Not Allowed",];

            return response($data, 405);
        }

        $client = new Proprietaire();
        if ($client->find(intval($id))) {
            if (!$client->delete(intval($id))) {
                $data = [
                    'status' => 500,
                    'message' => "Error deleting Proprietaire"
                ];
                return response($data, 500);
            };

            $data = ['status' => 200, 'message' => "Proprietaire deleted ",];
            return response($data, 200);
        } else {
            $data = ['status' => 404, 'message' => 'Proprietaire not found',];
            return response($data, 404);
        }
    }
    public function destroyMany($ids)
    {
        if ($_SERVER['REQUEST_METHOD'] != 'DELETE') {

            $data = ['status' => 405, 'message' => $_SERVER["REQUEST_METHOD"] . "Method Not Allowed",];

            return response($data, 405);
        }
        $client = new Proprietaire();
        $ids = isset($ids) ? $ids : [];
        if (empty($ids)) {
            $data = [
                'status' => 400,
                'message' => 'No IDs provided'
            ];
            return response($data, 400);
        }

        $client->deleteMany($ids);

        $data = [
            'status' => 200,
            'message' => 'Proprietaires deleted successfully'
        ];
        return response($data, 200);
    }
    public function get_user_by_Id($id)
    {
        var_dump($id);
    }

    function __destruct()
    {

        return false;
    }
}
