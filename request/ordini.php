<?php

class Ordini{

    private $conn;    

    private int $id;
    private int $num_ordine;
    private int $stato;    
    

    public function __construct($db){
        $this->conn = $db;
    }
    
    function read(int $limit){

        
        $sql = "select * from ordini where stato <2 order by stato desc,comanda limit ". $limit ;                  
                
        $stmt = $this->conn->query($sql);        
                
        return $stmt;

    }

    public function stato_comanda(string $comanda,string $stato): string{

        $data = date('Y/m/d');
        $sql = "select id from ordini where comanda=".$comanda." and CAST(created AS DATE ) = '".$data."'";
        $res = $this->conn->query($sql);
        if ($res && $res->num_rows){
            $result = $res->fetch_assoc();
            $sql = "update ordini set stato=".$stato." where id=".$result['id'];
            $string = 'La Comanda n° '.$comanda.' è stata aggiornata correttamente';
        } else {
            $sql = "insert into ordini (comanda,stato) values(".$comanda.",".$stato.")";
            $string = 'Comanda n° '.$comanda.' inserita correttamente';
        }
        $res = $this->conn->query($sql);
        if ($res){
            return $string;
        } else {
            return "Errore inserimento/aggiornamento comanda N°".$comanda;
        }
    }
}

?>