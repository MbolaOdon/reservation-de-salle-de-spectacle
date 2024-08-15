<?php
class Controller{
  public function model($model){
    // Require model file
    require_once (ROOT . '/app/models/' . $model . '.php');

    // Instatiate model
    return new $model();
  }

    //load view
    public function controller($controller, $data = []){
        // Check for view file
        if(file_exists(ROOT.'app/controllers/' . $controller . '.php')){
          require_once (ROOT.'app/controllers/' . $controller . '.php') ;
        } else {
          // View does not exist
          die('View does not exist');
        }
      }

      public function render(string $file){
         
      }
}