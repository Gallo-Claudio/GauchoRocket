<?php
session_start();
require_once "conexion.php";
$sql_cabina_mas_vendida = " select DISTINCT c.cabinaNombre,count(r.idCapacidadCabina)as CabinaMasVendida,
                            year(v.fecha_hora) as anio, month(v.fecha_hora) as mes from cabina as c
                            inner join capacidad as cap 
                            on c.id = cap.tipo_cabina
                            inner join reservas as r
                            on cap.id = r.idCapacidadCabina
                            inner join viajes as v on 
                            r.cod_vuelo = v.id
                            group by mes,c.cabinaNombre
                            order by count(r.idCapacidadCabina) desc
                            limit 2";
$resultado_cabina_mas_vendida = mysqli_query($conexion,$sql_cabina_mas_vendida);


$sql_facturacion_mensual = "select sum(f.monto_pago) as facturacionMensual,cab.cabinaNombre, month(f.fecha_pago) as mes,year(f.fecha_pago) as anio
                            from facturacion as f
                            inner join reservas as r
                            on f.id_reserva = r.id
                            inner join capacidad as c
                            on r.idCapacidadCabina = c.id
                            inner join cabina as cab
                            on c.tipo_cabina = cab.id
                            group by mes,cab.cabinaNombre;";
$sql_resultado_facturacion_mensual = mysqli_query($conexion,$sql_facturacion_mensual);

?>


<!DOCTYPE HTML>
<html>
<head>
    <meta charset="UTF-8">
    <title>Reportes</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="css/w3.css">
    <link rel="stylesheet" href="css/gr.css">
    <?php include "header-admin.php" ?>
</head>
<body>
<!-- *********************************************CABINAS MAS VENDIDAS********************************************************* -->
    <div class="w3-container w3-card-4 w3-content">
        <h3 class="w3-xxxlarge w3-center w3-lobster">Cabinas más vendidas</h3>
        <table class="w3-table-all">
            <tr>
                <td width="157"><b>Nombre Cabina</b></td>
                <td width="221"><b>Cantidad de veces vendidas</b></td>
                <td width="176"><b>Mes</b></td>
                <td width="73"><b>Año</b></td>
            </tr>

<?php

while ($final_cabina_mas_vendida = mysqli_fetch_assoc($resultado_cabina_mas_vendida)){
    echo "<tr>
<center>
                <td>".$final_cabina_mas_vendida['cabinaNombre']."</td>\n 
                <td> ".$final_cabina_mas_vendida['CabinaMasVendida']."</td>\n
                <td>".$final_cabina_mas_vendida['mes']."</td>\n
                <td>".$final_cabina_mas_vendida['anio']."</td>
</center>
          </tr>";
                }
      ?>
        </table><br><br>

<!--*********************************************FACTURACION MENSUAL************************************** -->
        <table class="w3-table-all">
        <h3 class="w3-xxxlarge w3-center w3-lobster">Facturación mensual</h3>
        <tr>
            <td width="157"><b>Cabina</b></td>
            <td width="157"><b>Facturación</b></td>
            <td width="221"><b>Mes</b></td>
            <td width="176"><b>Año</b></td>
        </tr>

        <?php

        while ($final_resultado_facturacion_mensual = mysqli_fetch_assoc($sql_resultado_facturacion_mensual)){
            echo "<tr>
<center>
                <td> ".$final_resultado_facturacion_mensual['cabinaNombre']."</td>\n 
                <td> $ ".$final_resultado_facturacion_mensual['facturacionMensual']."</td>\n 
                <td>".$final_resultado_facturacion_mensual['mes']."</td>\n
                <td>".$final_resultado_facturacion_mensual['anio']."</td>
</center>
          </tr>";
        }
        ?>
        </table>
<!--*********************************************TASA DE OCUPACION POR VIAJE Y EQUIPO************************************** -->

        <table class="w3-table-all">
            <h3 class="w3-xxxlarge w3-center w3-lobster">Tasa de ocupación por viaje y equipo</h3>


        </table>


    </div>
</body>
<?php
include "pie.html";
?>
</html>
