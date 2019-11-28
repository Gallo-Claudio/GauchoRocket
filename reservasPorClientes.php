<?php
session_start();
require_once "conexion.php";
$idA = $_GET['id'];
$ran=rand(1,10000);

$sql_reservas = "SELECT f.monto_pago as pago,u.nombre as nombre, u.apellido as apellido,f.fecha_pago as fechaPago from reservas as r
                 inner join facturacion as f
                 on r.id = f.id_reserva
                 inner join usuarios as u 
                 on u.id = r.id_usuario
                 where u.id = '$idA'";
$resultado_reservas = mysqli_query($conexion,$sql_reservas);


?>


<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Reservas por cliente</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="css/w3.css">
    <link rel="stylesheet" href="css/animate.min.css">
    <link rel="stylesheet" href="css/gr.css">
    <?php include "header-admin.php" ?>
</head>
<body>
<div class="w3-container w3-card-4 w3-content">
    <h3 class="w3-xxxlarge w3-center w3-lobster">Ver reservas</h3>
    <table class="w3-table-all">
        <tr>
            <td width="157"><b>Nombre</b></td>
            <td width="221"><b>Apellido</b></td>
            <td width="176"><b>Pago</b></td>
            <td width="176"><b>Fecha pago</b></td>
            <td width="176"><b>Factura</b></td>

        </tr>

        <?php
if($resultado_reservas) {
    while ($final = mysqli_fetch_assoc($resultado_reservas)) {
        echo "<tr>
<center>
                <td>" . $final['nombre'] . "</td>\n 
                <td> " . $final['apellido'] . "</td>\n
                <td>" . $final['pago'] . "</td>\n
                <td>" . $final['fechaPago'] . "</td>\n
                <td><a href='factura.php?id=" . $ran . "&nombre=" . $final['nombre'] .
                             "&apellido=" . $final['apellido'] . "&pago=" . $final['pago'] .
                             "&fechaPago=" .$final['fechaPago'] . "'>Factura</a></td> 
</center>
          </tr>";
    }
}
?>
    </table>
</div>
</body>
<?php
include "pie.html";
?>
</html>