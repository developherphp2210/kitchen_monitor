document.forms['myFormId'].addEventListener('submit', (event) => {
    event.preventDefault();    
    fetch(event.target.action, {
        method: 'POST',
        body: new URLSearchParams(new FormData(event.target)) 
    }).then((response) => {
        if (!response.ok) {
          throw new Error(`HTTP error! Status: ${response.status}`);
        }
        return response.json(); // or response.text() or whatever the server sends
    }).then((body) => {
        // TODO handle body
        if (body==='ok'){
            window.location.href= 'impostazioni.php';
        } else {
            alert(body);
        }
    }).catch((error) => {
        // TODO handle error
        alert(error);
    });
});