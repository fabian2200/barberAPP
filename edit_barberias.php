<?php
session_start();
$id = $_GET["id"];

include_once("api/conexion.php");

$sql="SELECT * FROM `barberia` where id=$id";
$resultado =  mysqli_fetch_array($con -> query($sql));

$sql2="SELECT * FROM `barbero` where id_barberia=$id";
$barberias =  $con -> query($sql2);

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
  <link rel="stylesheet" type="text/css" href="css/item.css">
  <script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
  <script src="sweetalert2.all.min.js"></script>
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
                <p class="category">BARBER APP<a href="https://nucleoapp.com/?ref=1712"> - <?php echo $resultado["horarioc"]; ?></a></p>
              </div>
              <div class="card-body all-icons">
              <div class="card-body all-icons">
                <div class="row">       
                  <div class="col-lg-12 text-center">
                   <h4>EDITAR BARBERIA</h4>
                  </div>
                </div>
                <br>
                <div class="row">       
                  <div class="col-lg-4 text-center">
                   
                  </div>
                  <div class="col-lg-4 text-center">
                    <img style="border-radius: 50%" id="output" src="logos/<?php echo $resultado["logo"] ?>" width="140" height="140">
                  </div>
                  <div class="col-lg-4 text-center">
                   
                  </div>
                </div>
                <br>
                <hr>
                <form id="form_editar_barberia" method="POST">
                  <div class="row" style="padding-right: 10%;padding-left: 10%;">
                    <div class="col-lg-6">
                      <div class="form-group">
                        <label for="exampleInputEmail1">Nombre de la Barberia</label>
                        <input id="nombre" type="text" class="form-control" id="exampleInputEmail1" value="<?php echo $resultado["nombre"] ?>">
                      </div>
                    </div>
                    <div class="col-lg-6">
                      <div class="form-group">
                        <label for="exampleInputEmail1">Dirección de la Barberia</label>
                        <input id="direccion" type="text" class="form-control" id="exampleInputEmail1" value="<?php echo $resultado["direccion"] ?>">
                      </div>
                    </div>
                    <div class="col-lg-6">
                      <div class="form-group">
                        <label for="exampleInputEmail1">Ciudad</label>
                        <input id="ciudad" type="text" class="form-control" id="exampleInputEmail1" value="<?php echo $resultado["ciudad"] ?>">
                      </div>
                    </div>
                    <div class="col-lg-6">
                      <div class="form-group">
                        <label for="exampleInputEmail1">Logo</label>
                        <input id="logo" class="form-control" type="file" accept="image/png, image/jpeg" onchange="document.getElementById('output').src = window.URL.createObjectURL(this.files[0])">
                      </div>
                    </div>
                    <div class="col-lg-12">
                      <div class="form-group">
                        <label for="exampleInputEmail1">Fecha de Renovación</label>
                        <input id="fecha_renovacion" type="date" class="form-control" id="exampleInputEmail1" value="<?php echo $resultado["fecha_renovacion"] ?>">
                      </div>
                    </div>
                    <div class="col-lg-6">
                      <div class="form-group">
                        <label for="exampleInputEmail1">Propietario</label>
                        <input id="propietario" type="text" class="form-control" id="exampleInputEmail1" value="<?php echo $resultado["propietario"] ?>">
                      </div>
                    </div>
                    <div class="col-lg-6">
                      <div class="form-group">
                        <label for="exampleInputEmail1">Horario de apertura</label>
                        <input id="horarioa" type="time" class="form-control" id="exampleInputEmail1"  value="<?php echo $resultado["horarioa"] ?>">
                      </div>
                    </div>
                    <div class="col-lg-6">
                      <div class="form-group">
                        <label for="exampleInputEmail1">Horario de cierre</label>
                        <input id="horarioc" type="time" class="form-control" id="exampleInputEmail1"  value="<?php echo $resultado["horarioc"] ?>">
                      </div>
                    </div>
                    <div class="col-lg-6">
                      <div class="form-group">
                        <label for="exampleInputEmail1"> Telefono(celular)</label>
                        <input id="telefono" type="text" class="form-control" id="exampleInputEmail1" value="<?php echo $resultado["telefono"] ?>">
                      </div>
                    </div>
                     <div class="col-lg-6">
                      <div class="form-group">
                        <label for="exampleInputEmail1"> Latitud </label>
                        <input id="latitud" type="text" class="form-control" id="exampleInputEmail1" value="<?php echo $resultado["Lat"] ?>">
                      </div>
                    </div>
                     <div class="col-lg-6">
                      <div class="form-group">
                        <label for="exampleInputEmail1"> Longitud </label>
                        <input type="hidden" id="idbarberia" value="<?php echo $id ?>">
                        <input id="longitud" type="text" class="form-control" id="exampleInputEmail1" value="<?php echo $resultado["Lng"] ?>">
                      </div>
                    </div>
                    <div class="col-lg-12 text-center">
                      <a style="width: 100%; color: white;" onclick="EditarBarberia()" class="btn btn-primary">Guardar</a>
                    </div>
                  </div>
                  
                </form>
                <hr>
                <h2 class="text-center">Barberos Registrados</h2>
                <br>
                <div class="row">
                  <div class="col-md-12">
                    <div class="card">
                      <div class="card-header">
                        <button  data-toggle="modal" data-target="#myModal" class="btn btn-success"><h4 class="card-title"> Registrar Barbero +</h4></button>
                        
                      </div>
                      <div class="card-body">
                        <div class="table-responsive">
                          <table class="table">
                            <thead class=" text-primary">
                              <th>
                                Foto
                              </th>
                              <th>
                                Nombre
                              </th>
                              <th>
                                Edad
                              </th>
                              <th>
                                Promedio de Servicio
                              </th>
                              <th>
                                Estado
                              </th>
                            </thead>
                            <tbody>
                              <?php 
                                while ($fila = mysqli_fetch_array($barberias)){
                              ?>
                              <tr>
                                <td>
                                 <img style="width: 80px; height: 80px; border-radius: 50%" src="fotos_perfil/<?php echo $fila["foto_perfil"] ?>" alt=""> 
                                </td>
                                <td>
                                  <?php echo $fila["nombre"] ?>
                                </td>
                                <td>
                                  <?php echo $fila["edad"] ?> Años
                                </td>
                                <td>
                                  <?php echo $fila["promedio_servicio"] ?> Minutos
                                </td>
                                <td>
                                  <?php 
                                    if($fila["estado"] == 1){
                                  ?>
                                    <button class="btn btn-danger"><i class="now-ui-icons ui-1_simple-delete"></i></button>
                                  <?php  
                                    }else{
                                  ?>
                                    <button class="btn btn-warning"><i class="now-ui-icons ui-1_simple-add"></i></button>
                                  <?php 
                                    }
                                  ?>
                                  
                                  
                                </td>
                              </tr>
                              <?php 
                                }
                              ?>
                            </tbody>
                          </table>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
              </div>
            </div>
          </div>
        </div>

      <div class="modal" id="myModal">
        <div class="modal-dialog">
          <div class="modal-content">

            <!-- Modal Header -->
            <div class="modal-header">
              <h4 class="modal-title">registro de nuevo Barbero</h4>
              <button type="button" class="close" data-dismiss="modal">&times;</button>
            </div>

            <!-- Modal body -->
            <div class="modal-body">
            <div class="row">       
              <div class="col-lg-12 text-center">
                <img style="width: 100pt; height: 100pt" id="output2" src="https://img.freepik.com/vector-gratis/plantilla-logotipo-barberia-vintage_441059-26.jpg" width="140" height="140">
              </div>
            </div>
                <br>
                <div class="row">
                  <div class="col-12">
                  <form id="form_registro_barbero" method="POST">
                    <div class="row" style="padding-right: 10%;padding-left: 10%;">
                      <div class="col-lg-12">
                        <div class="form-group">
                          <label for="exampleInputEmail1">Nombre</label>
                          <input id="nombre" type="text" class="form-control" placeholder="Ingrese un Nombre">
                        </div>
                      </div>
                      <div class="col-lg-12">
                        <div class="form-group">
                          <label for="exampleInputEmail1">Edad</label>
                          <input id="edad" type="text" class="form-control" placeholder="Ingrese la edad del barbero">
                        </div>
                      </div>
                      <div class="col-lg-12">
                        <div class="form-group">
                          <label for="exampleInputEmail1">Promedio de tiempo por servicio</label>
                          <input id="promedio" type="number" class="form-control" placeholder="Ingrese un tiempo en minutos">
                        </div>
                      </div>
                      <div class="col-lg-12">
                        <div class="form-group">
                          <label for="exampleInputEmail1">Foto de perfil</label>
                          <input id="foto_perfil" onchange="document.getElementById('output2').src = window.URL.createObjectURL(this.files[0])" type="file" class="form-control">
                          <input type="hidden" id="id_barberia" value="<?php echo $id ?>">
                        </div>
                      </div>
                      <div class="col-lg-12 text-center">
                        <a style="width: 100%; color: white;" onclick="GuardarBarbero()" class="btn btn-primary">Guardar</a>
                      </div>
                    </div>
                  </form>
                  </div>
                </div>
            </div>
            <!-- Modal footer -->
            <div class="modal-footer">
              <button type="button" class="btn btn-danger" data-dismiss="modal">Cerrar</button>
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
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="js/barbero.js"></script>
  <script src="js/guardar_barberia.js"></script>
</body>
</html>
<?php
}else{  
  header('Location: index.php');
  exit();
}
?>