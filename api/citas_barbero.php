<?php 
	include_once("conexion.php");
	$id = $_GET['id_barbero'];

    $sql= "SELECT r.id, r.id_barberia, r.hora_inicio, r.minuto_inicio, r.hora_final, r.minuto_final, r.fecha_cita, r.servicios, r.precio, b.nombre, b.direccion, ba.nombre AS nombre_barbero, r.estado_cita, r.usuario AS id_usuario FROM reservas r INNER JOIN barberia b ON (r.id_barberia = b.id) INNER JOIN barbero ba ON (r.id_barbero = ba.id) WHERE r.id_barbero = $id ORDER BY r.fecha_cita,r.hora_inicio,r.minuto_inicio;";

    $resultado = $con -> query($sql); 
    $Data = array();

	while($row = mysqli_fetch_array($resultado)){
	   $Data['Citas'][] = $row;
	}
	echo json_encode($Data);
?>