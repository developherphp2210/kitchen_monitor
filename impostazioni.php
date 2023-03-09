<?php
include_once 'request/connect.php';
include_once 'request/impostazioni.php';

$database = new Database();
$db = $database->connection();
$impostazioni = new Impostazioni($db);

if ($_SERVER['REQUEST_METHOD']==='POST'){
    $impostazioni->update($_POST);
}

$res = $impostazioni->read();
$row = $res->fetch_assoc()


?>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">       
        <link rel="stylesheet" href="/css/impostazioni.css">
        <title>Admin Pannel</title>               
    </head>   
    <body>        
            <nav class="bg-dark" >
                <h3>Pannello impostazioni</h3>                
            </nav>
            <aside class="bg-dark">
                
            </aside>
            <main >
                <form action="" method="post">
                    <div class="card-body">                    
                        <div class="row mb-3">
                            <div class="form-group col-md-4">
                                <label for="ragsoc">Ragione Sociale</label>
                                <input class="form-control" name="ragsoc" value="<?=$row['ragsoc']?>" id="ragsoc">
                            </div>
                            <div class="form-group col-md-4">
                                <label for="refresh">Refresh Ordini (secondi)</label>
                                <input class="form-control" name="timer_refresh" type="number" value="<?=$row['timer_refresh']?>" id="refresh">
                            </div>                
                            <div class="form-group col-md-4">
                                <label for="max_articoli">N° Visualizzazione Ordini</label>
                                <input class="form-control" name="max_articoli" type="number" value="<?=$row['max_articoli']?>" id="max_articoli">
                            </div>                
                        </div>
                        <div class="row mb-3">
                            <div class="form-group col-md-12">
                                <label for="testo_sco">Testo Scorrevole</label>
                                <input class="form-control" type="text" name="testo_scorrevole" value="<?=$row['testo_scorrevole']?>" id="testo_sco">
                            </div>
                        </div>
                        <div class="row mb-3">
                            <div class="form-group col-md-8">
                                <label for="testo_2">Descrizione Ordine in Preparazione</label>
                                <input class="form-control" name="testo_2" value="<?=$row['testo_2']?>" id="testo_2">
                            </div>
                            <div class="form-group col-md-4">
                                <label for="colore_box_2">Colore Ordine in Preparazione</label>
                                <input class="form-control" name="colore_box_2" type="color" value="<?=$row['colore_box_2']?>" id="colore_box_2">
                            </div>
                        </div>
                        <div class="row mb-3">    
                            <div class="form-group col-md-8">
                                <label for="testo_1">Descrizione Ordine Evaso</label>
                                <input class="form-control" name="testo_1" value="<?=$row['testo_1']?>" id="testo_1">
                            </div>
                            <div class="form-group col-md-4">
                                <label for="colore_box_1">Colore Ordine Evaso</label>
                                <input class="form-control" name="colore_box_1" type="color" value="<?=$row['colore_box_1']?>" id="colore_box_1">
                            </div>       
                        </div>
                        <div class="row mb-3">
                            <div class="form-group col-md-3">
                                <label for="colore_sfondo">Colore di Sfondo</label>
                                <input class="form-control" name="colore_sfondo" type="color" value="<?=$row['colore_sfondo']?>" id="colore_sfondo">
                            </div>
                            <div class="form-group col-md-3">
                                <label for="colore_testo">Colore Testo</label>
                                <input class="form-control" name="colore_testo" type="color" value="<?=$row['colore_testo']?>" id="colore_testo">
                            </div>                        
                            <div class="form-group col-md-3">
                                <label for="colore_header">Colore di Sfondo Testata</label>
                                <input class="form-control" name="colore_header" type="color" value="<?=$row['colore_header']?>" id="colore_header">
                            </div>
                            <div class="form-group col-md-3">
                                <label for="colore_footer">Colore di Sfondo testo Scorrevole</label>
                                <input class="form-control" name="colore_footer" type="color" value="<?=$row['colore_footer']?>" id="colore_footer">
                            </div>
                        </div>    
                        </div>
                    </div>    
                    <div class="card-footer">
                     <button class="btn btn-primary" type="submit">Memorizza</button>
                    </div> 
                </form>
            </main>                    
    </body>
    <?php
          if ($_SERVER['REQUEST_METHOD']==='POST'){
            echo "<script>
                alert('DATI MEMORIZZATI');
            </script>";
          };
        ?>
    <script src="/js/bootstrap.bundle.min.js"></script>        
</html>