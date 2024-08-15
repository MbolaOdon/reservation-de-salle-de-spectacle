<?php
require_once(ROOT . 'app/Database.php');
class Reservation {
    private DataBase $database;
    private int $insert_id;

    public function getInsert_id(){
        return $this->insert_id;
    }
    public function setInsert_id($statement) {
        $this->insert_id = $statement;
    }

    public function save($nbrSalle, $dateDebut, $dateFin, $validation, $idSalle, $idCli )
    {

        $this->database = new Database();
        $this->database->open();

        // Utiliser une requête préparée pour éviter les injections SQL
        $stmt = $this->database->mysqli->prepare("INSERT INTO reservation (nbrSalle, dateDebut, dateFin, validation, idSalle, idCli) VALUES (?, ?, ?, ?, ?, ?)");
        $stmt->bind_param('ssssss', $nbrSalle, $dateDebut, $dateFin, $validation, $idSalle, $idCli );

        if ($stmt->execute()) {
            $this->setInsert_id($stmt->insert_id);
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
    public function update($id, $nbrSalle, $dateDebut, $dateFin, $validation, $idSalle, $idCli )
    {
        $this->database = new Database();
        $this->database->open();

        $query = "UPDATE reservation SET nbrSalle= ?, dateDebut= ?, dateFin= ?, validation= ?, idSalle= ?, idCli= ?";
        $query .= " WHERE idReserv = ?";

        $stmt = $this->database->mysqli->prepare($query);
        $stmt->bind_param('ssssssi', $nbrSalle, $dateDebut, $dateFin, $validation, $idSalle, $idCli , $id);

        $success = $stmt->execute();
        $stmt->close();
        $this->database->close();

 
        if ($success) {
            $data = [
                'status' => 200,
                'message' => "Proprietaire updated successfully"
            ];
            $statusCode = 200;
        } else {
            $data = [
                'status' => 500,
                'message' => "Error updating client"
            ];
            $statusCode = 500;
        }

        return response($data, $statusCode);
    }

    public function delete($id)
    {
        $this->database = new Database();
        $this->database->open();

        // Utiliser une requête préparée pour éviter les injections SQL
        $stmt = $this->database->mysqli->prepare("DELETE FROM reservation WHERE idReserv = ?");
        $stmt->bind_param('s', $id);
        $stmt->execute();

        $success = ($stmt->affected_rows > 0);
        $stmt->close();
        $this->database->close();

        return $success;
    }

    public function deleteMany($ids)
    {
        $allSuccessful = true;

        foreach ($ids as $id) {
            if (!$this->delete($id)) {
                $allSuccessful = false;
            }
        }

        return $allSuccessful;
    }

    public function all()
    {
        $this->database = new Database();
        $this->database->open();

        $stmt = $this->database->mysqli->prepare("SELECT * FROM reservation");
        $stmt->execute();
        $result = $stmt->get_result();

        $rows = [];
        if ($result->num_rows > 0) {
            while ($row = $result->fetch_array(MYSQLI_ASSOC)) {
                $rows[] = $row;
            }
        }

        $this->database->close();
        return $rows;
    }

    public function reservImage($idCli) {
        $this->database = new Database();
        $this->database->open();
    
        $stmt = $this->database->mysqli->prepare("SELECT * FROM reservation_salle_client as rsc WHERE rsc.idCli = ? 
        ");
    
        $stmt->bind_param("i", $idCli);
        $stmt->execute();
        $result = $stmt->get_result();
    
        $rows = [];
        if ($result->num_rows > 0) {
            while ($row = $result->fetch_assoc()) {
                $rows[] = $row;
            }
        }
    
        $stmt->close();
        $this->database->close();
    
        return $rows;
    }

    public function reservImageProp($idCli) {
        $this->database = new Database();
        $this->database->open();
    
        $stmt = $this->database->mysqli->prepare("SELECT * FROM reservation_salle_client  
        ");
    
        
        $stmt->execute();
        $result = $stmt->get_result();
    
        $rows = [];
        if ($result->num_rows > 0) {
            while ($row = $result->fetch_assoc()) {
                $rows[] = $row;
            }
        }
    
        $stmt->close();
        $this->database->close();
    
        return $rows;
    }

    public function getOne()
    {
        $this->database = new Database();
        $this->database->open();
        $this->database->close();
    }

    public function find($data)
    {
        $this->database = new Database();
        $this->database->open();

        // Utilisation de requêtes préparées pour éviter les injections SQL
        $stmt = $this->database->mysqli->prepare("SELECT * FROM reservation WHERE idReserv = ?");
        $stmt->bind_param('s', $data);
        $stmt->execute();
        $result = $stmt->get_result();

        if ($result->num_rows > 0) {
            return true;
        } else {
            return false;
        }
    }

    public function myReservation($idCli) {
    $this->database = new Database();
    $this->database->open();
    
    $stmt = $this->database->mysqli->prepare("
        SELECT
            r.idReserv,
            r.nbrSalle,
            r.dateDebut,
            r.dateFin,
            r.validation,
            s.titre ,
            s.subTitre,
            s.localName ,
            s.prix ,
            p.design ,
            c.nomPrenom ,
            c.phone ,
            c.email 
        FROM
            reservation r
        JOIN
            salle s ON r.idSalle = s.idSalle
        LEFT JOIN
            photos p ON s.idSalle = p.idSalle
        JOIN
            client c ON r.idCli = c.idCli
        WHERE
            c.idCli = ?
        ORDER BY
            r.dateDebut DESC
    ");
    
    $stmt->bind_param("i", $idCli);
    $stmt->execute();
    $result = $stmt->get_result();
    
    $rows = [];
    while ($row = $result->fetch_assoc()) {
        $rows[] = $row;
    }
    
    $stmt->close();
    $this->database->close();
    
    return $rows;
}

public function setValidate($id) {
    $is = 1;
    $this->database = new Database();
    $this->database->open();

    $query = "UPDATE reservation SET  validation= ?";
    $query .= " WHERE idReserv = ?";

    $stmt = $this->database->mysqli->prepare($query);
    $stmt->bind_param('si', $is, $id);

    $success = $stmt->execute();
    $stmt->close();
    $this->database->close();


    if ($success) {
        $data = [
            'status' => 200,
            'message' => "Proprietaire updated successfully"
        ];
        $statusCode = 200;
    } else {
        $data = [
            'status' => 500,
            'message' => "Error updating client"
        ];
        $statusCode = 500;
    }

    return response($data, $statusCode);
}
}