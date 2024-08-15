<?php
$host= "localhost";
$user="root";
$password="";
$database="salle_reservation";

$conn = mysqli_connect($host, $user, $password, $database);

if(!$conn) {
    die("connection faleid" .mysqli_connect_error());
}

?>