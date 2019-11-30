<?php
session_start();
require_once "conexion.php";
$usuario = $_SESSION['username'];
if(!isset($usuario)){
    header("location:login.php");
}

$codigo_reserva = $_GET['codigo_reserva'];

$sql_imagen_qr ="select codigo_qr from reservas where cod_reserva='$codigo_reserva'";
$resultado_imagen_qr = mysqli_query($conexion,$sql_imagen_qr);
$fila_imagen_qr = mysqli_fetch_assoc($resultado_imagen_qr);
$imagen_qr = $fila_imagen_qr['codigo_qr'];
?>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <title>Check-in</title>
        <link rel="stylesheet" href="css/resetcss.css">
        <link rel="stylesheet" href="css/w3.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/3.7.2/animate.min.css">
        <link rel="stylesheet" href="css/gr.css">
    </head>
    <body>
    <?php
    include "header.php";
    echo "<img src='img/qr/".$imagen_qr."' class='image-qr'>";
    include "pie.html";
    ?>
    </body>
</html>
