<?php
session_start();
require_once "conexion.php";
require "funciones.php";
$id_usuario = $_SESSION['id'];
$sql_reservas = "SELECT r.cod_reserva, v.codigo_vuelo, v.fecha_hora, r.pago, r.lista_espera, r.check_in, r.id, tipo_viaje,
                 cantidad, circuito_id, id_viajes, idCapacidadCabina, (filas*columnas) as capacidadCabina, estacion_origen, estacion_destino FROM reservas as r
                 INNER JOIN viajes as v on r.id_viajes = v.id
                 inner join capacidad on r.idCapacidadCabina = capacidad.id
                 WHERE r.id_usuario = '$id_usuario'";
$resultado_reservas = mysqli_query($conexion,$sql_reservas);
$sinReservas = false;
date_default_timezone_set('America/Argentina/Buenos_Aires');
//$hoy = date("Y-m-d-e");
//$horaActual = date("H:i:s");
$hoy2 = date("Y-m-d H:i:s");
if(mysqli_affected_rows($conexion) == 0){
    $sinReservas = true;
}


?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Inicio</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="css/w3.css">
    <link rel="stylesheet" href="css/gr.css">
    <?php include "header.php" ?>
</head>
<body>

<div class="w3-container banda">
    <p class="w3-xxlarge w3-center">Mis Reservas</p>
