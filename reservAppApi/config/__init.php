<?php

// /**
//  * define app constants
//  */
// spl_autoload_register(function ($class) {
//     require __DIR__ . "../controller/$class.php";
// });
// define('ROOT', str_replace('index.php', '', $_SERVER['SCRIPT_FILENAME']));

// define('root', $_SERVER['DOCUMENT_ROOT'] . '/');
// define('controller', root . 'controller/');
// $parts = explode("/", $_SERVER["REQUEST_URI"]);
// $controller = ucfirst($parts[3]);
// // if ($parts[1] != "reservAppApi") {
// //     http_response_code(404);
// //     exit;
// // }
// //$actions = $parts[2] . $parts[3];
// //$id =$parts[4] ?? null;
// var_dump($parts);
// var_dump($controller);

  // DB Params
  define('DB_HOST', 'localhost');
  define('DB_USER', 'root');
  define('DB_PASS', '');
  define('DB_NAME', 'salle_reservation');

  define('root', $_SERVER['DOCUMENT_ROOT'] . '/');
   define('controllers', '/app/controllers/');
  // App Root
  define('ROOT', str_replace('index.php', '', $_SERVER['SCRIPT_FILENAME']));
  // URL Root
  define('URLROOT', 'http://localhost/reservAppApi/');
  // Site Name
  define('SITENAME', 'Plateforme');

  define('APPVERSION','1.0.0');

  $qr =" CREATE VIEW reservation_salle_client AS  SELECT reservation.idReserv,
  reservation.idSalle
  reservation.idCli,
  reservation.dateDebut,
  reservation.dateFin,
  reservation.validation,
  reservation.nbrSalle,
  salle_image.subTitre,
  salle_image.titre,
  salle_image.design,
  client.nomPrenom,
  client.phone,
  client.email
FROM salle_image
INNER JOIN reservation ON salle_image.idSalle = reservation.idSalle
INNER JOIN client ON reservation.idCli = client.idCli
INNER JOIN Proprietaire ON salle_image.idPro = Proprietaire.idPro;";