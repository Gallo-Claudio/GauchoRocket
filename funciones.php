<?php
// Devuelve el nombre de la estacion segun el ID
function determina_nombre_estacion($id_estacion) {
    global $conexion;
    $sql_nombre_estacion_origen ="select nombre from estaciones where id='$id_estacion'";
    $resultado = mysqli_query($conexion, $sql_nombre_estacion_origen);
//    $nombre = mysqli_fetch_assoc($resultado);
//    return $nombre;
    $estacion = mysqli_fetch_assoc($resultado);
    return $estacion['nombre'];
}