<?php
$conexion = mysqli_connect("127.0.0.1:3307","pw2","pw22019","gauchorocket");
if(!$conexion){
    echo "<p>ERROR de conexion a la BD</p>";
    die;
}
    $tipo_viajes = $_POST['tipo_viajes'];
    $fecha_salida = $_POST['fecha_salida'];
    $origen = $_POST['origen'];
    $destino = $_POST['destino'];

//    $sql = "select * from viajes_t
//                where fecha = '$fecha_salida'
//                and tipo_viaje = '$tipo_viajes'";

    $sql = "select viajes_t.id, fecha, hora, origen, destino, duracion, modelos_naves.nombre from viajes_t
            left outer join naves
            on viajes_t.nave = naves.id  
            left outer join modelos_naves
            on naves.modelo = modelos_naves.id
            where fecha = '$fecha_salida'
            and tipo_viaje = '$tipo_viajes'";

    if (!empty($origen)){
    $sql = $sql . "and origen ='$origen'";
    }

    if (!empty($destino)){
        $sql = $sql . "and destino ='$destino'";
    }

    $resultado = mysqli_query($conexion, $sql);

    $json = array();
//    while($fila = mysqli_fetch_array($resultado)){
//        $json[] = array(
//            'id' => $fila['id'],
//            'fecha' => $fila['fecha'],
//            'hora' => $fila['hora'],
//            'origen' => $fila['origen'],
//            'destino' => $fila['destino'],
//            'duracion' => $fila['duracion'],
//            'nave' => $fila['nave']
//        );
        while($fila = mysqli_fetch_array($resultado)){
            $json[] = array(
                'id' => $fila['id'],
                'fecha' => $fila['fecha'],
                'hora' => $fila['hora'],
                'origen' => $fila['origen'],
                'destino' => $fila['destino'],
                'duracion' => $fila['duracion'],
                'nave' => $fila['nombre']
            );
    }

    $jsonstring = json_encode($json);
    echo $jsonstring;

?>