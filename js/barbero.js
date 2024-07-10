function GuardarBarbero() {
    var paqueteDeDatos = new FormData();
    paqueteDeDatos.append('imagen', $('#foto_perfil')[0].files[0]);
    paqueteDeDatos.append('nombre', $('#nombre').prop('value'));
    paqueteDeDatos.append('edad', $('#edad').prop('value'));
    paqueteDeDatos.append('promedio', $('#promedio').prop('value'));
    paqueteDeDatos.append('idbarberia', $('#id_barberia').prop('value'));
    
    $.ajax({
      type: $('#form_registro_barbero').attr('method'), 
      url: "api/guardar_barbero.php",
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
            location.reload();
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