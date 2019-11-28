<?php
    //**********************************************
    // Devuelve el nombre de la estacion segun el ID
    //**********************************************
    function determina_nombre_estacion($id_estacion) {
        global $conexion;
        $sql_nombre_estacion_origen ="select nombre from estaciones where id='$id_estacion'";
        $resultado = mysqli_query($conexion, $sql_nombre_estacion_origen);
        $estacion = mysqli_fetch_assoc($resultado);
        return $estacion['nombre'];
    }

    //*****************
    // Genera un codigo
    //*****************
    function generarCodigo($longitud, $pattern) {
        $codigo = '';
        $max = strlen($pattern) - 1;
        for ($i = 0; $i < $longitud; $i++) $codigo .= $pattern{mt_rand(0, $max)};
        return $codigo;
    }

    //************************************************************
    // Cambia el estado de una reserva caida de activa a no activa
    //************************************************************
    function cambia_estado_reserva_caida($id_reserva){
        global $conexion;
        $sql_actualizar_estado_de_reserva = "update reservas set reserva_activa='0' where id='$id_reserva'";
        mysqli_query($conexion, $sql_actualizar_estado_de_reserva);
    }

    //************************************************************************************************
    // Asigna los espacios de la reserva caida por temas medicos, a otras reservas que estan en espera
    //************************************************************************************************
    function habilita_cupo_en_lista_espera($codigo_vuelo, $cantidad, $circuito_id, $id_viajes, $idCapacidadCabina, $capacidadCabina){
        global $conexion;

        // Busco todas las reservas que estan en lista de espera que correspondan al mismo vuelo
        $sql_reservas_inactivas = "select * from reservas where lista_espera = '1' and codigo_vuelo ='$codigo_vuelo'";
        $resultados_reservas_inactivas = mysqli_query($conexion, $sql_reservas_inactivas);
//        $filas_reservas_inactivas = mysqli_fetch_assoc($resultados_reservas_inactivas);


        // Determino el sentido del viaje (ida o vuelta) y ordeno las estaciones que lo componen
        $sql_sentido_del_vuelo = "select sentido from circuitos where id='$circuito_id'";
        $resultado_sentido_del_vuelo = mysqli_query($conexion,$sql_sentido_del_vuelo);
        $fila_sentido_del_vuelo = mysqli_fetch_assoc($resultado_sentido_del_vuelo);
        $sentido_del_vuelo = $fila_sentido_del_vuelo['sentido'];

        $sql_estaciones = "SELECT c.id as circuito, e.id, e.nombre FROM viajes as v
                    INNER JOIN circuitos as c
                    ON v.circuito_id = c.id
                    INNER JOIN circuitos_estaciones as ce
                    ON c.id = ce.circuito_id
                    INNER JOIN estaciones as e
                    ON ce.estacion_id = e.id
                    WHERE v.id = '$id_viajes'";

        if($sentido_del_vuelo == 'ida'){
            $sql_estaciones .= " ORDER BY e.id asc";
        }else{
            $sql_estaciones .= " ORDER BY e.id desc ";
        }

        $resultado_estaciones = mysqli_query($conexion,$sql_estaciones);



        // Recorro la lista de reservas inactivas obtenidas
        while($registro = mysqli_fetch_array($resultados_reservas_inactivas)){

            if($cantidad >= $registro['cantidad']){

                $sePuedeReservar = false;
                while($fila_estaciones = mysqli_fetch_assoc($resultado_estaciones)){

                    $sql_reservas_destino = "SELECT SUM(cantidad) as cantidad FROM reservas
                                                    WHERE codigo_vuelo = '$codigo_vuelo'
                                                    AND estacion_destino = '" . $fila_estaciones['id'] . "'
                                                    and idCapacidadCabina = '$idCapacidadCabina'
                                                    and reserva_activa = '1'";
                    $resultado_reservas_destino = mysqli_query($conexion, $sql_reservas_destino);
                    $fila_reservas_destino = mysqli_fetch_assoc($resultado_reservas_destino);

                    if (mysqli_affected_rows($conexion) > 0) {
                        $capacidadCabina += $fila_reservas_destino['cantidad'];
                    }

                    $sql_reservas_origen = "SELECT SUM(cantidad) as cantidad FROM reservas
                                                    WHERE codigo_vuelo = '$codigo_vuelo'
                                                    AND estacion_origen = '" . $fila_estaciones['id'] . "'
                                                    and idCapacidadCabina = '$idCapacidadCabina'
                                                    and reserva_activa = '1'";
                    $resultado_reservas_origen = mysqli_query($conexion, $sql_reservas_origen);
                    $fila_reservas_origen = mysqli_fetch_assoc($resultado_reservas_origen);

                    if (mysqli_affected_rows($conexion) > 0) {
                        $capacidadCabina -= $fila_reservas_origen['cantidad'];
                    }


                    if($sentido_del_vuelo == 'ida'){
                        $condicion =  $fila_estaciones['id'] >= $registro['estacion_origen'] && $fila_estaciones['id'] < $registro['estacion_destino'];

                    }else{
                        $condicion = $fila_estaciones['id'] < $registro['estacion_origen'] && $fila_estaciones['id'] >= $registro['estacion_destino'];
                    }

                    if ($condicion) {

                        if ($capacidadCabina < $registro['cantidad']) {
                            $sePuedeReservar = false;
                            break;
                        }
                    } else {
                        $sePuedeReservar = true;
                    }


                    if($sePuedeReservar == true){
                        $id_reserva = $registro['id'];
                        $sql_actualizo_reserva_a_activa = "update reservas set lista_espera='0', reserva_activa='1' where id='$id_reserva'";
                        mysqli_query($conexion, $sql_actualizo_reserva_a_activa);
                    }

                }
                mysqli_data_seek($resultado_estaciones, 0);
                $cantidad --;

            }

        }

    }

    //*********************************************************
    // Activa la lista de espera en los vuelos que correspondan
    //*********************************************************
    function habilita_lista_de_espera (){
        global $conexion;
        date_default_timezone_set('America/Argentina/Buenos_Aires');
        $hora_de_vuelos_que_despegan_ahora = date("Y-m-d H:i:s");
        $hora_de_vuelos_que_despegan_dentro_de_2_horas = date("Y-m-d H:i:s",strtotime($hora_de_vuelos_que_despegan_ahora."+ 2 hour"));

        // Traigo (de todos los vuelos) todas las reservas que no realizaron el checkin. Son vuelos cuyo checkin termino y estan por partir
        $sql_vuelos_checkin_finalizado = "select reservas.id, id_viajes, circuito_id, idCapacidadCabina, reservas.codigo_vuelo, cantidad, (filas*columnas) as capacidadCabina from reservas
                                            inner join viajes
                                            on reservas.id_viajes = viajes.id
                                            inner join capacidad
                                            on reservas.idCapacidadCabina = capacidad.id 
                                            where check_in ='0'
                                            and reserva_activa = '1'
                                            and fecha_hora between '$hora_de_vuelos_que_despegan_ahora' and '$hora_de_vuelos_que_despegan_dentro_de_2_horas'
                                            order by id_viajes asc";
        $resultados_vuelos_checkin_finalizado = mysqli_query($conexion, $sql_vuelos_checkin_finalizado);

        $contador = 1;
        $id_viajes = '';
        while($filas_vuelos_checkin_finalizados = mysqli_fetch_assoc($resultados_vuelos_checkin_finalizado)){

            // Controlo de NO realizar dos veces el proeceso, al mismo vuelo
            if($contador == 1){
                $id_viajes = $filas_vuelos_checkin_finalizados['id_viajes'];
            }
            else if ($id_viajes != $filas_vuelos_checkin_finalizados['id_viajes']){
                $id_viajes = $filas_vuelos_checkin_finalizados['id_viajes'];
            }

            // Con el id de viaje busco todas las reservas DE ESE VUELO (INDIVIDUAL) que no hicieron el checkin
            // y cambio el estado de la reserva a INACTIVA
            $sql_reservas_sin_checkin ="select reservas.id from reservas
                    inner join viajes
                    on reservas.id_viajes = viajes.id
                    where check_in ='0'
                    and id_viajes = '$id_viajes'
                    and fecha_hora between '$hora_de_vuelos_que_despegan_ahora' and '$hora_de_vuelos_que_despegan_dentro_de_2_horas'";
            $resultados_reservas_sin_checkin = mysqli_query($conexion, $sql_reservas_sin_checkin);

            while($filas_reservas_sin_checkin = mysqli_fetch_assoc($resultados_reservas_sin_checkin)){
                cambia_estado_reserva_caida($filas_reservas_sin_checkin['id']);
            }


            $capacidadCabina = $filas_vuelos_checkin_finalizados['capacidadCabina'];
            $cantidad = $filas_vuelos_checkin_finalizados['cantidad'];
            $codigo_vuelo = $filas_vuelos_checkin_finalizados['codigo_vuelo'];
            $idCapacidadCabina = $filas_vuelos_checkin_finalizados['idCapacidadCabina'];
            $circuito_id = $filas_vuelos_checkin_finalizados['circuito_id'];

            // Busco todas las reservas que estan en lista de espera
            $sql_reservas_lista_espera = "select reservas.id from reservas
                                            inner join viajes
                                            on reservas.id_viajes = viajes.id 
                                            where lista_espera ='1'
                                            and reservas.codigo_vuelo ='$codigo_vuelo'
                                            and fecha_hora between '$hora_de_vuelos_que_despegan_ahora' and '$hora_de_vuelos_que_despegan_dentro_de_2_horas'";
            $resultados_reservas_lista_espera = mysqli_query($conexion, $sql_reservas_lista_espera);



            /// GALLO - ver de comprimir
            ////////////////////////////
            // Determino el sentido del viaje (ida o vuelta) y ordeno las estaciones que lo componen
            $sql_sentido_del_vuelo = "select sentido from circuitos where id='$circuito_id'";
            $resultado_sentido_del_vuelo = mysqli_query($conexion,$sql_sentido_del_vuelo);
            $fila_sentido_del_vuelo = mysqli_fetch_assoc($resultado_sentido_del_vuelo);
            $sentido_del_vuelo = $fila_sentido_del_vuelo['sentido'];

            $sql_estaciones = "SELECT c.id as circuito, e.id, e.nombre FROM viajes as v
                    INNER JOIN circuitos as c
                    ON v.circuito_id = c.id
                    INNER JOIN circuitos_estaciones as ce
                    ON c.id = ce.circuito_id
                    INNER JOIN estaciones as e
                    ON ce.estacion_id = e.id
                    WHERE v.id = '$id_viajes'";

            if($sentido_del_vuelo == 'ida'){
                $sql_estaciones .= " ORDER BY e.id asc";
            }else{
                $sql_estaciones .= " ORDER BY e.id desc ";
            }

            $resultado_estaciones = mysqli_query($conexion,$sql_estaciones);



            // Recorro la lista de reservas inactivas obtenidas
            while($registro = mysqli_fetch_array($resultados_reservas_lista_espera)){

                if($cantidad >= $registro['cantidad']){

                    $sePuedeReservar = false;
                    while($fila_estaciones = mysqli_fetch_assoc($resultado_estaciones)){

                        $sql_reservas_destino = "SELECT SUM(cantidad) as cantidad FROM reservas
                                                    WHERE codigo_vuelo = '$codigo_vuelo'
                                                    AND estacion_destino = '" . $fila_estaciones['id'] . "'
                                                    and idCapacidadCabina = '$idCapacidadCabina'
                                                    and reserva_activa = '1'";
                        $resultado_reservas_destino = mysqli_query($conexion, $sql_reservas_destino);
                        $fila_reservas_destino = mysqli_fetch_assoc($resultado_reservas_destino);

                        if (mysqli_affected_rows($conexion) > 0) {
                            $capacidadCabina += $fila_reservas_destino['cantidad'];
                        }

                        $sql_reservas_origen = "SELECT SUM(cantidad) as cantidad FROM reservas
                                                    WHERE codigo_vuelo = '$codigo_vuelo'
                                                    AND estacion_origen = '" . $fila_estaciones['id'] . "'
                                                    and idCapacidadCabina = '$idCapacidadCabina'
                                                    and reserva_activa = '1'";
                        $resultado_reservas_origen = mysqli_query($conexion, $sql_reservas_origen);
                        $fila_reservas_origen = mysqli_fetch_assoc($resultado_reservas_origen);

                        if (mysqli_affected_rows($conexion) > 0) {
                            $capacidadCabina -= $fila_reservas_origen['cantidad'];
                        }


                        if($sentido_del_vuelo == 'ida'){
                            $condicion =  $fila_estaciones['id'] >= $registro['estacion_origen'] && $fila_estaciones['id'] < $registro['estacion_destino'];

                        }else{
                            $condicion = $fila_estaciones['id'] < $registro['estacion_origen'] && $fila_estaciones['id'] >= $registro['estacion_destino'];
                        }

                        if ($condicion) {

                            if ($capacidadCabina < $registro['cantidad']) {
                                $sePuedeReservar = false;
                                break;
                            }
                        } else {
                            $sePuedeReservar = true;
                        }


                        if($sePuedeReservar == true){
                            $id_reserva = $registro['id'];
                            $sql_actualizo_reserva_a_activa = "update reservas set lista_espera='0', reserva_activa='1' where id='$id_reserva'";
                            mysqli_query($conexion, $sql_actualizo_reserva_a_activa);
                        }

                    }
                    mysqli_data_seek($resultado_estaciones, 0);
                    $cantidad --;

                }

            }








            $contador++;
        }


    }



?>
