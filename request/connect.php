<?php

class Database {

    private string $dbname = 'kitchen_monitor';
    private string $password = '';
    private string $username = 'root';
    private string $servername = 'localhost';

    public function connection(){
        try{

            $conn = new mysqli($this->servername, $this->username, $this->password, $this->dbname);
            // $conn->set_charset("utf-8");            
            return $conn;
        }
        catch (Exception $e){
            echo "Connection error ".$e->getMessage();
            exit;
        }
    }
}