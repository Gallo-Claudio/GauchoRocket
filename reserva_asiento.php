<?php
require_once "conexion.php";

$cantidad_asientos_reservados = $_POST['cantidad_asientos_reservados'];
$cantidad_asientos_seleccionados = count($_POST['asiento']);
$codigo_reserva = $_POST['codigo_reserva'];
$menu = $_POST['menu'];

$validaciones=true;


        if (empty($menu)) {
        $error = "<p>Tiene que seleccionar un menú para el viaje</p>";
        $class_error_alerta ="animated shake w3-red";
        $validaciones=false;
        }

        if (empty($cantidad_asientos_seleccionados)) {
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
                $asientos .= $ubicacion_asiento."<br>";
            }
            $sql_menu = "update reservas set menu_elegido='".$menu."' where cod_reserva='".$codigo_reserva."'";
            $resultado_menu = mysqli_query($conexion, $sql_menu);

            $error = "<p>Los asientos seleccionados, quedaron asignados a su reserva</p>";
            $class_error_alerta ="w3-green";
            $estado="ok";



            //*****************************    Obtengo datos para el QR   ***********************************************
            // **********************************************************************************************************

            $sql_datos_para_qr = "select distinct fecha_hora, naveNombre, cabinaNombre, tipo_viajes.tipo_viaje as tipo_viaje, est1.nombre as estacion_origen,
                                                 est2.nombre as estacion_destino, codigo_vuelo, nombre_menu from reservas
                                    inner join viajes
                                    on reservas.cod_vuelo = viajes.id
                                    inner join naves
                                    on viajes.nave = naves.id
                                    inner join modelos_naves
                                    on naves.modelo = modelos_naves.id
                                    inner join tipo_viajes
                                    on viajes.tipo_viaje = tipo_viajes.id
                                    inner join capacidad
                                    on reservas.idCapacidadCabina = capacidad.id
                                    inner join cabina
                                    on capacidad.tipo_cabina = cabina.id
                                    inner join estaciones as est1
                                    on reservas.estacion_origen = est1.id
                                    inner join estaciones as est2
                                    on reservas.estacion_destino = est2.id
                                    inner join menu
                                    on reservas.menu_elegido = menu.id_menu
                                    where reservas.cod_reserva = '$codigo_reserva'";
            $resultado_datos_para_qr = mysqli_query($conexion,$sql_datos_para_qr);
            $fila_datos_para_qr = mysqli_fetch_assoc($resultado_datos_para_qr);
            $fecha_hora = $fila_datos_para_qr['fecha_hora'];
            $naveNombre = $fila_datos_para_qr['naveNombre'];
            $cabinaNombre = $fila_datos_para_qr['cabinaNombre'];
            $tipo_viaje = $fila_datos_para_qr['tipo_viaje'];
            $estacion_origen = $fila_datos_para_qr['estacion_origen'];
            $estacion_destino = $fila_datos_para_qr['estacion_destino'];
            $codigo_vuelo = $fila_datos_para_qr['codigo_vuelo'];
            $nombre_menu = $fila_datos_para_qr['nombre_menu'];



            //***************************************************************************
            //                        CODIGO DE EMBARQUE
            //***************************************************************************
            function generarCodigo($longitud) {
                $key = '';
                $pattern = '1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZ';
                $max = strlen($pattern)-1;
                for($i=0;$i < $longitud;$i++) $key .= $pattern{mt_rand(0,$max)};
                return $key;
            }
            $codigo_embarque = generarCodigo(4);



            //***************************************************************************
            //                        CODIGO QR
            //***************************************************************************
            require 'librerias/phpqrcode/qrlib.php';

            $dir = 'img/qr/';
            $archivo = 'codigo-'.$codigo_reserva.'.png';
            $filename = $dir.$archivo;

            $tamanio = 4;
            $level = 'H';
            $frameSize = 1;
            $contenido = 'DATOS DE LA RESERVA<br>
              ------------------------------------------<br><br>
              Fecha: '.$fecha_hora.'<br>
              Origen: '.$estacion_origen.'<br>
              Destino: '.$estacion_destino.'<br>
              Tipo de viaje: '.$tipo_viaje.'<br>
              Codigo de Vuelo: '.$codigo_vuelo.'<br><br>
              Nave: '.$naveNombre.'<br>
              Cabina: '.$cabinaNombre.'<br>
              Asientos: <b>'.$asientos.'</b><br>
              Menu: '.$nombre_menu.'<br><br>
              Codigo de embarque: <b><span style="font-size: 26px; display: block">'.$codigo_embarque.'</span><b>';

            QRcode::png($contenido, $filename, $level, $tamanio, $frameSize);

            $codigo_qr = "<img src=".$filename." />";

            $sql_codigos = "update reservas set codigo_qr='".$archivo."', codigo_embarque='".$codigo_embarque."' where cod_reserva='".$codigo_reserva."'";
            $resultado_codigos = mysqli_query($conexion, $sql_codigos);

        }



$mensajeFinal = array('mensaje' => $error, 'clase' => $class_error_alerta, 'asientos' => $asientos, 'codigo_embarque' => $codigo_embarque, 'qr' => $codigo_qr, 'estado' => $estado);
$jsonstring = json_encode($mensajeFinal);
echo $jsonstring;

?>