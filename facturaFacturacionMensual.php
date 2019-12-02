<?php
session_start();
require_once "conexion.php";
require_once "vendor/autoload.php";

$idf = $_GET ['id'];
$cabinaNombre = $_GET ['cabinaNombre'];
$total = $_GET ['total'];
$porcentaje = $_GET ['porcentaje'];
$date= date("Y-m-d");

$mpdf = new \Mpdf\Mpdf([

]);

$mpdf -> writeHtml("<p>Gaucho Rocket</p><br>Factura<br><br>  <table>
                <tr>
                    <td>ID de factura:</td>
                    <td>$idf</td>
                </tr>
                <tr>
                    <td>fecha emisión de factura:</td>
                    <td>$date</td>
                </tr>
                <tr>
                    <td>Nombre de la empresa</td>
                    <td>Gaucho Rocket</td>
                </tr>
                <tr>
                    <td>Dirección de la empresa:</td>
                    <td>Florencio Varela 1903</td>
                </tr>
                <tr>
                    <td>Provincia de la empresa:</td>
                    <td>Buenos Aires</td>
                </tr>
                <tr>
                    <td>Código Postal:</td>
                    <td>1754</td>
                </tr>
                <tr>
                    <td>Teléfono:</td>
                    <td>4480-8900</td>
                </tr>
                <tr>
                    <td>Identificacion Fiscal de la tienda:</td>
                    <td>11223344N</td>
                </tr>
                <tr>
                    <td><hr></td>
                    <td><hr></td>
                </tr>
                  <tr>
                    <td>Cabina:</td>
                    <td>$cabinaNombre</td>
                </tr>
                  <tr>
                    <td>Facturación:</td>
                    <td>$ $total</td>
                </tr>
                    <tr>
                    <td>Porcentaje:</td>
                    <td>$porcentaje</td>
                </tr>
              
                
            </table><br>",\Mpdf\HTMLParserMode::HTML_BODY);
$mpdf ->Output();

?>



<!DOCTYPE HTML>
<html>
<head>
    <meta charset="UTF-8">
    <title>Factura</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="css/w3.css">
    <link rel="stylesheet" href="css/gr.css">
    <?php include "header.php" ?>
</head>
<?php
include "pie.html";
?>
</html>