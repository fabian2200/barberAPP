<?php 
	include_once("conexion.php");
    $usuario = $_POST['usuario'];
    $password = $_POST['password'];
    $tipo = $_POST['tipo'];
    $ciudad = $_POST['ciudad'];
    
    $password = md5($password);
    $sql="INSERT INTO `usuario`(`usuario`, `password`, `ciudad`, `tipo`) VALUES ('$usuario','$password','$ciudad','$tipo')";

    $resultado = $con -> query($sql); 

    if($resultado){
        echo json_encode(array('success' => 1, 'mensaje' => 'Datos guardados correctamente!'));  
    }else{
        echo json_encode(array('success' => 0, 'mensaje' => 'Ocurrio un error al guardar en la base de datos.'));
    }
?>