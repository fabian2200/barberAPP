<?php 
	include_once("conexion.php");
    $sql="SELECT * FROM `barberia` WHERE `calificacion` >=3";

    $resultado = $con -> query($sql); 
    $Data = array();

	while($row = mysqli_fetch_array($resultado)){
	   $Data['Barberias'][] = array_map('utf8_encode', $row);;
	}
	echo json_encode($Data);  
    
?>