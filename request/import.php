<?php
header("Access-Control-Allow-Origin: *");
header('Access-Control-Allow-Headers: Content-Type');
header("Content-Type: application/json; charset=UTF-8");

include_once 'connect.php';
include_once 'ordini.php';

$database = new Database();
$db = $database->connection();

$ordini = new Ordini($db);

$comanda = $_REQUEST['comanda'];
$stato = $_REQUEST['stato'];

$result = $ordini->stato_comanda($comanda,$stato);

http_response_code(200);
echo json_encode($result); 
?>