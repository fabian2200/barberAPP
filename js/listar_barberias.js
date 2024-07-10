var barberias = [];

$( document ).ready(function() {
    obtener_datos();
});

function obtener_datos() {
   $.ajax({
        url : 'api/listar_barberias.php',
        type : 'GET',
        dataType : 'json',
        success : function(json) {
            barberias = json;
            armar_lista(barberias);
        },
        error : function(xhr, status) {
            alert('Disculpe, existió un problema');
        },
    });
}

function armar_lista(barberias) {
   
    var div = document.getElementById('contenido');
    barberias.Barberias.forEach(function(item){
       var col6 = document.createElement("div");
       col6.setAttribute("class","col-lg-6");
       col6.setAttribute("id","item");
       var card = document.createElement("div");
       card.setAttribute("class","card");
       var row = document.createElement("div");
       row.setAttribute("class","row");
       var col4 = document.createElement("div");
       col4.setAttribute("class","col-lg-4");
       var img = document.createElement("img");
       img.setAttribute("src", "logos/"+item.logo);
       img.setAttribute("style", "height: 150pt !important")
       var col62 = document.createElement("div");
       col62.setAttribute("class","col-lg-6");
       var nombre = document.createElement("h5");
       nombre.setAttribute("id","name");
       nombre.innerHTML = item.nombre;
       var direccion = document.createElement("h6");
       direccion.innerHTML = "Direccion: "+item.direccion;
       var ciudad = document.createElement("h6");
       ciudad.innerHTML = "Ciudad: "+item.ciudad;
       var horario = document.createElement("h6");
       horario.innerHTML = "Direccion: "+item.horario;
       var telefono = document.createElement("h6");
       telefono.innerHTML = "Direccion: "+item.telefono;
       var propietario = document.createElement("h6");
       propietario.innerHTML = "Propietario: "+item.propietario;
       var a = document.createElement("a");
       a.setAttribute("id","config");
       a.setAttribute("href","edit_barberias.php?id="+item.id);
       var i = document.createElement("i");
       i.setAttribute("class","fas fa-cogs fa-2x");
       a.appendChild(i);
       col62.appendChild(nombre);
       col62.appendChild(direccion);
       col62.appendChild(ciudad);
       col62.appendChild(horario);
       col62.appendChild(telefono);
       col62.appendChild(propietario);
       col4.appendChild(img);
       row.appendChild(col4);
       row.appendChild(col62);
       row.appendChild(a);
       card.appendChild(row);
       col6.appendChild(card);
       div.appendChild(col6);
    });  
}