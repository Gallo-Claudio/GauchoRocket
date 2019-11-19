<?php
require_once "conexion.php";

$tipo_viaje = $_POST['tipo_viaje'];
$id_viaje = $_POST['id_viaje'];
//$id_usuario = $_SESSION['id']; // Lo harcodeo para codear sin tener que loguearme y hacer mas rapido las verificacion de lo que hago
$id_usuario = 1;
$idCapacidadCabina = $_POST['idCapacidadCabina'];
$cantidad_pasajes_a_reservar = $_POST['cantidad_pasajes_a_reservar'];
$nombre = $_POST['nombre'];
$apellido = $_POST['apellido'];
$email = $_POST['email'];
$id_estacion_destino = $_POST['id_destino'];

/****************************************************************************************************************************/
/* Se obtiene capacidad de las cabinas y otros datos ************************************************************************/
/****************************************************************************************************************************/
$sql_cabina = "SELECT (filas*columnas) as capacidadCabina, origen as id_estacion_origen FROM viajes as v
                        INNER JOIN naves as n
                        ON v.nave = n.id
						INNER JOIN modelos_naves as mn
                        ON n.modelo = mn.id
                        inner join capacidad
                        on capacidad.modelo = mn.id
                        WHERE v.id = '$id_viaje'
                        and capacidad.id = '$idCapacidadCabina'";
$resultado_cabina = mysqli_query($conexion, $sql_cabina);
$fila_cabina = mysqli_fetch_assoc($resultado_cabina);
$capacidadCabina = $fila_cabina['capacidadCabina'];
$id_estacion_origen = $fila_cabina['id_estacion_origen'];


