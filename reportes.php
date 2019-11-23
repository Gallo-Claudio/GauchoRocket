<?php
require_once "conexion.php";
session_start();
$id_usuario = $_SESSION['id'];
$error="";

$sql_cabinas_mas_vendidas = "select month (fecha_hora) as Meses, year (fecha_hora) as Año,c.nombre,v.tipo_viaje,
                             COUNT(v.tipo_viaje) as cantidadDeVecesVendida from cabina as c
                             inner join viajes as v on
                             c.id = v.tipo_viaje
                             group by meses,año,v.tipo_viaje";

$resultado_cabina = mysqli_query($conexion,$sql_cabinas_mas_vendidas) or die(mysqli_error());;
$fila_cabina = mysqli_fetch_array($resultado_cabina);




?>



<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Reportes</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="css/w3.css">
    <link rel="stylesheet" href="css/gr.css">
    <?php include "header.php" ?>
</head>
<body>
<center>
    <h3>Cabinas más vendidas</h3>
    <?php

    echo $fila_cabina[2];


    ?>
</center>





</body>
</html>
<script type="text/javascript" src="vendor/jquery/jquery-3.2.1.min.js"></script>
<?php
include "pie.html";
?>