</div>
<?php
if($sinReservas == false){
?>

<div class="w3-display-container">
<div class="w3-container w3-card-4 w3-content">
<table class="w3-table-all">
    <tr>
        <th>Codigo de Reserva</th>
        <th>Codigo de Vuelo</th>
        <th>Fecha/Hora</th>
        <th>Estado</th>
    </tr>
    <?php
    while ($fila_reservas = mysqli_fetch_assoc($resultado_reservas)) {
        $fecha_vuelo = date("Y-m-d",strtotime($fila_reservas['fecha_hora']));
        $hora_vuelo = date("G-i-s",strtotime($fila_reservas['fecha_hora']));
        $hora_checkIn = date("G-i-s",strtotime($fila_reservas['fecha_hora']."- 2 hour"));
        $fecha_checkIn_inicio = date("Y-m-d H:i:s", strtotime($fila_reservas['fecha_hora']."- 2 days"));
        $fecha_checkIn_fin = date("Y-m-d H:i:s", strtotime($fila_reservas['fecha_hora']."- 2 hour"));
        $boton = "";
        $codigo_reserva = $fila_reservas['cod_reserva'];
        $codigo_vuelo = $fila_reservas['codigo_vuelo'];
        $id_reserva = $fila_reservas['id'];
        $cantidad = $fila_reservas['cantidad'];
        $circuito_id = $fila_reservas['circuito_id'];
        $id_viajes = $fila_reservas['id_viajes'];
        $idCapacidadCabina = $fila_reservas['idCapacidadCabina'];
        $capacidadCabina = $fila_reservas['capacidadCabina'];
        $id_estacion_origen = $fila_reservas['estacion_origen'];
        $id_estacion_destino = $fila_reservas['estacion_destino'];



        $id_tipo_viaje = $fila_reservas['tipo_viaje'];

        //***************************************************
        // Se determina el grado obtenido en el cheque medico
        //***************************************************
        $sql_integrantes = "select id_usuarios from integrantes_viaje
                            where id_reserva = '$id_reserva'";
                $resultados_integrantes = mysqli_query($conexion, $sql_integrantes);
                $nivel_vuelo_grupal='3';
                while ($fila_integrantes = mysqli_fetch_assoc($resultados_integrantes)){
                    $id_integrante = $fila_integrantes['id_usuarios'];
                    $sql_nivel_vuelo = "select nivel_vuelo from usuarios
                                where id = '$id_integrante'";
            $resultados_nivel_vuelo = mysqli_query($conexion,$sql_nivel_vuelo);
            $fila_nivel_vuelo = mysqli_fetch_assoc($resultados_nivel_vuelo);
            $nivel_vuelo = $fila_nivel_vuelo['nivel_vuelo'];

            if($nivel_vuelo_grupal>$nivel_vuelo){
                $nivel_vuelo_grupal = $nivel_vuelo;
            }
        }

        //***********************************************
        // Se determina el tipo de aceleracion de la nave
        //***********************************************
        $sql_tipo_de_aceleracion = "select tipo_aceleracion from reservas
                                    inner join capacidad
                                    on reservas.idCapacidadCabina = capacidad.id
                                    inner join modelos_naves
                                    on capacidad.modelo = modelos_naves.id
                                    where cod_reserva = '$codigo_reserva'";

        $resultados_tipo_de_aceleracion = mysqli_query($conexion, $sql_tipo_de_aceleracion);
        $filas_tipo_de_aceleracion = mysqli_fetch_assoc($resultados_tipo_de_aceleracion);
        $tipo_de_aceleracion = $filas_tipo_de_aceleracion['tipo_aceleracion'];



        If($nivel_vuelo_grupal == 0){
            $boton = "<span class='atencion'>Pendiente de chequeo médico</span>";

        } else if($tipo_de_aceleracion == 'AA' && $nivel_vuelo_grupal < 3){
            $boton = "<span class='alerta'>Reserva CANCELADA - No apto para el viaje</span>";
            cambia_estado_reserva_caida($id_reserva);
            habilita_cupo_en_lista_espera($codigo_vuelo, $cantidad, $circuito_id, $id_viajes, $idCapacidadCabina, $capacidadCabina);

        } else if ($fila_reservas['pago'] == 0 && $fila_reservas['lista_espera'] != 1 && $hoy2 >= $fecha_checkIn_inicio && $hoy2 <= $fecha_checkIn_fin) {
            $boton = "<a class='w3-button w3-round-xlarge w3-blue btn1 reserva' href='pago.php?reserva=" . $fila_reservas['cod_reserva'] . "'>Pagar</a>";

        }else if($fila_reservas['pago'] == 1 && $fila_reservas['lista_espera'] != 1 && $fila_reservas['check_in'] != 1 && $hoy2 >= $fecha_checkIn_inicio && $hoy2 <= $fecha_checkIn_fin){
            $boton = "<a class='w3-button w3-round-xlarge w3-green btn1 reserva' href='ubicacion_asientos.php?reserva=".$fila_reservas['cod_reserva']."'>Check-In</a>";

        } else if ($fila_reservas['pago'] == 1 && $fila_reservas['lista_espera'] != 1 && $fila_reservas['check_in'] != 1 && $hoy2 < $fecha_checkIn_inicio) {
            $boton = "<span class='aprobado'>Aprobada</span>";

        } else if ($fila_reservas['pago'] == 1 && $fila_reservas['lista_espera'] != 1 && $fila_reservas['check_in'] == 1 && $hoy2 >= $fecha_checkIn_inicio && $hoy2 <= $fecha_checkIn_fin) {
            $boton = "<span class='ok'>OK - Apto para abordar la nave</span>";

        } else if($fila_reservas['pago'] == 1 && $fila_reservas['lista_espera'] != 1 && $fila_reservas['check_in'] != 1 && $hoy2 >= $fecha_checkIn_inicio && $hoy2 > $fecha_checkIn_fin){
            $boton = "<span class='alerta'>Reserva CAIDA por falta de Check-In</span>";

        } else if ($fila_reservas['pago'] != 1 && $fila_reservas['lista_espera'] == 1 && $fila_reservas['check_in'] != 1) {
            $boton = "<span class='atencion'>Lista de espera</span>";
        }
        if($fecha_vuelo <= $hoy2){
            $boton = "El viaje ya partió";

        }

        echo "<tr>
              <th>" . $codigo_reserva . "</th>
              <th>" . $codigo_vuelo . "</th>
              <th>" . $fila_reservas['fecha_hora'] . "</th>
              <th>" .$boton . "</th>";
    }
}else if($sinReservas == true){
    echo "<p class='w3-center'>No tiene reservas activas.</p>";
    }
    ?>
</table>
</div>
</body>
<?php include "pie.html";?>
</html>