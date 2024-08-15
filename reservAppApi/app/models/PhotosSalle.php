<?php
require_once(ROOT . 'app/Database.php');
class PhotosSalle {
    private DataBase $database;
    
    public function add($design, $interne_design, $dateFin, $idSalle) {
        $this->database = new Database();
        $this->database->open();

        // Utiliser une requête préparée pour éviter les injections SQL
        $stmt = $this->database->mysqli->prepare("INSERT INTO photos (design, interne_design, idSalle) VALUES (?, ?, ?, ?)");
        $stmt->bind_param('ssss', $design, $interne_design, $dateFin, $idSalle );

        if ($stmt->execute()) {
           
            $data = [
                'status' => 201,
                'message' => "Created"
            ];
            $statusCode = 201;
        } else {
            $data = [
                'status' => 500,
                'message' => "Error creating Proprietaire"
            ];
            $statusCode = 500;
        }

        $stmt->close();
        $this->database->close();

        return response($data, $statusCode);
    }
}