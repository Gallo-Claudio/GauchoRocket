<?php
require_once "conexion.php";

$sql_estaciones= "select * from estaciones";
$resultado_estaciones = mysqli_query($conexion, $sql_estaciones);
$registro_estaciones = mysqli_fetch_all($resultado_estaciones);
$fecha_actual = date("Y-m-d");
$fecha_minimo = date("Y-m-d",strtotime($fecha_actual."+ 1 days"));
$error_fecha = "";

if (isset($_POST['enviar'])) {
    $fecha_salida = $_POST['fecha_salida'];
    $hora_salida_inicial = $_POST['hora_salida_inicial'];
    $hora_salida_final = $_POST['hora_salida_final'];
    $tipo_viajes = $_POST['tipo_viajes'];

    if ($fecha_salida == "" && $fecha_salida < $fecha_minimo) {
        $error_fecha = "Ingrese una fecha valida";
    } else {
        $sql = "select fecha_salida, hora_salida, tipo_viajes.tipo_viaje, duracion from viajes as v
                    inner join tipo_viajes
                    on v.tipo_viaje = tipo_viajes.id
                    WHERE v.fecha_salida = '$fecha_salida'";
        if ($hora_salida_inicial != "-" && $hora_salida_final == "-") {
            $sql = $sql . " AND hora_salida >= '$hora_salida_inicial'";
        } else if ($hora_salida_inicial != "-" && $hora_salida_final != "-") {
            if ($hora_salida_inicial < $hora_salida_final) {
                $sql = $sql . " AND hora_salida between '$hora_salida_inicial' and '$hora_salida_final'";
            }

        }
        if($tipo_viajes != "-"){
            $sql = $sql . " AND v.tipo_viaje = '$tipo_viajes'";
        }
        $resultado = mysqli_query($conexion, $sql);
    }
}
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>Buscá tu vuelo</title>
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Lobster">
    <link rel="stylesheet" href="css/gr.css">
    <!-- Bootstrap -->
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" rel="stylesheet">

</head>
<body>
<?php include "header.php" ?>
<div class="container">

    <ul class="nav nav-tabs" role="tablist">
        <li class="active"><a href="#about" role="tab" data-toggle="tab">Vuelos Orbitales</a></li>
        <li><a href="#specs" role="tab" data-toggle="tab">Vuelos entre destinos</a></li>
        <li><a href="#reviews" role="tab" data-toggle="tab">Tours</a></li>
    </ul>

    <!-- Lenguetas -->
    <div class="tab-content">
        <div role="tabpanel" class="tab-pane fade in active" id="about">

            <!-- ORBITALES -->
            <h2>Vuelos Orbitales</h2>
            <p class="descripcion">Los vuelos Orbitales salen todos los días de la semana, desde dos localidades diferentes.</p>

            <form id="orbital">
                <?php echo "<p>$error_fecha</p>"; ?>

                <input id="tipo_viajes" name="tipo_viajes" type="hidden" value="2">
                <div class="selector">
                    <label for='fecha_salida'>Fecha Salida:</label>
                    <input name="fecha_salida"type="date" min="<?php echo $fecha_minimo?>">
                </div>
                <div class="selector">
                    <label for='destino'>Lugar de Salida:</label>
                    <select name='destino'>
                        <?php
                        $es=0;
                        for ($es;$es<2;$es++) {
                            echo"<option value='".$registro_estaciones[$es][0]."'>".$registro_estaciones[$es][1]."</option>";
                        }
                        ?>
                    </select>
                </div>

                <button id="submit" type="submit" name="enviar">Buscar</button>
            </form>
        </div>

        <!-- ENTRE DESTINOS -->
        <div role="tabpanel" class="tab-pane fade" id="specs">
            <h2>Vuelos entre Destinos</h2>
            <p class="descripcion">Estos vuelos se realizán todos los días de la semana.</p>
            <form id="destinos">
                <?php echo "<p>$error_fecha</p>"; ?>

                <input name="tipo_viajes" type="hidden" value="3">
                <div class="selector">
                    <label for='fecha_salida'>Fecha Salida:</label>
                    <input name="fecha_salida"type="date" min="<?php echo $fecha_minimo?>">
                </div>
                <div class="selector">
                    <label for='origen'>Lugar de Salida:</label>
                    <select name='origen' id="origen">
                        <?php
                        $es=0;
                        while($es < count($registro_estaciones)) {
                            echo"<option value='".$registro_estaciones[$es][0]."'>".$registro_estaciones[$es][1]."</option>";
                            $es++;
                        }
                        ?>
                    </select>
                </div>
                <div id="estac"></div>
                <div class="selector">
                    <label for='destino'>Lugar de Destino:</label>
                    <select name='destino' id="estaciones">

                    </select>
                </div>

                <button type="submit" name="enviar">Buscar</button>
            </form>
        </div>

        <!-- TOURS -->
        <div role="tabpanel" class="tab-pane fade" id="reviews">
            <h2>Tours</h2>
            <p class="descripcion">Estos vuelos se realizan solamente los días domingos</p>
            <form id="tours">
                <?php echo "<p>$error_fecha</p>"; ?>

                <input name="tipo_viajes" type="hidden" value="1">
                <input name="destino" type="hidden" value="1">
                <div class="selector"><label for='fecha_salida'>Fecha Salida:</label>
                    <input name="fecha_salida"type="date" min="<?php echo $fecha_minimo?>">
                </div>

                <button type="submit" name="enviar">Buscar</button>
            </form>
        </div>
    </div>
    <?php

    if ($error_fecha == "") {
        if (mysqli_affected_rows($conexion) > 0) {
            echo "<table class='table table-striped table-bordered table-hover table-condensed'>
                <thead>
                  <tr>
                    <td>Código de Vuelo</td>
                    <td>Fecha</td>
                    <td>Hora</td>
                    <td>Origen</td>
                    <td>Destino</td>
                    <td>Duración del viaje</td>
                    <td>Nave</td>
                    <td></td>
                  </tr>
                 </thead>
                 <tbody id='resultados'>";
            echo "</tbody></table>";
        } else {
            echo "<p>No se encontraron vuelos disponibles</p>";
        }
    }
    ?>
</div><!-- container -->


<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<!-- Include all compiled plugins (below), or include individual files as needed -->
<!-- <script src="bootstrap/js/bootstrap.min.js"></script> -->

<!-- Bootstrap -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
<script src="https://code.jquery.com/jquery-2.2.4.min.js"></script>

<!-- <script src="http://code.jquery.com/jquery-1.10.1.min.js"></script> -->
<script src="js/selector_viajes.js"></script>
</body>
<?php    include "pie.html";?>
</html>
