<?php 
	include_once("conexion.php");
    $id_barberia = $_POST['id_barberia'];
    $calificacion = $_POST['calificacion'];
    $id_servicio = $_POST['id_servicio'];
    
    $sql="SELECT * FROM `barberia` WHERE `id` = $id_barberia";
    $barberia = mysqli_fetch_array($con -> query($sql));
    
    $calificacionAanterior =  $barberia[12];
    $numeroCalificaciones =  $barberia[13];
    
    $calificacionAanterior = ($calificacionAanterior * $numeroCalificaciones) + $calificacion;
    
    $calificacionNueva = $calificacionAanterior / ( $numeroCalificaciones + 1);
    
    $sql2 = "UPDATE `barberia` SET calificacion = $calificacionNueva,`numero_calificaciones`= `numero_calificaciones` + 1 WHERE `id` = $id_barberia";
    

    $resultado = $con -> query($sql2); 

    if($resultado){
        $con -> query("UPDATE `reservas` SET `estado_cita`=1 WHERE `id` = $id_servicio"); 
        echo json_encode(array('success' => 1, 'mensaje' => 'Datos guardados correctamente!'));  
    }else{
        echo json_encode(array('success' => 0, 'mensaje' => 'Ocurrio un error al guardar en la base de datos.'));
    }
?>