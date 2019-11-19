<?php
session_start();
require_once "conexion.php";
$id_usuario = $_SESSION['id'];
$sql_reservas = "SELECT r.cod_reserva, v.codigo_vuelo,v.fecha_hora,r.pago,r.lista_espera,r.check_in FROM reservas as r
                INNER JOIN viajes as v on r.cod_vuelo = v.id
                WHERE r.id_usuario = '$id_usuario'";
$resultado_reservas = mysqli_query($conexion,$sql_reservas);
$sinReservas = false;
date_default_timezone_set('America/Argentina/Buenos_Aires');
$hoy = date("Y-m-d-e");
$horaActual = date("H:i:s");
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
        if($fecha_vuelo <= $hoy && $hora_vuelo < $horaActual){
            $boton = "<a class='w3-button w3-round-xlarge w3-red btn1'>Caducada</a>";
        }else if ($fila_reservas['pago'] == 0 && $fila_reservas['lista_espera'] != 1 && $fila_reservas['check_in'] != 1) {
            $boton = "<a class='w3-button w3-round-xlarge w3-blue btn1' href='pago.php?reserva=" . $fila_reservas['cod_reserva'] . "'>Pagar</a>";
        } else if ($fila_reservas['pago'] == 1 && $fila_reservas['lista_espera'] != 1 && $fila_reservas['check_in'] == 1) {
            $boton = "<a class='w3-button w3-round-xlarge w3-green btn1'>OK</a>";
        } else if ($fila_reservas['pago'] != 1 && $fila_reservas['lista_espera'] == 1 && $fila_reservas['check_in'] != 1) {
            $boton = "<a class='w3-button w3-round-xlarge w3-yellow btn1'>En espera</a>";
        }else if($fila_reservas['pago'] == 1 && $fila_reservas['lista_espera'] != 1 && $fila_reservas['check_in'] != 1 && $fecha_vuelo == $hoy && $hora_checkIn >= $horaActual){
            $boton = "<a class='w3-button w3-round-xlarge w3-blue btn1' href='ubicacion_asientos.php?reserva=".$fila_reservas['cod_reserva']."'>Check-In</a>";
        }
        echo "<tr>
              <th>" . $fila_reservas['cod_reserva'] . "</th>
              <th>" . $fila_reservas['codigo_vuelo'] . "</th>
              <th>" . $fila_reservas['fecha_hora'] . "</th>
              <th>" .$boton . "</th>";
    }
}else if($sinReservas == true){
    echo "<p class='w3-center'>No tiene reservas activas.</p>";
    }
    ?>
