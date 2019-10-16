<?php
    $conexion = mysqli_connect("127.0.0.1:3307","pw2","pw22019","gauchorocket");
    if(!$conexion){
        echo "<p>ERROR de conexion a la BD</p>";
        die;
    }
    $sql_tipo_viajes= "select * from tipo_viajes";
    $resultado_tipo_viajes = mysqli_query($conexion, $sql_tipo_viajes);
    $registro_tipo_viajes = mysqli_fetch_all($resultado_tipo_viajes);
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

    /*  where v.dia = '$dias' and v.hora='$horas' and v.tipo_viaje = '$tipo_viajes'";
    $resultado = mysqli_query($conexion, $sql);
    $lista = mysqli_fetch_all($resultado);

    if (empty($lista)) {
     $error = "<p class='error animated shake'>No se ha encontrado ningún viaje</p>";
    }*/

?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Busca tu vuelo</title>
    <meta charset="UTF-8">
    <title>Inicio</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Lobster">
    <link rel="stylesheet" href="css/gr.css">
    <?php include "header.php" ?>
</head>
<body>
<form method="POST" action="buscador-viajes.php">
    <?php echo "<p>$error_fecha</p>"; ?>

    <div class="selector"><label for='fecha_salida'>Fecha Salida:</label>

        <input name="fecha_salida"type="date" min="<?php echo $fecha_minimo?>">

    </div>

    <div class="selector"><label>Hora salida:</label>
        <select name="hora_salida_inicial">
            <option value="-">--:--</option>
            <option value="00:00">00:00</option>
            <option value="01:00">01:00</option>
            <option value="02:00">02:00</option>
            <option value="03:00">03:00</option>
            <option value="04:00">04:00</option>
            <option value="05:00">05:00</option>
            <option value="06:00">06:00</option>
            <option value="07:00">07:00</option>
            <option value="08:00">08:00</option>
            <option value="09:00">09:00</option>
            <option value="10:00">10:00</option>
            <option value="11:00">11:00</option>
            <option value="12:00">12:00</option>
            <option value="13:00">13:00</option>
            <option value="14:00">14:00</option>
            <option value="15:00">15:00</option>
            <option value="16:00">16:00</option>
            <option value="17:00">17:00</option>
            <option value="18:00">18:00</option>
            <option value="19:00">19:00</option>
            <option value="20:00">20:00</option>
            <option value="21:00">21:00</option>
            <option value="22:00">22:00</option>
            <option value="23:00">23:00</option>
        </select>
    </div>
    <div class="selector">
        <select name="hora_salida_final">
            <option value="-">--:--</option>
            <option value="01:00">01:00</option>
            <option value="02:00">02:00</option>
            <option value="03:00">03:00</option>
            <option value="04:00">04:00</option>
            <option value="05:00">05:00</option>
            <option value="06:00">06:00</option>
            <option value="07:00">07:00</option>
            <option value="08:00">08:00</option>
            <option value="09:00">09:00</option>
            <option value="10:00">10:00</option>
            <option value="11:00">11:00</option>
            <option value="12:00">12:00</option>
            <option value="13:00">13:00</option>
            <option value="14:00">14:00</option>
            <option value="15:00">15:00</option>
            <option value="16:00">16:00</option>
            <option value="17:00">17:00</option>
            <option value="18:00">18:00</option>
            <option value="19:00">19:00</option>
            <option value="20:00">20:00</option>
            <option value="21:00">21:00</option>
            <option value="22:00">22:00</option>
            <option value="23:00">23:00</option>
            <option value="23:59">23:59</option>
        </select>
    </div>

    <div class="selector"><label for='tipo_viajes'>Tipo de viaje:</label>
        <select name='tipo_viajes'>
            <option value="-">-</option>
            <?php
            $tv=0;
            while($tv < count($registro_tipo_viajes)) {
                echo"<option value='".$registro_tipo_viajes[$tv][0]."'>".$registro_tipo_viajes[$tv][1]."</option>";
                $tv++;
            }
            ?>
        </select></div>


    <button type="submit" name="enviar">Buscar</button>
</form>
<?php

    if ($error_fecha == "") {
        if (mysqli_affected_rows($conexion) > 0) {
            echo "<table>
                <thead>
                  <tr>
                    <td>Fecha</td>
                    <td>Hora</td>
                    <td>Tipo de viaje</td>
                    <td>Duracion</td>
                  </tr>
                 </thead>
                 <tbody>";


            while ($lista = mysqli_fetch_assoc($resultado)) {


                echo "<tr>
                    <td>" . $lista['fecha_salida'] . "</td>
                    <td>" . $lista['hora_salida'] . "</td>
                    <td>" . $lista['tipo_viaje'] . "</td>
                    <td>" . $lista['duracion'] . "</td>
                   </tr>";

            }
            echo "</tbody></table>";
        } else {
            echo "<p>No se encontraron vuelos disponibles</p>";
        }
    }
?>

</body>

<?php    include "pie.html";?>
</html>
