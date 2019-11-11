<?php
require_once "conexion.php";

        if (empty($_POST['asiento'])) {
            echo "<b>No realizó ninguna selección</b>";
        } else {
            $cantidad_asientos_reservados = $_POST['cantidad_asientos_reservados'];
            $cantidad_asientos_seleccionados = count($_POST['asiento']);
            $codigo_reserva = $_POST['codigo_reserva'];

            if ($cantidad_asientos_seleccionados > $cantidad_asientos_reservados) {
                echo "<b>La cantidad de asientos seleccionados es mayor a lo que tiene en la reserva</b>";
            } else if ($cantidad_asientos_seleccionados < $cantidad_asientos_reservados) {
                echo "<b>La cantidad de asientos seleccionados es menor a lo que tiene en la reserva. Complete la selección de asientos</b>";
            } else {
                foreach ($_POST['asiento'] as $ubicacion_asiento) {
                    $sql = "INSERT INTO ubicacion (codigo_reserva, asiento) VALUES ('$codigo_reserva','$ubicacion_asiento')";
                    $resultado = mysqli_query($conexion, $sql);
                }
                echo "<b>La reserva se realizó con éxito</b>";
            }
        }
?>