<?php
session_start();
if(isset($_SESSION['logueado'])){ 
?> 
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8" />
  <link rel="apple-touch-icon" sizes="76x76" href="../assets/img/apple-icon.png">
  <link rel="icon" type="image/png" href="../assets/img/favicon.png">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
  <title>
    Barber - APP
  </title>
  <meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0, shrink-to-fit=no' name='viewport' />
  <!--     Fonts and icons     -->
  <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700,200" rel="stylesheet" />
  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.1/css/all.css" integrity="sha384-fnmOCqbTlWIlj8LyTjo7mOUStjsKC4pOpQbqyi7RrhN7udi9RwhKkMHpvLbHG9Sr" crossorigin="anonymous">
  <!-- CSS Files -->
  <link href="assets/css/bootstrap.min.css" rel="stylesheet" />
  <link href="assets/css/now-ui-dashboard.css?v=1.5.0" rel="stylesheet" />
  <!-- CSS Just for demo purpose, don't include it in your project -->
  <link href="assets/demo/demo.css" rel="stylesheet" />
  <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
  <script type="text/javascript" src="js/guardar_barberia.js"></script>
  <script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
  <script src="sweetalert2.all.min.js"></script>
  <style type="text/css">
    .col-lg-6{
      padding-top: 30px;
    }
  </style>
</head>

<body class="">
  <div class="wrapper ">
      <?php include_once ('components/menu.php'); ?>
      <div class="panel-header panel-header-sm">
      </div>
      <div class="content">
        <div class="row">
          <div class="col-md-12">
            <div class="card">
              <div class="card-header">
                <h5 class="title">Panel de control</h5>
                <p class="category">BARBER APP<a href="https://nucleoapp.com/?ref=1712"> - Fabian Quintero</a></p>
              </div>
              <div class="card-body all-icons">
                <div class="row">       
                  <div class="col-lg-12 text-center">
                   <h4>REGISTRO DE NUEVA BARBERIA</h4>
                  </div>
                </div>
                <hr>
                <div class="row">       
                  <div class="col-lg-4 text-center">
                   
                  </div>
                  <div class="col-lg-4 text-center">
                    <img id="output" src="https://img.freepik.com/vector-gratis/plantilla-logotipo-barberia-vintage_441059-26.jpg" width="140" height="140">
                  </div>
                  <div class="col-lg-4 text-center">
                   
                  </div>
                </div>
                <br>
                <form id="form_registro_barberia" method="POST">
                  <div class="row" style="padding-right: 10%;padding-left: 10%;">
                    <div class="col-lg-6">
                      <div class="form-group">
                        <label for="exampleInputEmail1">Nombre de la Barberia</label>
                        <input id="nombre" type="text" class="form-control" id="exampleInputEmail1" placeholder="Ingrese un Nombre">
                      </div>
                    </div>
                    <div class="col-lg-6">
                      <div class="form-group">
                        <label for="exampleInputEmail1">Dirección de la Barberia</label>
                        <input id="direccion" type="text" class="form-control" id="exampleInputEmail1" placeholder="Ingrese una direccion">
                      </div>
                    </div>
                    <div class="col-lg-6">
                      <div class="form-group">
                        <label for="exampleInputEmail1">Ciudad</label>
                        <input id="ciudad" type="text" class="form-control" id="exampleInputEmail1" placeholder="Ingrese una Ciudad">
                      </div>
                    </div>
                    <div class="col-lg-6">
                      <div class="form-group">
                        <label for="exampleInputEmail1">Logo</label>
                        <input id="logo" class="form-control" type="file" accept="image/png, image/jpeg" onchange="document.getElementById('output').src = window.URL.createObjectURL(this.files[0])">
                      </div>
                    </div>
                    <div class="col-lg-6">
                      <div class="form-group">
                        <label for="exampleInputEmail1">Fecha de Registro</label>
                        <input id="fecha_registro" type="date" class="form-control" id="exampleInputEmail1">
                      </div>
                    </div>
                    <div class="col-lg-6">
                      <div class="form-group">
                        <label for="exampleInputEmail1">Fecha de Renovación</label>
                        <input id="fecha_renovacion" type="date" class="form-control" id="exampleInputEmail1">
                      </div>
                    </div>
                    <div class="col-lg-6">
                      <div class="form-group">
                        <label for="exampleInputEmail1">Propietario</label>
                        <input id="propietario" type="text" class="form-control" id="exampleInputEmail1" placeholder="Nombre del Propietario">
                      </div>
                    </div>
                    <div class="col-lg-6">
                      <div class="form-group">
                        <label for="exampleInputEmail1">Usuario</label>
                        <input id="usuario" type="text" class="form-control" id="exampleInputEmail1" placeholder="Ingrese una Usuario @fabiandres2000">
                      </div>
                    </div>
                    <div class="col-lg-6">
                      <div class="form-group">
                        <label for="exampleInputEmail1">Horario de apertura</label>
                        <input id="horarioa" type="time" class="form-control" id="exampleInputEmail1" placeholder="8AM - 9PM">
                      </div>
                    </div>
                    <div class="col-lg-6">
                      <div class="form-group">
                        <label for="exampleInputEmail1">Horario de cierre</label>
                        <input id="horarioc" type="time" class="form-control" id="exampleInputEmail1" placeholder="8AM - 9PM">
                      </div>
                    </div>
                    <div class="col-lg-12">
                      <div class="form-group">
                        <label for="exampleInputEmail1"> Telefono(celular)</label>
                        <input id="telefono" type="text" class="form-control" id="exampleInputEmail1" placeholder="ej: 3042065930">
                      </div>
                    </div>
                     <div class="col-lg-6">
                      <div class="form-group">
                        <label for="exampleInputEmail1"> Latitud </label>
                        <input id="latitud" type="text" class="form-control" id="exampleInputEmail1" placeholder="ej: 10.4959506">
                      </div>
                    </div>
                     <div class="col-lg-6">
                      <div class="form-group">
                        <label for="exampleInputEmail1"> Longitud </label>
                        <input id="longitud" type="text" class="form-control" id="exampleInputEmail1" placeholder="ej: 10.4959506">
                      </div>
                    </div>
                    <div class="col-lg-12 text-center">
                      <a style="width: 100%; color: white;" onclick="GuardarBarberia()" class="btn btn-primary">Guardar</a>
                    </div>
                  </div>
                  
                </form>
              </div>
            </div>
          </div>
        </div>
      </div>
      <footer class="footer">
        <div class=" container-fluid ">
          <div class="copyright" id="copyright">
            &copy; <script>
              document.getElementById('copyright').appendChild(document.createTextNode(new Date().getFullYear()))
            </script>, Designed by <a href="https://www.linkedin.com/in/fabian-quintero-mendez-b388b6161/" target="_blank">@fabiandres</a>. Coded by <a href="https://www.creative-tim.com" target="_blank">Creative Tim</a>.
          </div>
        </div>
      </footer>
    </div>
  </div>
  <!--   Core JS Files   -->
  <script src="assets/js/core/jquery.min.js"></script>
  <script src="assets/js/core/popper.min.js"></script>
  <script src="assets/js/core/bootstrap.min.js"></script>
  <script src="assets/js/plugins/perfect-scrollbar.jquery.min.js"></script>
  <!--  Google Maps Plugin    -->
  <script src="https://maps.googleapis.com/maps/api/js?key=YOUR_KEY_HERE"></script>
  <!-- Chart JS -->
  <script src="assets/js/plugins/chartjs.min.js"></script>
  <!--  Notifications Plugin    -->
  <script src="assets/js/plugins/bootstrap-notify.js"></script>
  <!-- Control Center for Now Ui Dashboard: parallax effects, scripts for the example pages etc -->
  <script src="assets/js/now-ui-dashboard.min.js?v=1.5.0" type="text/javascript"></script><!-- Now Ui Dashboard DEMO methods, don't include it in your project! -->
  <script src="assets/demo/demo.js"></script>
</body>
</html>
<?php
}else{  
  header('Location: index.php');
  exit();
}
?>