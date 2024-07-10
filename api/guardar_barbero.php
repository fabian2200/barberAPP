<?php 
	include_once("conexion.php");
    $idbarberia = $_POST['idbarberia'];
    $nombre = $_POST['nombre'];
    $edad = $_POST['edad'];
    $estado = "1";
    
    $archivonombre = $_FILES["imagen"]["name"]; 
    $fuente = $_FILES["imagen"]["tmp_name"]; 
    $tipo_archivo = $_FILES["imagen"]["type"]; 
    $peso_archivo = $_FILES["imagen"]["size"]; 
    $carpeta = "../fotos_perfil/";

    $dest_path = $carpeta.$archivonombre;

    if(move_uploaded_file($fuente, $dest_path)){
        $sql="INSERT INTO `barbero`(`id_barberia`, `nombre`, `edad`, `foto_perfil`, `estado`) VALUES ('$idbarberia','$nombre','$edad','$archivonombre','$estado')";

        $resultado = $con -> query($sql); 

        if($resultado){
            echo json_encode(array('success' => 1, 'mensaje' => 'Datos guardados correctamente!'));  
        }else{
            echo json_encode(array('success' => 0, 'mensaje' => 'Ocurrio un error al guardar en la base de datos.'));
        }
    }else{
        echo json_encode(array('success' => 0, 'mensaje' => 'Ocurrio un error al guardar el logo.'));
    }
    
?>