<?php 
 $host_db = "localhost:3306";
 $user_db = "root";
 $pass_db = "root";
 $db_name = "barber";
 

 $con = new mysqli($host_db, $user_db, $pass_db, $db_name);

    if ($con->connect_error) {
        die("La conexion fallo: " . $conexion->connect_error);
    }

?>