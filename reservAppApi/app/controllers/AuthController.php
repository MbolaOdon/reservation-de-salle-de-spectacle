<?php

class AuthController extends Controller
{
    private $clientModel;

    public function __construct()
    {
        $this->clientModel = $this->model('Client');
    }
    public function index()
    {
        //$this->loadModel("User");
        //$this->loadModel("Admin");
        //$this->controller('login');

    }
    public function register($id, $request)
    {
        if ($_SERVER['REQUEST_METHOD'] != 'POST') {

            $data = ['status' => 405, 'message' => $_SERVER["REQUEST_METHOD"] . "Method Not Allowed",];

            return response($data, 405);
        }
        $client =  new Client();
        $client->save(
            $request['nomPrenom'],
            $request['phone'],
            $request['adresse'],
            $request['email'],
            $request['password'],
            $request['password_confirmed']
        );
        //return response($request);

    }
    public function login($id, $request)
    {
        if ($_SERVER['REQUEST_METHOD'] != 'POST') {

            $data = ['status' => 405, 'message' => $_SERVER["REQUEST_METHOD"] . "Method Not Allowed",];

            return response($data, 405);
        }
        $client =  new Client();
        $client->login_check(
            $_POST['login'],
            $_POST['password'],

        );
        //return response($request, 200);
    }

    public function getAll()
    {
        if ($_SERVER['REQUEST_METHOD'] != 'GET') {

            $data = ['status' => 405, 'message' => $_SERVER["REQUEST_METHOD"] . "Method Not Allowed",];

            return response($data, 405);
        }
        $client = new Client();
        $rows = $client->all();

        return response($rows, 200);
    }

    public function getUser() {
        if ($_SERVER['REQUEST_METHOD'] != 'GET') {

            $data = ['status' => 405, 'message' => $_SERVER["REQUEST_METHOD"] . "Method Not Allowed",];

            return response($data, 405);
        }
        $client = new Client();
        $rows = $client->all();

        return response($rows, 200);
    }
    public function modify()
    {
        $client = new Client();
    }

    public function destroy($id)
    {
        // Middleware::checkRequestMethod('DELETE');
        if ($_SERVER['REQUEST_METHOD'] != 'DELETE') {

            $data = ['status' => 405, 'message' => $_SERVER["REQUEST_METHOD"] . "Method Not Allowed",];

            return response($data, 405);
        }

        $client = new Client();
        if ($client->find(intval($id))) {
            if (!$client->delete(intval($id))) {
                $data = [
                    'status' => 500,
                    'message' => "Error deleting client"
                ];
                return response($data, 500);
            };

            $data = ['status' => 200, 'message' => "client deleted ",];
            return response($data, 200);
        } else {
            $data = ['status' => 404, 'message' => 'client not found',];
            return response($data, 404);
        }
    }
    public function destroyMany($ids)
    {
        if ($_SERVER['REQUEST_METHOD'] != 'DELETE') {

            $data = ['status' => 405, 'message' => $_SERVER["REQUEST_METHOD"] . "Method Not Allowed",];

            return response($data, 405);
        }
        $client = new Client();
        $ids = isset($ids) ? $ids : [];
        if (empty($ids)) {
            $data = [
                'status' => 400,
                'message' => 'No IDs provided'
            ];
            return response($data, 400);
        }

        $client->deleteMany($ids);

        $data = [
            'status' => 200,
            'message' => 'Clients deleted successfully'
        ];
        return response($data, 200);
    }
    public function get_user_by_Id($id)
    {
        var_dump($id);
    }

    function __destruct()
    {

        return false;
    }
}
