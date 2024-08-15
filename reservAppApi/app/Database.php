<?php
class Database {
    public mysqli $mysqli;
    // public function __construct(private string $host, private string $name, private string $user, private string $password){

    // }
    public function getConnection() {
       // mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);

        $this->mysqli = new mysqli(DB_HOST, DB_USER, DB_PASS, DB_NAME);

/* Set the desired charset after establishing a connection */
        $this->mysqli->set_charset('utf8mb4');
        if ($this->mysqli->connect_errno) {
           return ('mysqli connection error: ' . $this->mysqli->connect_error);
        }
        
        /* Set the desired charset after establishing a connection */
        $this->mysqli->set_charset('utf8mb4');
        if ($this->mysqli->errno) {
            //return response('mysqli error: ' . $this->mysqli->error);
            throw new RuntimeException('mysqli error: ' . $this->mysqli->error);
        }
    }

    public function open() {
        $this->getConnection();
    }
    public function close(){
        $this->mysqli->close();
    }
}

