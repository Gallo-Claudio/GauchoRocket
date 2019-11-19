<?php
require_once "conexion.php";

  $tipo_viajes = $_POST['tipo_viajes'];
  $fecha_salida = $_POST['fecha_salida'];
$origen = $_POST['origen'];
if ($tipo_viajes != 2) {
    $destino = $_POST['destino'];
}

//$tipo_viajes = 1;
//$fecha_salida = "2019-11-17";
//$origen = 1;
//$destino = 1;



$and = " and circuito_id in ";

if ($tipo_viajes == 2) {
    $destino = $origen;
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


$and = determinarCircuito($cantidad, $sentido, $and, $origen, $destino);


$sql = "select viajes.id, fecha_hora, duracion, naveNombre, codigo_vuelo, circuitos.nombre as nombre_circuito, circuito_id from viajes
                left outer join naves
                on viajes.nave = naves.id  
                left outer join modelos_naves
                on naves.modelo = modelos_naves.id
                inner join circuitos
                on viajes.circuito_id = circuitos.id
                where fecha_hora like '$fecha_salida%'
                and tipo_viaje = '$tipo_viajes'
                and origen = '$origen'" . $and;

$resultado = mysqli_query($conexion, $sql);

$json = array();
while ($fila = mysqli_fetch_array($resultado)) {
    $json[] = array(
        'id' => $fila['id'],
        'fecha_hora' => $fila['fecha_hora'],
        'duracion' => $fila['duracion'],
        'nave' => $fila['naveNombre'],
        'codigo_vuelo' => $fila['codigo_vuelo'],
        'circuito' => $fila['nombre_circuito'],
        'destino' => $destino,
        'circuito_id' => $fila['circuito_id']
    );

}

$jsonstring = json_encode($json);

echo $jsonstring;



function estaEnCincoCircuitos($cantidad)
{
    return $cantidad == 5;
}


function circuitoBuenosAires(array $sentido, $and)
{
    $a = $sentido[2][0];
    $and .= "('" . $a . "')";
    return $and;
}


function estaEnMenosDe3Circuitos($cantidad)
{
    return $cantidad < 3;
}


function circuitoDeDosTramos($origen, $destino, array $sentido, $and)
{
    ($origen < $destino) ? $a = $sentido[0][0] : $a = $sentido[1][0];
    $and .= "('" . $a . "')";
    return $and;
}


function esDeIda($origen, $destino)
{
    return $origen < $destino;
}


function elCircuitoEsDeIda(array $sentido, $and)
{
    $a = $sentido[0][0];
    $b = $sentido[1][0];
    $and .= "('" . $a . "','" . $b . "')";
    return $and;
}

function esDeVuelta(array $sentido, $and)
{
    $a = $sentido[2][0];
    $b = $sentido[3][0];
    $and .= "('" . $a . "','" . $b . "')";
    return $and;
}


function determinarCircuito($cantidad, array $sentido, $and, $origen, $destino)
{
//SMELL: el codigo esta atado al orden de las columnas de la tabla y accede por indice mediante un count
    if (estaEnCincoCircuitos($cantidad)) {
        $and = circuitoBuenosAires($sentido, $and);
    } elseif (estaEnMenosDe3Circuitos($cantidad)) {
        $and = circuitoDeDosTramos($origen, $destino, $sentido, $and);
    } elseif (esDeIda($origen, $destino)) {
        $and = elCircuitoEsDeIda($sentido, $and);
    } else {
        $and = esDeVuelta($sentido, $and);
    }
    return $and;
}

?>