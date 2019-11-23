<?php
require_once "conexion.php";

$codigo_reserva = 'CR515';   // LO DEBO RECIBIR POR POST - Ahora lo hardcodeo

$sql_datos_reserva = "select cantidad, cod_vuelo, idCapacidadCabina, filas, columnas, estacion_origen, estacion_destino, naveNombre, cabinaNombre from reservas
                        inner join capacidad
                        on reservas.idCapacidadCabina = capacidad.id
                        inner join modelos_naves
                        on capacidad.modelo = modelos_naves.id
                        inner join cabina
                        on capacidad.tipo_cabina = cabina.id
                        where cod_reserva ='$codigo_reserva'";
$resultado_datos_reserva = mysqli_query($conexion, $sql_datos_reserva);
$datos_reserva = mysqli_fetch_assoc($resultado_datos_reserva);

$cantidad_asientos_reservados = $datos_reserva ['cantidad'];
$id_vuelo = $datos_reserva ['cod_vuelo'];  /// Se deberia renombrar en la tabla reservas el campo cod_vuelo por vuelo, para una mas facil comprension del campo al que hace referencia. OJO de hacer esto corregir el codigo en reservas.php
$tipo_cabina = $datos_reserva ['idCapacidadCabina'];
$filas_cabina = $datos_reserva['filas'];
$columnas_cabina = $datos_reserva['columnas'];
$estacion_origen = $datos_reserva['estacion_origen'];
$estacion_destino = $datos_reserva['estacion_destino'];
$naveNombre = $datos_reserva['naveNombre'];
$cabinaNombre = $datos_reserva['cabinaNombre'];


$sql_datos_nave = "select * from viajes
                    left outer join naves
                    on viajes.nave = naves.id
                    where viajes.id='$id_vuelo'";

$resultado_datos_nave = mysqli_query($conexion, $sql_datos_nave);
$datos_nave = mysqli_fetch_assoc($resultado_datos_nave);
$fecha_hora = $datos_nave['fecha_hora'];
$codigo_vuelo = $datos_nave['codigo_vuelo'];

function determina_estacion($id_estacion) {
    global $conexion;
    $sql_nombre_estacion_origen ="select nombre from estaciones where id='$id_estacion'";
    $resultado = mysqli_query($conexion, $sql_nombre_estacion_origen);
    $nombre = mysqli_fetch_assoc($resultado);
    return $nombre;
}
$nombre_estacion_origen = determina_estacion($estacion_origen);
$nombre_estacion_destino = determina_estacion($estacion_destino);

$sql_menu = "select * from menu";
$resultado_menu = mysqli_query($conexion, $sql_menu);




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
    Datos de la reserva <?php echo $codigo_reserva ?><br><br>
    Vuelo: <?php echo $codigo_vuelo ?><br>
    Fecha/Hora: <?php echo $fecha_hora ?><br>
    Origen: <?php echo $nombre_estacion_origen['nombre'] ?><br>
    Destino: <?php echo $nombre_estacion_destino['nombre'] ?><br>
    Nave: <?php echo $naveNombre ?><br>
    Cabina: <?php echo $cabinaNombre ?><br>
    <span class="destacado">Reserva para: <?php echo $cantidad_asientos_reservados ?> personas</span>
</div>

<form id="ubicacion_asientos">

    Seleccione el menú
    <?php
    echo "<div>";
    while($menu = mysqli_fetch_array($resultado_menu)){
    echo "<label>$menu[nombre_menu]</label><input type='radio' name='menu' value='$menu[id_menu]'>";
    }
    echo "</div>";
    ?>

    Seleccione el/los asientos
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
    <input type="submit" name="enviar" value="Reservar ubicación" id="btn-accion">
    <div id="mensaje"></div>
</form>

<script src="js/jquery.min.js"></script>
<script src="js/seleccion_asientos.js"></script>
</body>
<?php include "pie.html";?>
</html>