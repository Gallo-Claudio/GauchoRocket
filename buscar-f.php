<?php
require_once "conexion.php";
//    $tipo_viajes = $_POST['tipo_viajes'];
//    $fecha_salida = $_POST['fecha_salida'];
//    $origen = $_POST['origen'];
//    if ($tipo_viajes != 2) {
//        $destino = $_POST['destino'];
//    }
$tipo_viajes = 2;
$fecha_salida = "2019-11-17";
$origen = 1;
$destino =1;
$and = " and circuito_id in ";
if($tipo_viajes==2){
    $destino=$origen;
}
/* obtengo de acuerdo al destino los numeros de los circuitos (ida y vuelta) que pasan por la estacion */
$sql_sentido = "select circuito_id from circuitos_estaciones
                    where estacion_id = '$destino'";
$resultado_sentido = mysqli_query($conexion, $sql_sentido);
$sentido = mysqli_fetch_all($resultado_sentido);
// si el valor de cantidad es 2 estoy obteniendo los valores de ida/vuelta de un circuito
// si el valor de cantidad es 4 estoy recibiendo los valores de ida/vuelta de los dos circuitos
$cantidad = count($sentido);
// Determino que valor enviar a la consulta de acuerdo a si recibi los valores de 1 o de 2 circuitos
// y de si es de ida (origen<destino) o de vuelta (origen>destino)
// caso especial el primer if --> el viaje es orbital o tour
if($cantidad==5){
    $a=$sentido[2][0];
    $and .= "('".$a."')";
}
elseif($cantidad<3){
    ($origen<$destino)? $a=$sentido[0][0]:$a=$sentido[1][0];
    $and .= "('".$a."')";
}
else {
    if($origen<$destino){
        $a=$sentido[0][0];
        $b=$sentido[1][0];
        $and .= "('".$a."','".$b."')";
    }
    else {
        $a=$sentido[2][0];
        $b=$sentido[3][0];
        $and .= "('".$a."','".$b."')";
    }
}
$sql = "select viajes.id, fecha_hora, duracion, modelos_naves.nombre, codigo_vuelo, circuitos.nombre as nombre_circuito, circuito_id from viajes
                left outer join naves
                on viajes.nave = naves.id  
                left outer join modelos_naves
                on naves.modelo = modelos_naves.id
                inner join circuitos
                on viajes.circuito_id = circuitos.id
                where fecha_hora like '$fecha_salida%'
                and tipo_viaje = '$tipo_viajes'
                and origen = '$origen'".$and;
$resultado = mysqli_query($conexion, $sql);
$json = array();
while($fila = mysqli_fetch_array($resultado)){
    $json[] = array(
        'id' => $fila['id'],
        'fecha_hora' => $fila['fecha_hora'],
        'duracion' => $fila['duracion'],
        'nave' => $fila['nombre'],
        'codigo_vuelo' => $fila['codigo_vuelo'],
        'circuito' => $fila['nombre_circuito'],
        'destino' => $destino,
        'circuito_id' => $fila['circuito_id']
    );
}
$jsonstring = json_encode($json);
echo $jsonstring;
?>