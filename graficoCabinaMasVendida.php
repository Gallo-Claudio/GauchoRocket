<?php
session_start();
require_once "conexion.php";
?>
    <title>Grafico</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="css/w3.css">
    <link rel="stylesheet" href="css/gr.css">
    <script type="text/javascript" src="js/jquery-2.2.4.min.js"></script>
    <script src="js/Chart.bundle.js"></script>
    <script src="js/Chart.js"></script>

<?php include "header-admin.php" ?>

    <center> <h3 class="w3-xxxlarge w3-center w3-lobster">Gráfico de cabina más vendida</h3></center><br><br>

<canvas id="myChart"></canvas>
<script>
    var ctx = document.getElementById('myChart').getContext('2d');
    var chart = new Chart(ctx, {
        type: 'bar',
        data:{
            datasets: [{
                data:[

                    <?php

                    $sql_cabina_mas_vendida = " select DISTINCT c.cabinaNombre,count(r.idCapacidadCabina)as CabinaMasVendida,
                            year(v.fecha_hora) as anio, monthname(v.fecha_hora) as mes from cabina as c
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

                    while ($final_cabinas_mas_vendida = mysqli_fetch_assoc($resultado_cabina_mas_vendida))
                    {
                    ?>
                    '<?php echo $final_cabinas_mas_vendida['CabinaMasVendida']; ?>',
                    <?php
                    }
                    ?>
                ],
                backgroundColor: ['#42a5f5', 'red', 'green'],
                label: 'Cabinas'}],
            labels: [
                <?php
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

                while ($final_cabinas_mas_vendida = mysqli_fetch_assoc($resultado_cabina_mas_vendida))
                {
                ?>
                '<?php echo $final_cabinas_mas_vendida['cabinaNombre']; ?>',
                <?php
                }
                ?>

            ]},
        options: {responsive: true}
    });
</script>

<?php
include "pie.html";
?>