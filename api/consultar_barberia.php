<?php 
	include_once("conexion.php");
    $sql="SELECT * FROM `barberia`";

    $resultado = $con -> query($sql); 
    $Data = array();

	$row = mysqli_fetch_array($resultado);
	$Data['barberia'] = $row;
	echo json_encode($Data);  
    
?>