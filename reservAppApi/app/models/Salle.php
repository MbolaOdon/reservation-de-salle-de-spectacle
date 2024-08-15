<?php
require_once(ROOT . 'app/Database.php');
class Salle
{
    private DataBase $database;
    public function save($titre, $subTitre, $description, $prix, $occupation, $localName, $longLatitude, $nbrPlace, $star, $typeSalle, $idPro)
    {
        $this->database = new Database();
        $this->database->open();

        // Utiliser une requête préparée pour éviter les injections SQL
        $stmt = $this->database->mysqli->prepare("INSERT INTO salle (titre, subTitre, description, prix, occupation, localName, longLatitude, nbrPlace, star, typeSalle, idPro) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
        $stmt->bind_param('sssssssssss', $titre, $subTitre, $description, $prix, $occupation, $localName, $longLatitude, $nbrPlace, $star, $typeSalle, $idPro);

        if ($stmt->execute()) {
            $last_id = $this->database->mysqli->insert_id;
            $data = [
                'id'=> $last_id,
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
    public function update($id, $titre, $subTitre, $description, $prix, $occupation, $localName, $longLatitude, $nbrPlace, $star, $typeSalle, $idPro)
    {
        $this->database = new Database();
        $this->database->open();

        $query = "UPDATE salle SET titre= ?, subTitre= ?, description= ?, prix= ?, occupation= ?, localName= ?, longLatitude= ?, nbrPlace= ?, star= ?, typeSalle= ?, idPro= ?";
        $query .= " WHERE idSalle = ?";

        $stmt = $this->database->mysqli->prepare($query);
        $stmt->bind_param('sssssssssssi', $titre, $subTitre, $description, $prix, $occupation, $localName, $longLatitude, $nbrPlace, $star, $typeSalle, $idPro, $id);

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
        $stmt = $this->database->mysqli->prepare("DELETE FROM salle WHERE idSalle = ?");
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

        $stmt = $this->database->mysqli->prepare("SELECT * FROM salle");
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

    public function getOnce()
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
        $stmt = $this->database->mysqli->prepare("SELECT * FROM salle WHERE idSalle = ?");
        $stmt->bind_param('s', $data);
        $stmt->execute();
        $result = $stmt->get_result();

        if ($result->num_rows > 0) {
            return true;
        } else {
            return false;
        }
    }

    public function viewSalle() {
        $this->database = new Database();
        $this->database->open();

        $stmt = $this->database->mysqli->prepare("SELECT * FROM salle_image GROUP BY idSalle");
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
    public function details($id){
        $this->database = new Database();
        $this->database->open();

        $stmt = $this->database->mysqli->prepare("SELECT * FROM salle_image WHERE idSalle= ?");
        $stmt->bind_param('s', $id);
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
   
}
