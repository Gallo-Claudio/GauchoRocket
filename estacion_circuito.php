<?php
$conexion = mysqli_connect("127.0.0.1:3307","pw2","pw22019","gauchorocket");
if(!$conexion){
    echo "<p>ERROR de conexion a la BD</p>";
    die;
}
    $origen = $_POST['origen'];


    $sql = "select distinct estaciones.id, estaciones.nombre from circuitos_estaciones
        inner join estaciones
        on circuitos_estaciones.estacion_id = estaciones.id
        where circuito_id in
        (select circuito_id from circuitos_estaciones
        where estacion_id ='$origen')";
    $resultado = mysqli_query($conexion, $sql);


    $json = array();

        while($fila = mysqli_fetch_array($resultado)){
            $json[] = array(
                'id' => $fila['id'],
                'nombre' => $fila['nombre']
            );
    }

    $jsonstring = json_encode($json);
    echo $jsonstring;

?>


