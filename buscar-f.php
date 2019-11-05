<?php
require_once "conexion.php";

    $tipo_viajes = $_POST['tipo_viajes'];
    $fecha_salida = $_POST['fecha_salida'];
    $origen = $_POST['origen'];
    $destino = $_POST['destino'];


    $sql = "select viajes_t_final.id, fecha_hora, duracion, modelos_naves.nombre, codigo_vuelo from viajes_t_final
                left outer join naves
                on viajes_t_final.nave = naves.id  
                left outer join modelos_naves
                on naves.modelo = modelos_naves.id
                where fecha_hora like '$fecha_salida%'
                and tipo_viaje = '$tipo_viajes'
                and destino = '$destino'
                and circuitos in
                (select circuito_id from circuitos_estaciones
                where estacion_id = '$destino')";


    $resultado = mysqli_query($conexion, $sql);

    $json = array();
        while($fila = mysqli_fetch_array($resultado)){
            $json[] = array(
                'id' => $fila['id'],
                'fecha' => $fila['fecha'],
                'hora' => $fila['hora'],
//                'origen' => $fila['origen'],
//                'destino' => $fila['destino'],
                'duracion' => $fila['duracion'],
                'nave' => $fila['nombre'],
                'codigo_vuelo' => $fila['codigo_vuelo']
            );
    }

    $jsonstring = json_encode($json);
    echo $jsonstring;

?>

