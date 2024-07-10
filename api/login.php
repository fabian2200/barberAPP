<?php
include_once("conexion.php");
session_start();
$usuario = @$_POST['usuario'];
$password = @$_POST['pass'];
$password = md5($password);

if(empty($usuario) || empty($password)){
header("Location: index.php");
exit();
}else {
	$sql = "SELECT * FROM `usuario` WHERE `usuario` = '$usuario'";

	$usuario = $con -> query($sql);

	//verificamos que si exista ese usuario 
	if(mysqli_num_rows($usuario) == 0){
		echo json_encode(array('success' => 0, 'error' => '¡Datos incorrectos!'));
	}else{
		$fila = mysqli_fetch_row($usuario);
		if($fila[2] == $password){
			$_SESSION['logueado'] = true;
        	$_SESSION['id'] = $fila[0];
        	$_SESSION['tipo'] = $fila[4];
        	$_SESSION['usuario'] = $usuario;
        	//codificamos
        	$rawdata = array(); 
    		$rawdata[0] = $fila;
			$rawdata = json_encode(array('success' => 1,'usuario' => $rawdata, 'error' => '¡Bienvenido!'));
			echo $rawdata;
		}else{
			echo json_encode(array('success' => 0, 'error' => '¡Contraseña incorrecta!'));
		}
	}
}
?>