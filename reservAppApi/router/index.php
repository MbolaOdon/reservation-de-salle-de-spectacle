<?php

class Router {
    private $handled = false;

    function __construct() {}

    /**
     * @var $route string the route to handle
     * @var $controller string the controller to render
     */
    public function get($route, $controller, $action)
    {
        if($_SERVER['REQUEST_METHOD'] !== 'GET') {
            return false;
        }else{
            $uri = $_SERVER['REQUEST_URI'];
            if($uri == $route) {
                $this->handled = true;
                include_once(controllers . $controller);
                return $action;
            }
            else{
                return false;
            }
        }
        
        
    }


    /**
     * @var $router
     * @var $controller
     */
    public function post($route, $controller)
    {
        if($_SERVER['REQUEST_METHOD'] !== 'POST') {
            return false;
        }
        
        $uri = $_SERVER['REQUEST_URI'];
        if($uri === $route) {
            $this->handled = true;
            return include_once (controllers . $controller);
        }
    }

    /**
     * Summary of __destruct
     *handle non existe route
     */
    function __destruct() {
        if(!$this->handled) {
            return include_once(controllers . 'error404');
        }
    }

}