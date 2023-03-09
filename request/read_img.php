<?php
header("Access-Control-Allow-Origin: *");
header('Access-Control-Allow-Headers: Content-Type');
header("Content-Type: application/json; charset=UTF-8");

$result = scandir('../img');

http_response_code(200);
echo json_encode($result); 
?>