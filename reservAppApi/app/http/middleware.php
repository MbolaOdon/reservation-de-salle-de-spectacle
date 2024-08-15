<?php
class Middleware {
   public static function checkRequestMethod($method) {
        if ($_SERVER['REQUEST_METHOD'] != $method) {
    
            $data = ['status' => 405, 'message' => $_SERVER["REQUEST_METHOD"] . "Method Not Allowed",];
            
            return response($data, 405);
        }
    }

    public static function compare($params1, $params2) {
        if($params1 == $params2) {
            return true;
        }else {
            return false;
        }
    }
}



