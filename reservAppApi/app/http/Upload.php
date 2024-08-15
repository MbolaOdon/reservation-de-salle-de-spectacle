<?php 
require_once(ROOT . 'app/Database.php');

class Upload {
    public $target_dir = ROOT . 'public/uploads/';
    public $salle_dir = "salles/";
    public $client_dir = "client";
    public $propr_dir = "propr";
    
    private Database $database;

    public function uploadSalle($request) {
        $salle_dir = $this->salle_dir;
        $target_dir = $this->target_dir;
        $res = array();
        $extension = array("jpeg", "jpg", "png", "gif");

        if (!empty($_FILES['filetoupload']['name'][0])) {  // Fixed condition
            foreach ($_FILES["filetoupload"]['tmp_name'] as $key => $tmp_name) {
                $file_name = $_FILES["filetoupload"]["name"][$key];
                $file_tmp = $_FILES["filetoupload"]["tmp_name"][$key];
                $ext = pathinfo($file_name, PATHINFO_EXTENSION);

                $target_file = $target_dir . $salle_dir . $file_name;

                if (in_array($ext, $extension)) {
                    if (!file_exists($target_file)) {
                        move_uploaded_file($file_tmp, $target_file);
                        $this->database = new Database();
                        $this->database->open();
                        $qr2 = $this->database->mysqli->query('INSERT INTO photos (design, interne_design, idSalle) VALUES("'.$file_name.'","'.$file_name.'","'.$request.'")');
                        $res['data']['image'][] = $file_name;
                    } else {
                        $filename = basename($file_name, '.' . $ext);  // Fixed the basename usage
                        $newFileName = $filename . time() . "." . $ext;
                        $target_file = $target_dir . $salle_dir . $newFileName;
                        move_uploaded_file($file_tmp, $target_file);
                        $this->database->open();
                        $qry2 = $this->database->mysqli->query('INSERT INTO photos (design, interne_design, idSalle) VALUES("'.$newFileName.'","'.$newFileName.'","'.$request.'")');
                        $res['data']['image'][] = $newFileName;
                    }
                } else {
                    $res['errors'][] = "$file_name has an invalid extension.";
                }
            }
        } else {
            $res['status'] = 'fail';
            $res['message'] = 'Please provide an image.';
        }

        return $res;  // Return the response data
    }

    public function uploadProp() {
        // Implement this method as needed
    }

    public function uploadCient() {
        // Implement this method as needed
    }
}
