<?php 
	
	$meses = ["Ene","Feb","Mar","Abr","May","Jun","Jul","Ago","Sep","Oct","Nov","Dic"];
	
    include_once("conexion.php");
    $hora_inicio = $_POST['hora_inicio'];
    $minuto_inicio = $_POST['minuto_inicio'];
    $tiempo = $_POST['tiempo'];
    $id_barbero = $_POST['id_barbero'];
    $id_barberia = $_POST['id_barberia'];
    $id_usuario = $_POST['id_usuario'];
    $fecha_cita = $_POST['fecha_cita'];
    $precio = $_POST['precio'];
    $servicios = $_POST['servicios'];

    //calcular Hora de salida
    $horaI = $hora_inicio.":".$minuto_inicio;  
    $horaF = SumaHoras( $horaI , $tiempo );
    $horafinal = explode(":", $horaF)[0];
    $minutofinal = explode(":", $horaF)[1];
    
    $dia = explode("-", $fecha_cita)[0];
    $mes = explode("-", $fecha_cita)[1];
    $anio = explode("-", $fecha_cita)[2];

  
    $mes = $meses[$mes];
  
    
    //insert
    $sql = "INSERT INTO `reservas` (`hora_inicio`, `minuto_inicio`, `hora_final`, `minuto_final`, `id_barbero`, `id_barberia`, `usuario`, `fecha_cita`, `precio`, `servicios`, `dia`, `mes`, `anio`) VALUES ($hora_inicio,$minuto_inicio,$horafinal,$minutofinal,$id_barbero,$id_barberia,$id_usuario,'$fecha_cita','$precio','$servicios','$dia','$mes','$anio')";

    //buscar hora de apertura y cierre de la barberia
    $barberia = $con -> query("SELECT * FROM `barberia` WHERE `id` = $id_barberia");

    $barberia = mysqli_fetch_row($barberia);
    preg_match_all('!\d+!', $barberia[10], $matches);

    $horaApertura = $matches[0][0];
    $horaCierre = $matches[0][1]+12;

    //verifico el horario de la barberia
    if($hora_inicio < $horaApertura || $horafinal > $horaCierre){
         echo json_encode(array('success' => 0, 'mensaje' => 'El horario en que se atiende es de: '.$barberia[10]));
    }else{
        if(MismaHora($id_barbero, $fecha_cita, $hora_inicio, $minuto_inicio, $con)){
            if(VerificarDisponibilidad($id_barbero,$horaI,$horaF,$fecha_cita,$tiempo,$con)){
                $resultado_insert = $con -> query($sql); 
                if($resultado_insert){
                    echo json_encode(array('success' => 1, 'mensaje' => 'Cita reservada correctamente!'));  
                }else{
                    echo json_encode(array('success' => 0, 'mensaje' => 'Ocurrio un error al guardar en la base de datos.'));
                }
            }else{
                $respuesta =  BuscarReservaCercana($id_barbero,$horaI,$horaF,$fecha_cita,$tiempo,$con);
                echo json_encode(array('success' => 0, 'mensaje' => $respuesta));
            }
        }else{
            echo json_encode(array('success' => 0, 'mensaje' => 'Ya hay una reserva a esa hora con este profesional.'));
        }
    }


    

    function SumaHoras( $hora, $minutos_sumar ){ 
       $minutoAnadir=$minutos_sumar;
       $segundos_horaInicial=strtotime($hora);
       $segundos_minutoAnadir=$minutoAnadir*60;
       $nuevaHora= date("H:i",$segundos_horaInicial+$segundos_minutoAnadir);

       return $nuevaHora;
    } 


    function MismaHora($id_barbero, $fecha_cita, $hora_inicio, $minuto_inicio, $con){

        $resultado = $con -> query("SELECT * FROM `reservas` WHERE `fecha_cita` = '$fecha_cita' AND `id_barbero` = $id_barbero AND `hora_inicio` = $hora_inicio AND `minuto_inicio` = $minuto_inicio");

        if(mysqli_num_rows($resultado) > 0){
            return false;
        }else{
            return true;
        }
    }

    function VerificarDisponibilidad($id_barbero,$horai,$horaf,$fecha_cita,$tiempo,$con){
        
        $bandera = false;
        $datos = $con -> query("SELECT * FROM `reservas` WHERE `id_barbero` = $id_barbero and `fecha_cita` = '$fecha_cita' ORDER BY `hora_inicio`, `minuto_inicio`");
        
        $horai = new DateTime($horai); 
        $horaf = new DateTime($horaf);

        if(mysqli_num_rows($datos)>0){
            $rawdata = array(); 
            $i=0;
            while($row = mysqli_fetch_array($datos))
            {
                $rawdata[$i] = $row;
                $i++;
            }
            
            $encontrado = 0;
            for ($j=0; $j < $i; $j++) { 
                $horaibd = new DateTime($rawdata[$j][1].":".$rawdata[$j][2]); 
                $horafbd = new DateTime($rawdata[$j][3].":".$rawdata[$j][4]);

                if($horai < $horaibd){
                    if($horaf < $horafbd){
                        $encontrado = 1;
                        break;
                    }
                }
            }

            if($encontrado == 0){
                // si no lo encuentra lo agrega al final
                $horafbd = new DateTime($rawdata[$i-1][3].":".$rawdata[$i-1][4]);
                if($horafbd <= $horai){
                    $bandera = true;
                }
            }else{
                // si lo encuentra de primero
                if($encontrado == 1 && $j == 0){
                    $horaibd = new DateTime($rawdata[$j][1].":".$rawdata[$j][2]); 
                    if(DiferenciaMinutos($horai, $horaibd) >= $tiempo){
                        $bandera = true;
                    }
                }else{
                    //si lo encuentra a la mitad
                    if($encontrado == 1 && $j != 0){
                        $anterior = $rawdata[$j-1];
                        $horafbda = new DateTime($anterior[3].":".$anterior[4]);
                        $horaibd = new DateTime($rawdata[$j][1].":".$rawdata[$j][2]); 

                        if($horai >= $horafbda){
                            if(DiferenciaMinutos($horai, $horaibd) >= $tiempo){
                               $bandera = true;
                            }
                        }
                    }else{
                        $bandera = false;
                    }
                }
            }
            
        }else{
            $bandera = true;
        }

        return $bandera;
    }


    function BuscarReservaCercana($id_barbero,$horai,$horaf,$fecha_cita,$tiempo,$con)
    {
        $bandera = false;
        $datos = $con -> query("SELECT * FROM `reservas` WHERE `id_barbero` = $id_barbero and `fecha_cita` = '$fecha_cita' ORDER BY `hora_inicio`, `minuto_inicio`");
        
        $horai = new DateTime($horai); 
        $horaf = new DateTime($horaf);   

        $rawdata = array(); 
        $i=0;
        while($row = mysqli_fetch_array($datos))
        {
            $rawdata[$i] = $row;
            $i++;
        }

        $reserva_mas_proxima;
        for ($j=0; $j < $i-1; $j++) { 
            $horaibd = new DateTime($rawdata[$j][3].":".$rawdata[$j][4]);
            $horafbd = new DateTime($rawdata[$j][3].":".$rawdata[$j][4]);
            $horaibd2 = new DateTime($rawdata[$j+1][1].":".$rawdata[$j+1][2]);     

           if($horai < $horaibd){
                $diferencia = DiferenciaMinutos($horafbd,$horaibd2);
                if($diferencia >= $tiempo){
                    $reserva_mas_proxima =  "De acuerdo con el tiempo necesario para su servicio, no se ajusta la hora seleccionada, el horario libre mas cercano es de : ".$horafbd->format("H:i")." hasta ".$horaibd2->format("H:i");
                    break;
                }
           }        
        }

        if($j == ($i-1)){
            $reserva_mas_proxima =  "De acuerdo con el tiempo necesario para su servicio, no se ajusta la hora seleccionada, el horario libre mas cercano es : ".$rawdata[$j][3].":".$rawdata[$j][4];
        }
        return $reserva_mas_proxima;
    }

    function DiferenciaMinutos($hora1, $hora2)
    {   
        $diferencia = $hora1 -> diff($hora2);
        $diferencia = ($diferencia->h*60)+$diferencia->i;
        return $diferencia;
    }
?>