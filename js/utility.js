var elem = document.documentElement;
var timer_refresh = 0;
var testo_1 = '';
var testo_2 = '';

function openFullscreen() {  
  if (elem.requestFullscreen) {
    elem.requestFullscreen(); 
    document.getElementById('title').setAttribute('onclick','closeFullscreen()');   
  }
}

function closeFullscreen(){
  if (document.exitFullscreen) {
    document.exitFullscreen();  
    document.getElementById('title').setAttribute('onclick','openFullscreen()');
  }
}

window.onload = setInterval(Orologio,6000);

function addZero(i) {
  if (i < 10) {
    i = "0" + i;
  }
  return i;
}

function Orologio() {

  var d = new Date();    
  var ora = addZero(d.getHours());
  var min = addZero(d.getMinutes());
  // var sec = addZero(d.getSeconds());
  var gio = addZero(d.getDate());
  var mes = addZero(d.getMonth()+1);
  var anno = addZero(d.getFullYear());
  document.getElementById("orologio").innerHTML=gio+'/'+mes+'/'+anno+' - '+ora+":"+min;
}

async function request_order() {    

  const checkOrder = () => {       
    var interval = setInterval(() => {             
      fetch("/request/read_ordini.php")
        .then((response) => {
            return response.json();
        }).then((resp) => {
            clearInterval(interval);
            create_order(resp)
        });
    }, timer_refresh);

    function create_order(ordini){
      var aside = document.getElementById('lista_ordine');
      aside.innerHTML = '';
      var count=1;
      ordini.forEach(element => {
        // mi creo la testa del box ordini
        let main_div = document.createElement('div');
        main_div.setAttribute('class','box');        
        main_div.classList.add('pos'+count);
        if (element['stato']=='0'){
          main_div.classList.add('status_1');
        } else {
          main_div.classList.add('status_2');
        }
        let head_div = document.createElement('div');
        head_div.classList.add('order');
        let h3 = document.createElement('h3');
        h3.innerText = 'Ordine N°';
        let line_bottom = document.createElement('div');
        line_bottom.classList.add('line_bottom');
        head_div.append(h3);
        head_div.append(line_bottom);
        main_div.append(head_div);
        // mi creo il numero ordine
        let number_div = document.createElement('div');
        number_div.setAttribute('class','numbe_order');
        let h1 = document.createElement('h1');
        h1.innerText = element['comanda'];
        if (element['stato']=='1'){
          h1.classList.add('transition');
        }
        number_div.append(h1);
        main_div.append(number_div);
        // mi creo il footer del box ordine
        let footer_div = document.createElement('div');
        footer_div.setAttribute('class','order');
        let line_top = document.createElement('div');
        line_top.setAttribute('class','line_top');
        let footer_h3 = document.createElement('h3');
        if (element['stato']=='0'){
          footer_h3.innerText = testo_2;
        } else {
          footer_h3.innerText = testo_1;
        } 
        footer_div.append(line_top);
        footer_div.append(footer_h3);
        main_div.append(footer_div);
        aside.append(main_div);
        count++;
      });
      setTimeout(checkOrder(), timer_refresh);
    }
  };
  (checkOrder());
};

  
function getImpo(){   
  
  // leggo i nomi dei file delle immagini

  fetch("/request/read_img.php")
   .then((response) => {
    return response.json();
   }).then((resp) => {
    let lista_foto = document.getElementById('lista_foto');
    lista_foto.innerHTML = '';
    let first = true;
    resp.forEach( elem => {          
      if (elem!='.') {
         if (elem!='..') {                        
          let img_div = document.createElement('div');
          img_div.setAttribute('class','carousel-item');
          if (first){
            first = false;
            img_div.classList.add('active');
          }        
          let img = document.createElement('img');
          img.setAttribute('src','img/'+elem);
          img.classList.add('d-block');
          img.classList.add('w-100');          
          img_div.append(img);
          lista_foto.append(img_div);        
        }
      }
     })
   });

// leggo le impostazioni della pagina
  fetch("/request/read_imp.php")
    .then((response) => {
      return response.json();
    }).then((resp) => {
      document.getElementById('title').innerText = resp['ragsoc'];
      timer_refresh = resp['timer_refresh']+'000';
      testo_1 = resp['testo_1'];
      document.documentElement.style.setProperty('--status_1',resp['colore_box_1']);    
      testo_2 = resp['testo_2'];
      document.documentElement.style.setProperty('--status_2',resp['colore_box_2']);
      document.documentElement.style.setProperty('--max_art',resp['max_articoli']);
      document.documentElement.style.setProperty('--testo',resp['colore_testo']);
      document.documentElement.style.setProperty('--sfondo',resp['colore_sfondo']);
      document.documentElement.style.setProperty('--sfondo_header',resp['colore_header']);
      document.documentElement.style.setProperty('--sfondo_footer',resp['colore_footer']);
      document.getElementById('testo').innerText = resp['testo_scorrevole'];      
      request_order();
  });

  
}

(getImpo());  