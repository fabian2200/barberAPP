function GuardarBarberia() {
  var paqueteDeDatos = new FormData();
  paqueteDeDatos.append('logo', $('#logo')[0].files[0]);
  paqueteDeDatos.append('nombre', $('#nombre').prop('value'));
  paqueteDeDatos.append('direccion', $('#direccion').prop('value'));
  paqueteDeDatos.append('ciudad', $('#ciudad').prop('value'));
  paqueteDeDatos.append('fecha_registro', $('#fecha_registro').prop('value'));
  paqueteDeDatos.append('fecha_renovacion', $('#fecha_renovacion').prop('value'));
  paqueteDeDatos.append('propietario', $('#propietario').prop('value'));
  paqueteDeDatos.append('usuario', $('#usuario').prop('value'));
  paqueteDeDatos.append('horarioa', $('#horarioa').prop('value'));
  paqueteDeDatos.append('horarioc', $('#horarioc').prop('value'));
  paqueteDeDatos.append('telefono', $('#telefono').prop('value'));
  paqueteDeDatos.append('latitud', $('#latitud').prop('value'));
  paqueteDeDatos.append('longitud', $('#longitud').prop('value'));

  $.ajax({
    type: $('#form_registro_barberia').attr('method'), 
    url: "api/guardar_barberia.php",
    contentType: false,
    data: paqueteDeDatos,
    processData: false,
    cache: false, 
    beforeSend: function(){
      let timerInterval
      Swal.fire({
        title: 'Guardando',
        html: 'Espere un momento...',
        timer: 400000,
        timerProgressBar: true,
        didOpen: () => {
          Swal.showLoading()
          const b = Swal.getHtmlContainer().querySelector('b')
          timerInterval = setInterval(() => {
           
          }, 100)
        },
        willClose: () => {
          clearInterval(timerInterval)
        }
      }).then((result) => {
        if (result.dismiss === Swal.DismissReason.timer) {
        }
      });          
    },
    success: function (data) { 
      debugger
      var jsonData = JSON.parse(data);
      var icono = "error";
      if (jsonData.success == 1) {
        icono = "success";
        setTimeout(function(){ 
          window.history.back();
        }, 2500);
      }
      Swal.fire({
        position: 'center',
        icon: icono,
        title: jsonData.mensaje,
        showConfirmButton: false,
        timer: 2500
      });
    } 
  });
}

function EditarBarberia() {
  var paqueteDeDatos = new FormData();
  paqueteDeDatos.append('logo', $('#logo')[0].files[0]);
  paqueteDeDatos.append('nombre', $('#nombre').prop('value'));
  paqueteDeDatos.append('direccion', $('#direccion').prop('value'));
  paqueteDeDatos.append('ciudad', $('#ciudad').prop('value'));
  paqueteDeDatos.append('fecha_renovacion', $('#fecha_renovacion').prop('value'));
  paqueteDeDatos.append('propietario', $('#propietario').prop('value'));
  paqueteDeDatos.append('horarioa', $('#horarioa').prop('value'));
  paqueteDeDatos.append('horarioc', $('#horarioc').prop('value'));
  paqueteDeDatos.append('telefono', $('#telefono').prop('value'));
  paqueteDeDatos.append('latitud', $('#latitud').prop('value'));
  paqueteDeDatos.append('longitud', $('#longitud').prop('value'));
  paqueteDeDatos.append('id', $('#idbarberia').prop('value'));

  $.ajax({
    type: $('#form_editar_barberia').attr('method'), 
    url: "api/editar_barberia.php",
    contentType: false,
    data: paqueteDeDatos,
    processData: false,
    cache: false, 
    beforeSend: function(){
      let timerInterval
      Swal.fire({
        title: 'Guardando',
        html: 'Espere un momento...',
        timer: 400000,
        timerProgressBar: true,
        didOpen: () => {
          Swal.showLoading()
          const b = Swal.getHtmlContainer().querySelector('b')
          timerInterval = setInterval(() => {
           
          }, 100)
        },
        willClose: () => {
          clearInterval(timerInterval)
        }
      }).then((result) => {
        if (result.dismiss === Swal.DismissReason.timer) {
        }
      });          
    },
    success: function (data) { 
      debugger
      var jsonData = JSON.parse(data);
      var icono = "error";
      if (jsonData.success == 1) {
        icono = "success";
        setTimeout(function(){ 
          window.history.back();
        }, 2500);
      }
      Swal.fire({
        position: 'center',
        icon: icono,
        title: jsonData.mensaje,
        showConfirmButton: false,
        timer: 2500
      });
    } 
  });
}