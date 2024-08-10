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