<?php 
	include_once("conexion.php");
    $nombre = $_POST['nombre'];
    $precio = $_POST['precio'];
    $tiempo = $_POST['tiempo'];
    $idBarberia = $_POST['idBarberia'];

    $sql="INSERT INTO `servicio`(`nombre`, `precio`, `tiempo`, `id_barberia`) VALUES ('$nombre','$precio','$tiempo','$idBarberia')";

    $resultado = $con -> query($sql); 

    if($resultado){
        echo json_encode(array('success' => 1, 'mensaje' => 'Datos guardados correctamente!'));  
    }else{
        echo json_encode(array('success' => 0, 'mensaje' => 'Ocurrio un error al guardar en la base de datos.'));
    }
?>