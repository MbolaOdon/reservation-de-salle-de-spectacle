<?php

function response($response, $http_response_code) {
     http_response_code($http_response_code);
     header('Content-Type: application/json');
     echo json_encode($response);
 }