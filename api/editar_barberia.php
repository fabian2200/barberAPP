<?php 
	include_once("conexion.php");
    $nombre = $_POST['nombre'];
    $direccion = $_POST['direccion'];
    $ciudad = $_POST['ciudad'];
    $fecha_renovacion = $_POST['fecha_renovacion'];
    $propietario = $_POST['propietario'];
    $horarioa = $_POST['horarioa'];
    $horarioc = $_POST['horarioc'];
    $telefono = $_POST['telefono'];
    $latitud = $_POST['latitud'];
    $longitud = $_POST['longitud'];
    $id = $_POST['id'];
    $horario = $horarioa."-".$horarioc;
        
    $archivonombre = $_FILES["logo"]["name"]; 
    $fuente = $_FILES["logo"]["tmp_name"]; 
    $tipo_archivo = $_FILES["logo"]["type"]; 
    $peso_archivo = $_FILES["logo"]["size"]; 
    $carpeta = "../logos/";

    $dest_path = $carpeta.$archivonombre;

    if(move_uploaded_file($fuente, $dest_path))
    {
        $sql="UPDATE `barberia` SET `nombre` = '$nombre', `direccion` = '$direccion', `ciudad` = '$ciudad', `logo` = '$archivonombre', `fecha_renovacion` = '$fecha_renovacion', `horario` = '$horario', `telefono` = '$telefono', `Lat` = '$latitud', `Lng` = '$longitud', `horarioa` = '$horarioa', `horarioc`  = '$horarioc' WHERE id = $id";

        $resultado = $con -> query($sql); 

        if($resultado){
            echo json_encode(array('success' => 1, 'mensaje' => 'Datos editados correctamente!'));  
        }else{
            echo json_encode(array('success' => 0, 'mensaje' => 'Ocurrio un error al guardar en la base de datos.'));
        }
    }else{
        echo json_encode(array('success' => 0, 'mensaje' => 'Ocurrio un error al guardar el logo.'));
    }
    
?>