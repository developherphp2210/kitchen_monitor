<?php
header("Access-Control-Allow-Origin: *");
header('Access-Control-Allow-Headers: Content-Type');
header("Content-Type: application/json; charset=UTF-8");

// include_once 'connect.php';


// $database = new Database();
// $db = $database->connection();

$password = $_REQUEST['password'];

if ($password==='admin'){

http_response_code(200);
echo json_encode('ok'); 
}
else {
    http_response_code(200);
    echo json_encode('Password Sbagliata'); 
}
?>