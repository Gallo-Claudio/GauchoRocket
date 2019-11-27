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
?>


<!DOCTYPE HTML>
<html>
<head>
    <meta charset="UTF-8">
    <title>Reportes</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="css/w3.css">
    <link rel="stylesheet" href="css/gr.css">
    <?php include "header.php" ?>
</head>
<body>
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
                <td>".$final_cabina_mas_vendida['anio']."</td><br><br>
</center>
          </tr>";
                }
      ?>
        </table>
    </div>
</body>
<?php
include "pie.html";
?>
</html>
