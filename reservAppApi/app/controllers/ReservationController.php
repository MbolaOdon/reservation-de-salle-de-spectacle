<?php

class ReservationController extends Controller
{
    private $reservModel;

    public function __construct()
    {
        $this->reservModel = $this->model('Reservation');
    }
    public function getAll()
    {

        if ($_SERVER['REQUEST_METHOD'] != 'GET') {

            $data = ['status' => 405, 'message' => $_SERVER["REQUEST_METHOD"] . "Method Not Allowed",];

            return response($data, 405);
        }

        $reserv = new Reservation();
        $rows = $reserv->all();

        return response($rows, 200);
    }

    public function getReservClient($id, $request)
    {

        if ($_SERVER['REQUEST_METHOD'] != 'GET') {

            $data = ['status' => 405, 'message' => $_SERVER["REQUEST_METHOD"] . "Method Not Allowed",];

            return response($data, 405);
        }

        $reserv = new Reservation();
        $rows = $reserv->reservImage($id);

        return response($rows, 200);
    }

    public function getReservProp($id, $request)
    {

        if ($_SERVER['REQUEST_METHOD'] != 'GET') {

            $data = ['status' => 405, 'message' => $_SERVER["REQUEST_METHOD"] . "Method Not Allowed",];

            return response($data, 405);
        }

        $reserv = new Reservation();
        $rows = $reserv->reservImageProp($id);

        return response($rows, 200);
    }

    

    public function add($id, $request)
    {
        if ($_SERVER['REQUEST_METHOD'] != 'POST') {

            $data = ['status' => 405, 'message' => $_SERVER["REQUEST_METHOD"] . "Method Not Allowed",];

            return response($data, 405);
        }
        $reserv = new Reservation();
        $reserv->save(
            $request['nbrSalle'],
            $request['dateDebut'],
            $request['dateFin'],
            $request['validation'],
            $request['idSalle'],
            $request['idCli']
        );
    }

    public function modify($id, $request)
    {
        if ($_SERVER['REQUEST_METHOD'] != 'PUT') {

            $data = ['status' => 405, 'message' => $_SERVER["REQUEST_METHOD"] . "Method Not Allowed",];

            return response($data, 405);
        }
        $reserv = new Reservation();
        $reserv->update(
            $id,
            $request['nbrSalle'],
            $request['dateDebut'],
            $request['dateFin'],
            $request['validation'],
            $request['idSalle'],
            $request['idCli']
        );
    }


    public function destroy($id)
    {
        if ($_SERVER['REQUEST_METHOD'] != 'DELETE') {

            $data = ['status' => 405, 'message' => $_SERVER["REQUEST_METHOD"] . "Method Not Allowed",];

            return response($data, 405);
        }
        $reserv = new Reservation();
        if ($reserv->find(intval($id))) {
            if (!$reserv->delete(intval($id))) {
                $data = [
                    'status' => 500,
                    'message' => "Error deleting Salle"
                ];
                return response($data, 500);
            };

            $data = ['status' => 200, 'message' => "Salle deleted ",];
            return response($data, 200);
        } else {
            $data = ['status' => 404, 'message' => 'Salle not found',];
            return response($data, 404);
        }
    }
    public function destroys($ids)
    {
        if ($_SERVER['REQUEST_METHOD'] != 'DELETE') {

            $data = ['status' => 405, 'message' => $_SERVER["REQUEST_METHOD"] . "Method Not Allowed",];

            return response($data, 405);
        }
        $reserv = new Reservation();
        $ids = isset($ids) ? $ids : [];
        if (empty($ids)) {
            $data = [
                'status' => 400,
                'message' => 'No IDs provided'
            ];
            return response($data, 400);
        }

        $reserv->deleteMany($ids);

        $data = [
            'status' => 200,
            'message' => 'Salles deleted successfully'
        ];
        return response($data, 200);
    }

    public function myReservation($id, $request){
        if ($_SERVER['REQUEST_METHOD'] != 'GET') {

            $data = ['status' => 405, 'message' => $_SERVER["REQUEST_METHOD"] . "Method Not Allowed",];

            return response($data, 405);
        }

        $reserv = new Reservation();
        $rows = $reserv->myReservation($id);

        return response($rows, 200);
    }

    public function validate($id) {
        if ($_SERVER['REQUEST_METHOD'] != 'PUT') {

            $data = ['status' => 405, 'message' => $_SERVER["REQUEST_METHOD"] . "Method Not Allowed",];

            return response($data, 405);
        }

        $reserv = new Reservation();
        $rows = $reserv->setValidate($id);

        
    }
}