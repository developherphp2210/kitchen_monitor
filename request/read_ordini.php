<?php
header("Access-Control-Allow-Origin: *");
header('Access-Control-Allow-Headers: Content-Type');
header("Content-Type: application/json; charset=UTF-8");

include_once 'connect.php';
include_once 'impostazioni.php';
include_once 'ordini.php';

$database = new Database();
$db = $database->connection();

$impostazioni = new Impostazioni($db);
$ordini = new Ordini($db);

$limit = $impostazioni->getMaxArt();

$res = $ordini->read(5);

$result;
if ($res) {
    while ($row = $res->fetch_assoc()){
        $result[]=$row;
    }
}        

http_response_code(200);
echo json_encode($result); 
?>