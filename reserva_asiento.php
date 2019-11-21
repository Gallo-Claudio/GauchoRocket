<?php
require_once "conexion.php";

$cantidad_asientos_reservados = $_POST['cantidad_asientos_reservados'];
$cantidad_asientos_seleccionados = count($_POST['asiento']);
$codigo_reserva = $_POST['codigo_reserva'];
$menu = $_POST['menu'];
$validaciones=true;

        if (empty($_POST['menu'])) {
        $error = "<p>Tiene que seleccionar un menú para el viaje</p>";
        $class_error_alerta ="animated shake w3-red";
        $validaciones=false;
        }

        if (empty($_POST['asiento'])) {
            $error .= "<p>No selecciono ningún asiento</p>";
            $class_error_alerta ="animated shake w3-red";
            $validaciones=false;
        } else {
            if ($cantidad_asientos_seleccionados > $cantidad_asientos_reservados) {
                $error .= "<p>La cantidad de asientos seleccionados es mayor a lo que tiene en la reserva</p>";
                $class_error_alerta = "animated shake w3-red";
                $validaciones=false;
            }
            elseif($cantidad_asientos_seleccionados < $cantidad_asientos_reservados){
                $error .= "<p>La cantidad de asientos seleccionados es menor a lo que tiene en la reserva. Complete la selección de asientos</p>";
                $class_error_alerta = "animated shake w3-red";
                $validaciones=false;
            }
        }

        if ($validaciones==true){
            foreach ($_POST['asiento'] as $ubicacion_asiento) {
                $sql = "INSERT INTO ubicacion (codigo_reserva, asiento) VALUES ('$codigo_reserva','$ubicacion_asiento')";
                $resultado = mysqli_query($conexion, $sql);
            }
            $sql_menu = "update reservas set menu_elegido='".$menu."' where cod_reserva='".$codigo_reserva."'";
            $resultado_menu = mysqli_query($conexion, $sql_menu);

            $error = "<p>Los asientos seleccionados, quedaron asignados a su reserva</p>";
            $class_error_alerta ="w3-green";
            $estado="ok";
        }


$mensajeFinal = array('mensaje' => $error,'clase' => $class_error_alerta,'estado' => $estado);
$jsonstring = json_encode($mensajeFinal);
echo $jsonstring;

?>