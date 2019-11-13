<?php
session_start();
$error="";
require_once "conexion.php";
if(!$conexion){
    echo "<p>ERROR de conexion a la BD</p>";
    die;
}
$id_viaje = $_GET['viaje'];
$destino = $_GET['destino'];
$circuito = $_GET['circuito'];
//$id_usuario = $_SESSION['id'];
$id_usuario = '1';  //Lo estoy harcodeando
/****************************************************************************************************************************/
/* se obtiene capacidad total de la nave y otros datos - CORREGIR se debe obtener la capacidad de la cabina seleccionada ****/
/****************************************************************************************************************************/
$sql_viaje = "SELECT tv.tipo_viaje, mn.capacidad, codigo_vuelo, fecha_hora, nombre, origen FROM viajes as v
                        INNER JOIN tipo_viajes as tv
                        ON v.tipo_viaje = tv.id 
                        INNER JOIN naves as n
                        ON v.nave = n.id
                        INNER JOIN modelos_naves as mn
                        ON n.modelo = mn.id
                        WHERE v.id = '$id_viaje'";
$resultado_viaje = mysqli_query($conexion, $sql_viaje);
$fila_viaje = mysqli_fetch_assoc($resultado_viaje);
$tipo_viaje = $fila_viaje['tipo_viaje'];
$capacidad_nave = $fila_viaje['capacidad'];
$codigo_vuelo = $fila_viaje['codigo_vuelo'];
$fecha_hora = $fila_viaje['fecha_hora'];
$nave = $fila_viaje['nombre'];
$origen = $fila_viaje['origen'];
$sql_origen_nombre ="select nombre from viajes
                inner join estaciones
                on viajes.origen = estaciones.id
                where viajes.id = '$id_viaje'";
$resultado_origen_nombre = mysqli_query($conexion, $sql_origen_nombre);
$fila_origen_nombre = mysqli_fetch_assoc($resultado_origen_nombre);
$origen_nombre = $fila_origen_nombre['nombre'];
$sql_destino_nombre ="select nombre from estaciones
                where id = '$destino'";
