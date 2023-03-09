<?php

class Impostazioni{

    private $conn;
    private string $table_name = "impostazioni";

    private int $id;
    private int $timer_refresh;
    private int $max_articoli;
    private string $ragsoc;
    

    public function __construct($db){
        $this->conn = $db;
    }
    
    public function read(){
        
        $sql = "select * from ". $this->table_name;                  
                
        $stmt = $this->conn->query($sql);        
                
        return $stmt;

    }

    public function getMaxArt() :int{

        $sql = "select max_articoli from ". $this->table_name;                  
                
        $stmt = $this->conn->query($sql);
        
        $art = $stmt->fetch_assoc();
                
        return $art['max_articoli'];
    }

    public function update($dati): void{       

        $sql  = "update ".$this->table_name." ";
        $sql .= "set max_articoli = ". $dati['max_articoli'] .",";
        $sql .= "timer_refresh = ".$dati['timer_refresh'].", ragsoc = '".$dati['ragsoc'] ."' ,";
        $sql .= "testo_scorrevole = '".$dati['testo_scorrevole']."', testo_1 = '".$dati['testo_1'] ."',";
        $sql .= "testo_2 = '".$dati['testo_2'] ."', colore_sfondo = '".$dati['colore_sfondo']."',";
        $sql .= "colore_testo = '".$dati['colore_testo']."', colore_header = '".$dati['colore_header'] ."',";
        $sql .= "colore_footer = '".$dati['colore_footer']."', colore_box_1 = '".$dati['colore_box_1'] ."',";
        $sql .= "colore_box_2 = '".$dati['colore_box_2']. "' where id=1";
    
        $stmt = $this->conn->query($sql);        
    }
    
}

?>