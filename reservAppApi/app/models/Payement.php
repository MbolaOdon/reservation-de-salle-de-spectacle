<?php
include_once(ROOT . 'app/models/Reservation.php');
class Payement
{
    private DataBase $database;

    private function checkExist($id)
    {
        $this->database = new Database();
        $this->database->open();
        $stmt = $this->database->mysqli->prepare("SELECT * FROM payement WHERE idReserv = ?");
        $stmt->bind_param('s', $id);
        $stmt->execute();
        $result = $stmt->get_result();

        if ($result->num_rows > 0) {
            return true;
        } else {
            return false;
        }
    }

    public function find($id)
    {
        $this->database = new Database();
        $this->database->open();

        $stmt = $this->database->mysqli->prepare("SELECT * FROM payement WHERE idReserv = ?");
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

    public function store($idReserv, $paye)
    {
        $this->database = new Database();
        $this->database->open();
        $statusCode = 201;

        if ($this->checkExist($idReserv)) {
            $stmt = $this->database->mysqli->prepare("UPDATE payement SET reste = ? WHERE idReserv = ?");
            $stmt->bind_param('si', $paye, $idReserv);
            $satusCode = 200;
            
        } else {
            $stmt = $this->database->mysqli->prepare("INSERT INTO payement (idReserv, avance) VALUES (?, ?)");
            $stmt->bind_param('ss', $idReserv, $paye);
        }

        if ($stmt->execute()) {
            $data = [
                'status' => $satusCode,
                'message' => "Created"
            ];
            
        } else {
            $data = [
                'status' => 500,
                'message' => "Error creating payement"
            ];
            $statusCode = 500;
        }

        $stmt->close();
        $this->database->close();

        return response($data, $statusCode);
    }
    public static function reste()
    {
    }

    public static function getReste()
    {

    }

    public static function state()
    {
        
    }
}
