<?php
require_once "conexion.php";

$codigo_reserva = 'CR15';   // LO DEBO RECIBIR POR POST - Ahora lo hardcodeo

$sql_datos_reserva = "select * from reservas
                        inner join cabina
                        on reservas.tipo_cabina = cabina.id
                        where cod_reserva ='$codigo_reserva'";
$resultado_datos_reserva = mysqli_query($conexion, $sql_datos_reserva);
$datos_reserva = mysqli_fetch_assoc($resultado_datos_reserva);

$cantidad_asientos_reservados = $datos_reserva ['cantidad'];
$vuelo = $datos_reserva ['cod_vuelo'];  /// Se deberia renombrar en la tabla reservas el campo cod_vuelo por vuelo, para una mas facil comprension del campo al que hace referencia. OJO de hacer esto corregir el codigo en reservas.php
$tipo_cabina = $datos_reserva ['tipo_cabina'];
$nombre_cabina = $datos_reserva ['nombre'];


$sql_datos_nave = "select * from viajes
                    left outer join naves
                    on viajes.nave = naves.id
                    left outer join capacidad
                    on naves.modelo = capacidad.modelo
                    where viajes.id='$vuelo'
                    and tipo_cabina='$tipo_cabina'";
$resultado_datos_nave = mysqli_query($conexion, $sql_datos_nave);

$datos_nave = mysqli_fetch_assoc($resultado_datos_nave);
$filas_cabina = $datos_nave['filas'];
$columnas_cabina = $datos_nave['columnas'];
$fecha_hora = $datos_nave['fecha_hora'];
$codigo_vuelo = $datos_nave['codigo_vuelo'];



/* consulto la bd para ver que asientos ya hay reservados */
$sql= "select asiento from ubicacion where codigo_reserva ='$codigo_reserva'";
$resultado = mysqli_query($conexion, $sql);

$registro = mysqli_fetch_assoc($resultado);
$reg=$registro['asiento'];
while ($registro = mysqli_fetch_assoc($resultado)){
    $reg = $reg .','. $registro['asiento'];
}
$array = explode(",", $reg);

?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Reserva de pasajes</title>
    <link rel="stylesheet" href="css/resetcss.css">
    <link rel="stylesheet" href="css/w3.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/3.7.2/animate.min.css">
    <link rel="stylesheet" href="css/gr.css">
</head>
<body>
<?php include "header.php" ?>
<div class="w3-container banda">
    <p class="w3-xxlarge w3-center">Selección de asientos</p>
</div>
<div class="datos-reserva">
    Datos de la reserva<br><br>
    Vuelo: <?php echo $codigo_vuelo ?><br>
    Fecha/Hora: <?php echo $fecha_hora ?><br>
    Origen: <br>
    Destino: <br>
    Nave: <br>
    Cabina: <?php echo $nombre_cabina ?><br>
    <span class="destacado">Reserva para: <?php echo $cantidad_asientos_reservados ?> personas</span>
</div>

<form id="ubicacion_asientos">
    <div id="mensaje"></div>
    <div class="cabina-asientos">
    <input name="cantidad_asientos_reservados" type="hidden" value="<?php echo $cantidad_asientos_reservados ?>">
    <input name="codigo_reserva" type="hidden" value="<?php echo $codigo_reserva ?>">
    <?php
        for ($fila=1; $fila<=$filas_cabina; $fila++){
            echo "<div>";
            for ($columna=1; $columna<=$columnas_cabina; $columna++){
                $ubicacion = "c".$columna."f".$fila;
                $numero_asiento= (($fila-1)*$columnas_cabina+$columna);

                if (in_array($ubicacion, $array)){
                    echo "<label class='reservado'>
                          <p>Asiento ".$numero_asiento."<br>F".$fila." - C".$columna."<br><span class='reservado'>Reservado</span></p>
                          </label>";
                }
                else {
                    echo "<label class='vacante'>
                          <p>Asiento ".$numero_asiento."<br>F".$fila." - C".$columna."</p>
                          <input type='checkbox' name='asiento[]' value='".$ubicacion."'><p class='disponible'>Disponible</p>
                          </label>";
                }
            }
            echo "</div>";
        }
    ?>
    </div>
    <input type="submit" name="enviar" value="Reservar ubicación">
</form>

<script src="http://code.jquery.com/jquery-1.10.1.min.js"></script>
<script src="js/seleccion_asientos.js"></script>
</body>
<?php include "pie.html";?>
</html>