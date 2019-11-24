<?php
    // Devuelve el nombre de la estacion segun el ID
    function determina_nombre_estacion($id_estacion) {
        global $conexion;
        $sql_nombre_estacion_origen ="select nombre from estaciones where id='$id_estacion'";
        $resultado = mysqli_query($conexion, $sql_nombre_estacion_origen);
        $estacion = mysqli_fetch_assoc($resultado);
        return $estacion['nombre'];
    }

    // Genera un codigo
    function generarCodigo($longitud, $pattern) {
        $codigo = '';
        $max = strlen($pattern) - 1;
        for ($i = 0; $i < $longitud; $i++) $codigo .= $pattern{mt_rand(0, $max)};
        return $codigo;
    }

?>
