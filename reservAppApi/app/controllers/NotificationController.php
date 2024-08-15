<?php
require_once(ROOT . 'app/Database.php');
class Notifier extends Controller{
    private $notification;

    public function __construct()
    {
        $this->notification = $this->model('Notification');
    }

    public function getNotif($id, $request) {

    }
    public function add($id, $request) {

    }

    public function destroy($id, $request) {

    }
}