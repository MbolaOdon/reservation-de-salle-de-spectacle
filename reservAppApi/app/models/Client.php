<?php
require_once(ROOT . 'app/Database.php');
include_once(ROOT. 'app/controllers/ProprietaireController.php');
class Client
{
    private DataBase $database;
    private string $secret = "c1isvFdxMDdmjOlvxpecFw";

    protected function get_pwd_from_db($login) {
        $this->database = new Database();
        $this->database->open();
        
        // Utiliser une requête préparée pour éviter les injections SQL
        $stmt = $this->database->mysqli->prepare("SELECT password, idCli, role FROM client WHERE email = ? OR phone = ?");
        $stmt->bind_param('ss', $login, $login);
        $stmt->execute();
        $result = $stmt->get_result();
        $user = $result->fetch_assoc();
        
        $stmt->close();
        $this->database->close();
        
        return $user;
    }

    public function save($nomPrenom, $phone, $addresse, $email, $password, $password_confirmed) {
        // Vérifier si les mots de passe correspondent avant de procéder
        if ($password !== $password_confirmed) {
            $data = [
                'status' => 400,
                'message' => "Passwords do not match"
            ];
            return response($data, 400);
        }

        $pwd_peppered = hash_hmac("sha256", $password, $this->secret);
        $pwd_hashed = password_hash($pwd_peppered, PASSWORD_DEFAULT);

        $this->database = new Database();
        $this->database->open();
        
        // Utiliser une requête préparée pour éviter les injections SQL
        $stmt = $this->database->mysqli->prepare("INSERT INTO client (nomPrenom, phone, adresse, email, password) VALUES (?, ?, ?, ?, ?)");
        $stmt->bind_param('sssss', $nomPrenom, $phone, $addresse, $email, $pwd_hashed);
        
        if ($stmt->execute()) {
            $data = [
                'status' => 201,
                'message' => "Created"
            ];
            $statusCode = 201;
        } else {
            $data = [
                'status' => 500,
                'message' => "Error creating client"
            ];
            $statusCode = 500;
        }
        
        $stmt->close();
        $this->database->close();

        return response($data, $statusCode);
    }
    public function update($id, $nomPrenom, $phone, $adresse, $email, $password = null) {
        $this->database = new Database();
        $this->database->open();
        
        $query = "UPDATE client SET nomPrenom = ?, phone = ?, adresse = ?, email = ?";

        // Ajouter la mise à jour du mot de passe seulement si un nouveau mot de passe est fourni
        if ($password !== null) {
            $pwd_peppered = hash_hmac("sha256", $password, $this->secret);
            $pwd_hashed = password_hash($pwd_peppered, PASSWORD_DEFAULT);
            $query .= ", password = ?";
        }

        $query .= " WHERE idCli = ?";

        $stmt = $this->database->mysqli->prepare($query);

        if ($password !== null) {
            $stmt->bind_param('sssssi', $nomPrenom, $phone, $adresse, $email, $pwd_hashed, $id);
        } else {
            $stmt->bind_param('ssssi', $nomPrenom, $phone, $adresse, $email, $id);
        }

        $success = $stmt->execute();
        
        $stmt->close();
        $this->database->close();

        // Préparer la réponse en fonction du succès de la mise à jour
        if ($success) {
            $data = [
                'status' => 200,
                'message' => "Client updated successfully"
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

    public function login_check($login, $password) {
        $user = $this->get_pwd_from_db($login);
        
        if (!$user) {
            
            $data = [
                'login' => $login,
                'status' => 401,
                'message' => "User not found"
            ];
           
        // $request = [
        //     'login' => $login,
        //     'password' => $password
        // ];
        
        // $proprietaire = new ProprietaireController();
        // // Assuming $id is defined somewhere or passed to the function
        // $id = null; // Modify as needed based on your logic
        // $proprietaire->login($id, $request);
            return response($data, 404);
        }

        $pwd_peppered = hash_hmac("sha256", $password, $this->secret);
        $pwd_hashed = $user['password'];

        if (password_verify($pwd_peppered, $pwd_hashed)) {
            $data = [
                'id' => $user['idCli'],
                'role' => $user['role'],
                'status' => 200,
                'message' => "Password matches"
            ];
            return response($data, 200);
        } else {
            $data = [
                'login' => $login,
                'status' => 401,
                'message' => "Password incorrect"
            ];
            return response($data, 401);
        }
    }

    public function delete($id)
    {
        $this->database = new Database();
        $this->database->open();

        // Utiliser une requête préparée pour éviter les injections SQL
        $stmt = $this->database->mysqli->prepare("DELETE FROM client WHERE idCli = ?");
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

        $stmt = $this->database->mysqli->prepare("SELECT * FROM client");
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

    public function getOnce($login)
    {
        $this->database = new Database();
        $this->database->open();
        $stmt = $this->database->mysqli->prepare("SELECT idCli, role FROM client WHERE email = ? OR phone= ?");
        $stmt->bind_param('ss', $login, $login);
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

    public function find($data)
    {
        $this->database = new Database();
        $this->database->open();

        // Utilisation de requêtes préparées pour éviter les injections SQL
        $stmt = $this->database->mysqli->prepare("SELECT * FROM client WHERE idCli = ?");
        $stmt->bind_param('s', $data);
        $stmt->execute();
        $result = $stmt->get_result();

        if ($result->num_rows > 0) {
            return true;
        } else {
            return false;
        }
    }
}