/**************************************************************************************************************/
/* se obtiene el tipo de circuito y las estaciones que lo integran **** Usado para ENTRE DESTINOS  ************/
/**************************************************************************************************************/
if($circuito<3){
    $sql_estaciones = "SELECT c.id as circuito, e.id, e.nombre FROM viajes as v
                    INNER JOIN circuitos as c
                    ON v.circuito_id = c.id
                    INNER JOIN circuitos_estaciones as ce
                    ON c.id = ce.circuito_id
                    INNER JOIN estaciones as e
                    ON ce.estacion_id = e.id
                    WHERE v.id = '$id_viaje'
                    ORDER BY e.id ASC";
}else{
    $sql_estaciones = "SELECT c.id as circuito, e.id, e.nombre FROM viajes as v
                    INNER JOIN circuitos as c
                    ON v.circuito_id = c.id
                    INNER JOIN circuitos_estaciones as ce
                    ON c.id = ce.circuito_id
                    INNER JOIN estaciones as e
                    ON ce.estacion_id = e.id
                    WHERE v.id = '$id_viaje'
                    ORDER BY e.id desc ";
}
$resultado_estaciones = mysqli_query($conexion,$sql_estaciones);
$error = "";
$reserva_realizada = false;


    // ********* VALIDO DATOS DEL FORMULARIO *************
    // Genero variables, para validar que lleguen datos en los campos (que no esten vacios)
    $campos_form_vacios = false;
    $class_error_alerta =  "class='w3-panel w3-red'";

    // Veo que se haya seleccionado una opcion de cabina de la nave
    if (empty($idCapacidadCabina)) {
        $error .= "<p>Debe seleccionar una cabina</p>";
        $class_error_alerta ="animated shake w3-red";
        $campos_form_vacios = true;
    }
    // veo que se haya ingresado un valor en pasajes a reservar
    if ($cantidad_pasajes_a_reservar <= 0) {
        $error .= "<p>La cantidad de pasajes a reservar tiene que ser como minimo igual a 1</p>";
        $class_error_alerta ="animated shake w3-red";
        $campos_form_vacios = true;
    }
    else {
        $posicion_dato='lleno';

        foreach ($nombre as $valor) {
            if(empty($valor)){
                $error_form_acompañante_nombre = "<br>- Falta/n nombre/s";
                $posicion_dato='vacio';
            }
        }
        foreach ($apellido as $valor) {
            if(empty($valor)){
                $error_form_acompañante_apellido = "<br>- Falta/n apellido/s";
                $posicion_dato='vacio';
            }
        }
        foreach ($email as $valor) {
            if(empty($valor)){
                $error_form_acompañante_email = "<br>- Falta/n email/s";
                $posicion_dato='vacio';
            }
        }

       if($posicion_dato=='vacio') {
           $error .= "Debe completar todos los datos del formulario";
           $error .= $error_form_acompañante_nombre.$error_form_acompañante_apellido.$error_form_acompañante_email;
           $class_error_alerta ="animated shake w3-red";
           $campos_form_vacios = true;
       }
    }

    // Persisto datos si los campos estan llenos
    if ($campos_form_vacios == false) {

        if ($tipo_viaje == "Tour" || $tipo_viaje == "Suborbitales") {
            $sql_reservas = "SELECT r.cod_vuelo , sum(cantidad) as cantidad FROM reservas as r
                                    WHERE r.cod_vuelo = '$id_viaje'
                                    and r.idCapacidadCabina = '$idCapacidadCabina'
                                    GROUP BY r.cod_vuelo";
            $resultado = mysqli_query($conexion, $sql_reservas);
            $fila = mysqli_fetch_assoc($resultado);
            $capacidad_disponible = $capacidadCabina - $fila['cantidad'];


            if (($capacidad_disponible - $cantidad_pasajes_a_reservar) >= 0) {
                $sql_nueva_reserva = "INSERT INTO reservas (cod_vuelo,cantidad,id_usuario,idCapacidadCabina) VALUES
                                                        ('$id_viaje','$cantidad_pasajes_a_reservar','$id_usuario','$idCapacidadCabina')";
                $consulta = mysqli_query($conexion, $sql_nueva_reserva);
                $reserva_realizada = true;
                $error = "<p>La reserva fué realizada con éxito.</p>";
                $class_error_alerta ="correcto";
            } else {

                $sql_nueva_reserva = "INSERT INTO reservas (cod_vuelo,cantidad,id_usuario,idCapacidadCabina,lista_espera) VALUES
                                                        ('$id_viaje','$cantidad_pasajes_a_reservar','$id_usuario','$idCapacidadCabina','1')";
                $consulta = mysqli_query($conexion, $sql_nueva_reserva);
                $reserva_realizada = true;
                $error = "<p>La reserva entro en LISTA DE ESPERA.<br>Lo que significa que la misma esta pendiente de confirmación hasta que haya alguna cancelación de reserva.</p>";
                $class_error_alerta ="animated shake alerta";
            }

        } elseif ($tipo_viaje == "Entre destinos") {
            $sePuedeReservar = false;

                while($fila_estaciones = mysqli_fetch_assoc($resultado_estaciones)){

                    $sql_reservas_destino = "SELECT r.cod_vuelo, sum(cantidad) as cantidad FROM reservas as r 
                                                    WHERE r.cod_vuelo = '$id_viaje'
                                                    AND r.estacion_destino = '" . $fila_estaciones['id'] . "'
                                                    and r.idCapacidadCabina = '$idCapacidadCabina'
                                                    GROUP BY r.cod_vuelo";
                    $resultado_reservas_destino = mysqli_query($conexion, $sql_reservas_destino);
                    $fila_reservas_destino = mysqli_fetch_assoc($resultado_reservas_destino);

                    if (mysqli_affected_rows($conexion) > 0) {
                        $capacidadCabina += $fila_reservas_destino['cantidad'];
                    }


                    $sql_reservas_origen = "SELECT r.cod_vuelo, sum(cantidad) as cantidad FROM reservas as r 
                                                    WHERE r.cod_vuelo = '$id_viaje'
                                                    AND r.estacion_origen = '" . $fila_estaciones['id'] . "'
                                                    and r.idCapacidadCabina = '$idCapacidadCabina'
                                                    GROUP BY r.cod_vuelo";
                    $resultado_reservas_origen = mysqli_query($conexion, $sql_reservas_origen);
                    $fila_reservas_origen = mysqli_fetch_assoc($resultado_reservas_origen);

                    if (mysqli_affected_rows($conexion) > 0) {
                        $capacidadCabina -= $fila_reservas_origen['cantidad'];
                    }

                    if ($fila_estaciones['id'] >= $id_estacion_origen && $fila_estaciones['id'] < $id_estacion_destino) {
                        if ($capacidadCabina < $cantidad_pasajes_a_reservar) {
                            $sePuedeReservar = false;
                            break;
                        }
                    } else {
                        $sePuedeReservar = true;
                    }
                }

                if($sePuedeReservar == true){
                    $sql_nueva_reserva = "INSERT INTO reservas (cod_vuelo,cantidad,id_usuario,estacion_origen,estacion_destino,idCapacidadCabina) 
                                                VALUES ('$id_viaje','$cantidad_pasajes_a_reservar','$id_usuario','$id_estacion_origen','$id_estacion_destino','$idCapacidadCabina');";
                    $consulta = mysqli_query($conexion, $sql_nueva_reserva);
                    $reserva_realizada = true;
                    $error = "<p>La reserva fué realizada con éxito.</p>";
                    $class_error_alerta ="correcto";

                }elseif ($sePuedeReservar == false){
                    $sql_nueva_reserva = "INSERT INTO reservas (cod_vuelo,cantidad,id_usuario,estacion_origen,estacion_destino,idCapacidadCabina,lista_espera) 
                                                VALUES ('$id_viaje','$cantidad_pasajes_a_reservar','$id_usuario','$id_estacion_origen','$id_estacion_destino','$idCapacidadCabina','1');";
                    $consulta = mysqli_query($conexion, $sql_nueva_reserva);
                    $reserva_realizada = true;
                    $error = "<p>La reserva entro en LISTA DE ESPERA.<br>Lo que significa que la misma esta pendiente de confirmación hasta que haya alguna cancelación de reserva.</p>";
                    $class_error_alerta ="animated shake alerta";
                }

        }
        // Guarda en la BD los datos de los acompañantes para que realicen el registro y posterior confirmación
        if ($cantidad_pasajes_a_reservar > 1) {

            for ($i=0;$i<$cantidad_pasajes_a_reservar-1;$i++) {

                $sql_email = "SELECT email FROM usuarios WHERE email = '$email[$i]'";
                $resultado_email = mysqli_query($conexion,$sql_email);
                $lista_email = mysqli_fetch_all($resultado_email);
                if(!empty($lista_email)) {
                    $error .= "<p class='w3-red'>El Email ".$email[$i]." ya existe en nuestra base de datos</p>";
                }
                else {
                    $sql_datos_acompaniantes = "insert into usuarios (nombre, apellido, email, confirmacion_mail)
                                            values ('$nombre[$i]','$apellido[$i]','$email[$i]','0')";
                    $consulta_datos_acompañantes = mysqli_query($conexion, $sql_datos_acompaniantes);
                }
            }
        }
    }

$mensajeFinal = array('mensaje' => $error,'clase' => $class_error_alerta);
$jsonstring = json_encode($mensajeFinal);
echo $jsonstring;
?>