<?php
require_once(ROOT . 'app/Database.php');
class Upload {
    public  $target_dir = ROOT. 'public/uploads/';
    public   $salle_dir = "salles/";
    public  $client_dir = "client";
    public   $propr_dir = "propr";
    //public  $res = array();
    //public  $extension = array("jpeg","jpg","png","gif");

    private Database $database;

    public function uploadSalle($request) {
        $salle_dir = $this->salle_dir;
                $target_dir = $this->target_dir ;
                $res = array();
                $extension = array("jpeg","jpg","png","gif");
        if(!empty($_FILES['filetoupload']['name'][0] != "")){
            foreach($_FILES["filetoupload"]['tmp_name'] as $key=>$tmp_name) {
                $file_name = $_FILES["filetoupload"]["name"][$key];
                $file_tmp = $_FILES["filetoupload"]["tmp_name"][$key];
                $ext = pathinfo($file_name, PATHINFO_EXTENSION);
                

                $target_file = $target_dir . $salle_dir . $file_name;
                $id=0;
                if(in_array($ext, $extension)) {
                    if(!file_exists($target_file)) {
                        move_uploaded_file($file_tmp, $target_file);
                       // move_uploaded_file($file_tmp = $_FILES['filetoupload']["tmp_name"][$key], $target_file);
                        $this->database = new Database();
                        $this->database->open();
                        $qr2 = $this->database->mysqli->query('INSERT INTO photos (design, interne_design, idSalle) VALUES("'.$file_name.'","'.$file_name.'","'.$request.'")');
                        $res['data']['image'][] = $file_name;
                        //var_dump($this->res);
                        $data = ['data'=>$res];
                        //return response($data, 200);

                    }else {
                        $this->database = new Database();
                        $filename =  basename($file_name, $ext);
                        $newFileName = $filename.time().".".$ext;
                        $target_file = $this->target_dir . $newFileName;
                        $this->database->open();
                        move_uploaded_file($file_tmp = $_FILES["filetoupload"]["tmp_name"][$key], $target_file);
                        $qry2 = $this->database->mysqli->query('INSERT INTO photos (design, interne_design, idSalle) VALUES("'.$file_name.'","'.$file_name.'","'.$request.'")');
                        $this['data']['image'][] = $newFileName;
                        // $data = ['data'=>$this->res];
                        // return response($data, 200);
                    }
                }else {
                    array_push($res, "$file_name, ");
                    //return response($this->res, 500);
                }
            }
        }else{
            $res['data'] = array();
            $res['status'] = 'fail';
            $res['message'] = 'Please passed image';

            //return response($this->res, 202);
        }
    }


    // public function uploadSalle($request) {
    //     // 1. Changed condition to check if files are uploaded correctly
    //     if (!empty($_FILES['filetoupload']['name'][0])) {
    //         foreach ($_FILES["filetoupload"]['tmp_name'] as $key => $tmp_name) {
    //             $file_name = $_FILES["filetoupload"]["name"][$key];
    //             $file_tmp = $_FILES["filetoupload"]["tmp_name"][$key];
    //             $ext = pathinfo($file_name, PATHINFO_EXTENSION);
    
    //             $target_file = $this->target_dir . $this->salle_dir . $file_name;
                
    //             if (in_array($ext, $this->extension)) {
    //                 if (!file_exists($target_file)) {
    //                     // 2. Removed unnecessary variable `$id` initialization
    //                     // 3. Fixed the `move_uploaded_file` call
    //                     move_uploaded_file($file_tmp, $target_file);
    //                     $this->database = new Database();
    //                     $this->database->open();
    //                     $qr2 = $this->database->mysqli->query('INSERT INTO photos (design, interne_design, idSalle) VALUES("' . $file_name . '","' . $file_name . '","' . $request . '")');
    //                     $this->res['data']['image'][] = $file_name;
    
    //                 } else {
    //                     // 4. Handled file renaming properly
    //                     $filename = basename($file_name, '.' . $ext);
    //                     $newFileName = $filename . time() . "." . $ext;
    //                     $target_file = $this->target_dir . $this->salle_dir . $newFileName;
    //                     move_uploaded_file($file_tmp, $target_file);
    //                     $this->database->open();
    //                     $qry2 = $this->database->mysqli->query('INSERT INTO photos (design, interne_design, idSalle) VALUES("' . $newFileName . '","' . $newFileName . '","' . $request . '")');
    //                     $this->res['data']['image'][] = $newFileName;
    //                 }
    //             } else {
    //                 // 6. Added error handling for invalid file extensions
    //                 $this->res['errors'][] = "$file_name has an invalid extension.";
    //             }
    //         }
    //     } else {
    //         $this->res['status'] = 'fail';
    //         $this->res['message'] = 'Please provide an image.';
    //     }
    //     // 7. Returned the `$res` array at the end of the method
    //     return $this->res;
    // }
    

    public function uploadProp() {

    }
    public function uploadCient() {

    }
}