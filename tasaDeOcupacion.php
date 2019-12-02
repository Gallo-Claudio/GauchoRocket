<?php
session_start();
require_once "conexion.php";
$sql_equipos = "select id,naveNombre from modelos_naves";
$sql_resultados = mysqli_query($conexion,$sql_equipos);
$final_equipos = mysqli_fetch_all($sql_resultados);

if (isset($_POST['enviar'])) {
    $busca = $_POST['busca'];
    $anio = $_POST['anio'];
    $mes = $_POST['mes'];
    $nave = $_POST ['nave'];




}
?>



<!DOCTYPE HTML>
<html>
<head>
    <meta charset="UTF-8">
    <title>Tasa de ocupación</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="css/w3.css">
    <link rel="stylesheet" href="css/gr.css">
    <?php include "header-admin.php" ?>
</head>

<div class="w3-container banda">
    <h3 class="w3-xxlarge w3-center">Tasa de ocupación</h3>
</div>
<form action="tasaDeOcupacion.php" method="post" class="w3-container w3-card-4">
    <center>
    <p>Ingrese un mes y un año para obtener el reporte</p>
    Año
    <input type="text" name="anio">
    Mes
    <input type="text" name="mes">
        <select name='nave' id="nave">
            <option>Elija una opción</option>
            <?php
            $es=0;
            while($es < count($final_equipos)) {
                echo"<option value='".$final_equipos[$es][0]."'>".$final_equipos[$es][1]."</option>";
                $es++;
            }
            ?>
        </select>
</center><br><br>

 <center><button type="submit" name="enviar">Buscar</button></center>
</form>

<?php
if(!empty($mes) && !empty($anio)) {
    echo "<table class='w3-table-all fact_mensual'>
          <tr>
            <th width='157'><b>Cabina</b></th>
            <th width='157'><b>Veces reservada</b></th>
            <th width='157'><b>Porcentaje</b></th>
            <th width='157'><b>Factura</b></th>
          </tr>";

    $sql_buscador = "select f.fecha_pago,naveNombre, sum(r.cantidad) as cantidadDePersonas from facturacion as f
                    inner join reservas as r 
                    on f.id_reserva = r.id
                    inner join viajes as v
                    on r.id_viajes = v.id
                    inner join naves as n
                    on v.nave = n.id
                    inner join modelos_naves as mn
                    on n.modelo = mn.id
                    group by mn.naveNombre
                    LIKE '$busca';";
    $sql_buscador_resultado = mysqli_query($conexion,$sql_buscador);

    while ($final = mysqli_fetch_assoc($sql_buscador)){
        echo "<tr>
                 <td>" . $final[$i][1] . "</td>
        </tr>";
    }
}
?>
</table>
</html>
<?php include "pie.html" ?>