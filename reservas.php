<?php
session_start();
$error="";
$conexion = mysqli_connect("127.0.0.1:3307","pw2","pw22019","gauchorocket");

if(!$conexion){
    echo "<p>ERROR de conexion a la BD</p>";
    die;
}
$id_viaje = $_GET['viaje'];
$id_usuario = $_SESSION['id'];
$sql_viaje = "SELECT tv.tipo_viaje , mn.capacidad FROM viajes as v INNER JOIN tipo_viajes as tv
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

$sql_estaciones = "SELECT c.id as circuito,e.id , e.nombre FROM viajes as v INNER JOIN circuitos as c
                    ON v.circuito_id = c.id INNER JOIN circuitos_estaciones as ce
                    ON c.id = ce.circuito_id INNER JOIN estaciones as e
                    ON ce.estacion_id = e.id
                    WHERE v.id = '$id_viaje'
                    ORDER BY e.id ASC";
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
                    $sql_nueva_reserva = "INSERT INTO reservas (cod_vuelo,cantidad,id_usuario) VALUES ('$id_viaje','$cant','$id_usuario');";
                    $consulta = mysqli_query($conexion, $sql_nueva_reserva);
                    $reserva_realizada = true;
                } else {
                    $error = "La reserva no se pudo realizar";
                }

            } elseif ($tipo_viaje == "Entre destinos") {
                $estacion_origen = $_POST['origen'];
                $estacion_destino = $_POST['destino'];
                $sePuedeReservar = false;
                if ($estacion_origen != $estacion_destino && $estacion_destino > $estacion_origen) {
                    $capacidad = $capacidad_nave;
                    $resultado_estaciones = mysqli_query($conexion, $sql_estaciones);
                    while($fila_estaciones = mysqli_fetch_assoc($resultado_estaciones)){
                        $sql_reservas_origen = "SELECT r.cod_vuelo , sum(cantidad) as cantidad FROM reservas as r 
                                                WHERE r.cod_vuelo = '$id_viaje' AND r.estacion_origen = '".$fila_estaciones['id']."'
                                                GROUP BY r.cod_vuelo";
                        $resultado_reservas_origen = mysqli_query($conexion,$sql_reservas_origen);
                        $fila_reservas_origen = mysqli_fetch_assoc($resultado_reservas_origen);
                        if(mysqli_affected_rows($conexion) > 0){
                            $capacidad -= $fila_reservas_origen['cantidad'];
                        }
                        $sql_reservas_destino = "SELECT r.cod_vuelo , sum(cantidad) as cantidad FROM reservas as r 
                                                WHERE r.cod_vuelo = '$id_viaje' AND r.estacion_destino = '".$fila_estaciones['id']."'
                                                GROUP BY r.cod_vuelo";
                        $resultado_reservas_destino = mysqli_query($conexion,$sql_reservas_destino);
                        $fila_reservas_destino = mysqli_fetch_assoc($resultado_reservas_destino);

                        if(mysqli_affected_rows($conexion) > 0){
                            $capacidad += $fila_reservas_destino['cantidad'];
                        }
                        if($fila_estaciones['id'] >= $estacion_origen && $fila_estaciones['id'] <= $estacion_destino){
                            if($capacidad < $cant){
                                $sePuedeReservar = false;
                                break;
                            }
                        }else{
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
                }else{
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
    <title>Registro</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Lobster">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/3.7.2/animate.min.css">
    <link rel="stylesheet" href="css/gr.css">
    <?php include "header.php" ?>
</head>
<div class="w3-container w3-lobster banda">
    <p class="w3-xxxlarge w3-center">Reservas</p><img src="img/cohete-espacial-mini.png" class="animated bounceInUp">
</div>

<div class="w3-display-container">
    <?php
    if ($reserva_realizada == false && $error == "") {
        echo "<form class='w3-container w3-card-4 w3-content' method='POST' action='reservas.php?viaje=".$id_viaje."'>
        <center>Cantidad de pasajes a reservar: <input type='number' name='cant' min='0' ></center><br><br>";

        if ($tipo_viaje == "Entre destinos") {
            echo "<center ><div class='selector' ><label class='w3-xlarge w3-lobster' for='origen' > Origen:</label >
                <select name = 'origen'>";
            while ($fila_estaciones = mysqli_fetch_assoc($resultado_estaciones)) {
                if ($fila_estaciones['circuito'] == 1) {
                    if ($fila_estaciones['id'] != 6) {
                        echo "<option value='" . $fila_estaciones['id'] . "'>" . $fila_estaciones['nombre'] . "</option>";
                    }
                } elseif ($fila_estaciones['circuito'] == 2) {
                    if ($fila_estaciones['id'] != 11) {
                        echo "<option value='" . $fila_estaciones['id'] . "'>" . $fila_estaciones['nombre'] . "</option>";
                    }
                }
            }
            mysqli_data_seek($resultado_estaciones, 0);

            echo "</select></div></center><br>
        <center><div class='selector'><label class='w3-xlarge w3-lobster' for='destino'>Destino:</label>
                <select name='destino'>";
            while ($fila_estaciones = mysqli_fetch_assoc($resultado_estaciones)) {
                if ($fila_estaciones['id'] != 1 && $fila_estaciones['id'] != 2) {
                    echo "<option value='" . $fila_estaciones['id'] . "'>" . $fila_estaciones['nombre'] . "</option>";
                }
            }
        }

        echo "</select></div></center><br>
        <center><button class='w3-button w3-round-xlarge w3-blue' type='submit' name='enviar'>Aceptar</button></center>
    </form>";
    }else if ($reserva_realizada == false && $error != ""){
            echo "<p>$error</p>";
    }else if($reserva_realizada == true){
        echo "<p>La reserva fue realizada con exito</p> <br><br>";
        echo "<a href='inicio.php' class='w3-button w3-round-xlarge w3-blue'>Volver al inicio</a>";
    }


    ?>

</div>
</body>
</html>
<?php
include "pie.html";
?>
