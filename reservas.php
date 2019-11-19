<?php
session_start();
$error="";
require_once "conexion.php";

$id_viaje = $_GET['viaje'];
$id_destino = $_GET['destino'];
$circuito = $_GET['circuito'];
//$id_usuario = $_SESSION['id']; // Lo harcodeo para codear sin tener que loguearme y hacer mas rapido las verificacion de lo que hago
$id_usuario = 1;
$reserva_realizada = false;

//Inicializo los array que van a conformar el formulario de acompañantes para pasarlos al "formulario_acomaniantes.js" que los renderiza
$nombre=array();
$apellido=array();
$email=array();


/****************************************************************************************************************************/
/* Se obtiene capacidad de las cabinas y otros datos ************************************************************************/
/****************************************************************************************************************************/
$sql_viaje = "SELECT tv.tipo_viaje, codigo_vuelo, fecha_hora, naveNombre, origen, cabinaNombre,
                     precio, capacidad.id as idCapacidadCabina FROM viajes as v
                        INNER JOIN tipo_viajes as tv
                        ON v.tipo_viaje = tv.id 
                        INNER JOIN naves as n
                        ON v.nave = n.id
                        INNER JOIN modelos_naves as mn
                        ON n.modelo = mn.id
                        inner join capacidad
                        on capacidad.modelo = mn.id
                        inner join cabina
                        on capacidad.tipo_cabina = cabina.id
                        WHERE v.id = '$id_viaje'";
$resultado_viaje = mysqli_query($conexion, $sql_viaje);

$fila_viaje = mysqli_fetch_assoc($resultado_viaje);
$tipo_viaje = $fila_viaje['tipo_viaje'];
$codigo_vuelo = $fila_viaje['codigo_vuelo'];
$fecha_hora = $fila_viaje['fecha_hora'];
$nave = $fila_viaje['naveNombre'];
$origen = $fila_viaje['origen'];


/**************************************************************************************************************/
/* se obtiene el nombre de la estacion origen del viaje *******************************************************/
/**************************************************************************************************************/
$sql_origen_nombre ="select nombre from viajes
                inner join estaciones
                on viajes.origen = estaciones.id
                where viajes.id = '$id_viaje'";
$resultado_origen_nombre = mysqli_query($conexion, $sql_origen_nombre);
$fila_origen_nombre = mysqli_fetch_assoc($resultado_origen_nombre);
$origen_nombre = $fila_origen_nombre['nombre'];


/**************************************************************************************************************/
/* se obtiene el nombre de la estacion destino del viaje  *****************************************************/
/**************************************************************************************************************/
$sql_destino_nombre ="select nombre from estaciones
                where id = '$id_destino'";
$resultado_destino_nombre = mysqli_query($conexion, $sql_destino_nombre);
$fila_destino_nombre = mysqli_fetch_assoc($resultado_destino_nombre);
$destino_nombre = $fila_destino_nombre['nombre'];
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
        Datos de la busqueda seleccionada<br><br>
        Tipo de viaje: <?php echo $tipo_viaje ?><br>
        Vuelo: <?php echo $codigo_vuelo ?><br>
        Fecha/Hora: <?php echo $fecha_hora ?><br>
        Origen: <?php echo $origen_nombre ?><br>
        Destino: <?php echo $destino_nombre ?><br>
        Nave: <?php echo $nave ?>
    </div>
</div>

<div class="w3-display-container">
    <?php
    if ($reserva_realizada == false && $error == "") {
        echo "<form class='w3-container w3-card-4 w3-content' id='reserva-lugares'>
              
                Seleccione la cabina donde desea realizar su reserva
                <table>
                  <tr>
                    <th>Nombre de la cabina</th>
                    <th>Precio del pasajes</th>
                    <th></th>
                  </tr>
                  <tr>
                    <td>".$fila_viaje['cabinaNombre']."</td>
                    <td>".$fila_viaje['precio']."</td>
                    <td><input type='radio' name='idCapacidadCabina' value='".$fila_viaje['idCapacidadCabina']."'></td>
                  </tr>";

                while ($fila_viaje = mysqli_fetch_assoc($resultado_viaje)){
                    echo "<tr>
                            <td>".$fila_viaje['cabinaNombre']."</td>
                            <td>".$fila_viaje['precio']."</td>
                            <td><input type='radio' name='idCapacidadCabina' value='".$fila_viaje['idCapacidadCabina']."'></td>
                          </tr></table>";
                }

                echo "<center>Cantidad de pasajes a reservar:
                <input type='number' name='cantidad_pasajes_a_reservar' min='0' id='acompaniantes' value='$cantidad_pasajes_a_reservar'></center>
        
                <input type='hidden' name='id_destino' value='$id_destino'>
                <input type='hidden' name='id_viaje' value='$id_viaje'>
                <input type='hidden' name='tipo_viaje' value='$tipo_viaje'><br><br> 
                
                <!-- Sector formularios de acompañantes-->       
                <div id='area-formularios'></div>
                <div class='limpia-float'></div>
                
                <div id='mensaje'></div>
                
                <center><button class='w3-button w3-round-xlarge w3-blue btn1' type='submit' name='enviar'>Aceptar</button></center>
                <center><a class='w3-button w3-round-xlarge w3-blue btn1' href='buscador.php'>Volver al buscador</a></center>
                </form>";
    }
?>

</div>
<script src="js/jquery.min.js"></script>
<script src="js/formulario_acompaniantes.js"></script>
<script src="js/jquery-2.2.4.min.js"></script>
<!-- <script src="http://code.jquery.com/jquery-1.10.1.min.js"></script> -->
<script src="js/control_reservas_pasajes.js"></script>
</body>
<?php include "pie.html";?>
</html>