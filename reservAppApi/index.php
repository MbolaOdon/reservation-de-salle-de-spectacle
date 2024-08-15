<?php
error_reporting(E_ERROR | E_PARSE);
ini_set('display_errors', '0');
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Credentials: true");
header("Access-Control-Max-Age: 86400"); 
header('Access-Control-Allow-Headers:Origin,Content-Type,Accept,Authorization,X-Auth-Token,X-Requested-With');
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS");         
if (isset($_SERVER['HTTP_ACCESS_CONTROL_REQUEST_HEADERS'])) {
    header("Access-Control-Allow-Headers: {$_SERVER['HTTP_ACCESS_CONTROL_REQUEST_HEADERS']}");
}

require_once __DIR__ . '/config/__init.php';

require_once(ROOT.'app/controller.php');
include_once(ROOT. 'app/ErrorHandler.php');
include_once(ROOT. 'app/http/response.php');
include_once(ROOT. 'app/http/middleware.php');
set_exception_handler("ErrorHandler::handleException");

header('Content-Type: application/json; charset=UTF-8');

$request_data =  json_decode(file_get_contents('php://input'), true);

    // Check for Authorization header
$headers = getallheaders();
if (isset($headers['Authorization'])) {
    $authHeader = $headers['Authorization'];
        // Process the Authorization header as needed
        // For example, verify a JWT or check a token
}


// separe les parametres
$params = explode('/', $_GET['p']);

// test if params exists 
if($params[0]!= ""){
    $controller = ucfirst($params[0]);
    $action = $params[1];
    $id = $params[2];
//var_dump($controller);
    if($controller == 'Upload'){
        require_once(ROOT . 'app/http/' . $controller .'.php');
        $controller = new $controller();
        unset($params[0]);
        unset($params[1]);
        call_user_func_array([$controller, $action], [$id]);
        //var_dump($controller);
    }
    if($controller != 'Upload') {
        //var_dump($controller);
        require_once(ROOT . controllers . $controller .'.php');
        $controller = new $controller();
        if(method_exists($controller, $action)){
            unset($params[0]);
            unset($params[1]);
            //var_dump($params);
            call_user_func_array([$controller, $action], [$id, $request_data]);
            //$controller->$action();
        }else{
            http_response_code(404);
            echo "page not found";
        }
    }
//var_dump($controller, $action, $params[2]);
    //require_once(ROOT . controllers . $controller .'.php');

    // $controller = new $controller();

    // if(method_exists($controller, $action)){
    //     unset($params[0]);
    //     unset($params[1]);
    //     //var_dump($params);
    //     call_user_func_array([$controller, $action], [$id, $request_data]);
    //     //$controller->$action();
    // }else{
    //     http_response_code(404);
    //     echo "page not found";
    // }

}else{

}
?>