$resultado_destino_nombre = mysqli_query($conexion, $sql_destino_nombre);
$fila_destino_nombre = mysqli_fetch_assoc($resultado_destino_nombre);
$destino_nombre = $fila_destino_nombre['nombre'];
/**************************************************************************************************************/
/* se obtiene el tipo de circuito y las estaciones que lo integran ********************************************/
/**************************************************************************************************************/
if($circuito<3){
    $sql_estaciones = "SELECT c.id as circuito, e.id, e.nombre FROM viajes as v
                    INNER JOIN circuitos as c
                    ON v.circuito_id = c.id
                    INNER JOIN circuitos_estaciones as ce
                    ON c.id = ce.circuito_id
                    INNER JOIN estaciones as e
                    ON ce.estacion_id = e.id
                    WHERE v.id = '$id_viaje'
                    ORDER BY e.id ASC";
}else{
    $sql_estaciones = "SELECT c.id as circuito, e.id, e.nombre FROM viajes as v
                    INNER JOIN circuitos as c
                    ON v.circuito_id = c.id
                    INNER JOIN circuitos_estaciones as ce
                    ON c.id = ce.circuito_id
                    INNER JOIN estaciones as e
                    ON ce.estacion_id = e.id
                    WHERE v.id = '$id_viaje'
                    ORDER BY e.id desc ";
}
$resultado_estaciones = mysqli_query($conexion,$sql_estaciones);
$error = "";
$reserva_realizada = false;
if(isset($_POST['enviar'])) {
    $cant = $_POST['cant'];
    if ($cant > 0) {
        if ($tipo_viaje == "Tour" || $tipo_viaje == "Suborbitales") {
            $capacidad = $capacidad_nave;
            $sql_reservas = "SELECT r.cod_vuelo , sum(cantidad) as cantidad FROM reservas as r WHERE r.cod_vuelo = '$id_viaje' GROUP BY r.cod_vuelo";
            $resultado = mysqli_query($conexion, $sql_reservas);
            $fila = mysqli_fetch_assoc($resultado);
            $capacidad_disponible = $capacidad - $fila['cantidad'];
            if (($capacidad_disponible - $cant) >= 0) {
                $sql_nueva_reserva = "INSERT INTO reservas (cod_vuelo,cantidad,id_usuario) VALUES ('$id_viaje','$cant','$id_usuario')";
                $consulta = mysqli_query($conexion, $sql_nueva_reserva);
                $reserva_realizada = true;
            } else {
                $error = "La reserva no se pudo realizar";
            }
        } elseif ($tipo_viaje == "Entre destinos") {
            $estacion_origen = $_POST['origen'];
            $estacion_destino = $_POST['destino'];
            $sePuedeReservar = false;
            $capacidad = $capacidad_nave;
            $resultado_estaciones = mysqli_query($conexion, $sql_estaciones);
            while($fila_estaciones = mysqli_fetch_assoc($resultado_estaciones)){
                $sql_reservas_destino = "SELECT r.cod_vuelo , sum(cantidad) as cantidad FROM reservas as r 
                                                    WHERE r.cod_vuelo = '$id_viaje'
                                                    AND r.estacion_destino = '" . $fila_estaciones['id'] . "'
                                                    GROUP BY r.cod_vuelo";
                $resultado_reservas_destino = mysqli_query($conexion, $sql_reservas_destino);
                $fila_reservas_destino = mysqli_fetch_assoc($resultado_reservas_destino);
                if (mysqli_affected_rows($conexion) > 0) {
                    $capacidad += $fila_reservas_destino['cantidad'];
                }
                $sql_reservas_origen = "SELECT r.cod_vuelo, sum(cantidad) as cantidad FROM reservas as r 
                                                    WHERE r.cod_vuelo = '$id_viaje'
                                                    AND r.estacion_origen = '" . $fila_estaciones['id'] . "'
                                                    GROUP BY r.cod_vuelo";
                $resultado_reservas_origen = mysqli_query($conexion, $sql_reservas_origen);
                $fila_reservas_origen = mysqli_fetch_assoc($resultado_reservas_origen);
                if (mysqli_affected_rows($conexion) > 0) {
                    $capacidad -= $fila_reservas_origen['cantidad'];
                }
                if ($fila_estaciones['id'] >= $estacion_origen && $fila_estaciones['id'] < $estacion_destino) {
                    if ($capacidad < $cant) {
                        $sePuedeReservar = false;
                        break;
                    }
                } else {
                    $sePuedeReservar = true;
                }
            }
            if($sePuedeReservar == true){
                $sql_nueva_reserva = "INSERT INTO reservas (cod_vuelo,cantidad,id_usuario,estacion_origen,estacion_destino) 
                                                VALUES ('$id_viaje','$cant','$id_usuario','$estacion_origen','$estacion_destino');";
                $consulta = mysqli_query($conexion, $sql_nueva_reserva);
                $reserva_realizada = true;
            }elseif ($sePuedeReservar == false){
                $error = "La reserva no se pudo realizar";
            }
        }
    } else {
        $error = "La reserva no se pudo realizar";
    }
}
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Reserva de pasajes</title>
    <link rel="stylesheet" href="css/w3.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/3.7.2/animate.min.css">
    <link rel="stylesheet" href="css/gr.css">
</head>
<body>
<?php include "header.php" ?>
<div class="w3-container banda">
    <p class="w3-xxlarge w3-center">Reservas de pasajes</p>
    <div class="datos-reserva">
        Datos de la selección<br><br>
        Tipo de viaje: <?php echo $tipo_viaje ?><br>
        Vuelo: <?php echo $codigo_vuelo ?><br>
        Fecha/Hora: <?php echo $fecha_hora ?><br>
        Origen: <?php echo $origen_nombre ?><br>
        Destino: <?php echo $destino_nombre ?><br>
        Nave: <?php echo $nave ?>
        </span>
    </div>
</div>

<div class="w3-display-container">
    <?php
    if ($reserva_realizada == false && $error == "") {
        echo "<form class='w3-container w3-card-4 w3-content' id='reserva-lugares' method='POST' action='reservas.php?viaje=".$id_viaje."'>
        <center>Cantidad de pasajes a reservar: <input type='number' name='cant' min='0' id='acompaniantes' ></center>
                <input type='hidden' name='origen' value='$origen'>
                <input type='hidden' name='destino' value='$destino'><br><br>
                <div id='area-formularios'></div>
                <div class='limpia-float'></div>
                <center><button class='w3-button w3-round-xlarge w3-blue btn1' type='submit' name='enviar'>Aceptar</button></center>
                </form>";
    }else if ($reserva_realizada == false && $error != ""){
        echo "<p>$error</p>";
    }else if($reserva_realizada == true){
        echo "<p>La reserva fue realizada con exito</p> <br><br>";
        echo "<a href='inicio.php' class='w3-button w3-round-xlarge w3-blue'>Volver al inicio</a>";
    }
    ?>

</div>
<script src="http://code.jquery.com/jquery-1.10.1.min.js"></script>
<script src="js/formulario_acompaniantes.js"></script>
</body>
<?php include "pie.html";?>
</html>