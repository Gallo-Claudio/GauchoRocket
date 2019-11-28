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
    <script type="text/javascript" src="js/Chart.min.js"></script>
    <script src="js/Chart.bundle.js"></script>
    <script src="js/Chart.js"></script>

<?php include "header-admin.php" ?>

    <center> <h3 class="w3-xxxlarge w3-center w3-lobster">Gráfico facturación mensual</h3></center><br><br>

    <canvas id="myChart"></canvas>
    <script>
        var ctx = document.getElementById('myChart').getContext('2d');
        var chart = new Chart(ctx, {
            type: 'pie',
            data:{
                datasets: [{
                    data:[

                        <?php
                        $sql_facturacion_mensual = "select sum(f.monto_pago) as facturacionMensual,cab.cabinaNombre, monthname(f.fecha_pago) as mes,year(f.fecha_pago) as anio
                            from facturacion as f
                            inner join reservas as r
                            on f.id_reserva = r.id
                            inner join capacidad as c
                            on r.idCapacidadCabina = c.id
                            inner join cabina as cab
                            on c.tipo_cabina = cab.id
                            group by mes,cab.cabinaNombre;";
                        $sql_resultado_facturacion_mensual = mysqli_query($conexion,$sql_facturacion_mensual);

                        while ($final_resultado_facturacion_mensual = mysqli_fetch_assoc($sql_resultado_facturacion_mensual))
                        {
                        ?>
                        '<?php echo $final_resultado_facturacion_mensual['facturacionMensual']; ?>',
                        <?php
                        }
                        ?>
                    ],
                    backgroundColor: ['#42a5f5', 'red', 'green','pink','yellow','blue','black'],
                    label: 'Facturación mensual'}],
                labels: [
                    <?php
                    $sql_facturacion_mensual = "select sum(f.monto_pago) as facturacionMensual,cab.cabinaNombre, monthname(f.fecha_pago) as mes,year(f.fecha_pago) as anio
                            from facturacion as f
                            inner join reservas as r
                            on f.id_reserva = r.id
                            inner join capacidad as c
                            on r.idCapacidadCabina = c.id
                            inner join cabina as cab
                            on c.tipo_cabina = cab.id
                            group by mes,cab.cabinaNombre;";
                    $sql_resultado_facturacion_mensual = mysqli_query($conexion,$sql_facturacion_mensual);

                    while ($final_resultado_facturacion_mensual = mysqli_fetch_assoc($sql_resultado_facturacion_mensual))
                    {
                    ?>
                    '<?php echo $final_resultado_facturacion_mensual['mes'] . $final_resultado_facturacion_mensual['cabinaNombre']?>',
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