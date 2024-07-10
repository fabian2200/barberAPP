function login(){
  $.ajax({
    type: $('#form_inicio_sesion').attr('method'), 
    url: "api/login.php",
    data: $('#form_inicio_sesion').serialize(),
    beforeSend: function(){
      let timerInterval
      Swal.fire({
        title: 'Validando datos',
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
      var jsonData = JSON.parse(data);
      var icono = "";
      if(jsonData.success == 1){
        icono = "success";
        setTimeout(function(){ window.location = "admin.php" }, 2500);
      }else{
        icono = "error";
      }
      Swal.fire({
        position: 'center',
        icon: icono,
        title: jsonData.error,
        showConfirmButton: false,
        timer: 2500
      });
    } 
  });
}