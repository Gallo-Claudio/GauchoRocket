<?php
session_start();
//$id_usuario = $_SESSION['id'];
$id_usuario = 1;
$cod_reserva = $_GET['reserva'];
$error="";
require 'conexion.php';

$año_actual = (int)date(Y);
$mes_actual = (int)date(m);

$sql_meses = "SELECT * FROM meses";
$resultado_meses = mysqli_query($conexion, $sql_meses);

$sql_pago = "SELECT pago FROM reservas WHERE cod_reserva = '$cod_reserva'";
$resultado_pago = mysqli_query($conexion, $sql_pago);
$fila_pago = mysqli_fetch_assoc($resultado_pago);
$pagoRealizado = $fila_pago['pago'];

$sql_tarjetas = "SELECT id , tipo_tarjeta FROM tarjetas_credito";
$resultado_tarjetas = mysqli_query($conexion,$sql_tarjetas);

$sql_datos_reserva = "SELECT cap.precio,cab.nombre,r.cantidad FROM reservas as r
                    INNER JOIN capacidad as cap
                    ON r.idCapacidadCabina = cap.id
                    INNER JOIN cabina as cab
                    ON cap.tipo_cabina = cab.id
                    WHERE r.cod_reserva = '$cod_reserva'";
$resultado_datos_reserva = mysqli_query($conexion,$sql_datos_reserva);
$fila_datos_reserva = mysqli_fetch_assoc($resultado_datos_reserva);
$cabina = $fila_datos_reserva['nombre'];
$precio = $fila_datos_reserva['precio'] * $fila_datos_reserva['cantidad'];
if ($pagoRealizado == false) {
    if (isset($_POST['enviar'])) {
        if (isset($_POST['num_tarjeta'])  && isset($_POST['tipo_tarjeta']) &&
            isset($_POST['titular_tarjeta']) && isset($_POST['fecha_expiracion'])
            && isset($_POST['año_expiracion']) && isset($_POST['codigo_seguridad'])) {
            $tarjeta = $_POST['num_tarjeta'];
            foreach ($tarjeta as $t){
                $num_tarjeta.=$t;
            }
            $tipo_tarjeta = $_POST['tipo_tarjeta'];
            $titular_tarjeta = $_POST['titular_tarjeta'];
            $fecha_expiracion = ($_POST['fecha_expiracion']);
            $año_expiracion = $_POST['año_expiracion'];
            $codigo_seguridad = ($_POST['codigo_seguridad']);

            if($año_expiracion < $año_actual || ($año_expiracion == $año_actual && $fecha_expiracion<$mes_actual)){
                $error = "<div class='w3-panel w3-red w3-center'><p>La tarjeta ingresada esta vencida.</p></div>";
                $pagoRealizado = false;
            }else if(validarTarjeta($num_tarjeta,$tipo_tarjeta,$conexion) == true){
                $sql_pago = "UPDATE reservas SET pago = 1 WHERE cod_reserva = '$cod_reserva'";
                $resultado_pago = mysqli_query($conexion,$sql_pago);
                $pagoRealizado = true;
                $error =  $error = "<div class='w3-panel w3-green w3-center'><p>El pago ha sido realizado con exito.</p></div>";
            }else{
                $error = "<div class='w3-panel w3-red w3-center'><p>La tarjeta ingresada es incorrecta.</p></div>";
                $pagoRealizado = false;
            }
        } else {
            $error = "<div class='w3-panel w3-red w3-center'><p>Complete todos los datos</p></div>";
            $pagoRealizado = false;
        }
    }
}else {
    $error = "<div class='w3-panel w3-red w3-center'><p>Ya ha abonado esta reserva anteriormente</p></div>";
    $clase = "animated shake";
}

function validarTarjeta($numero_tarjeta, $tipo_tarjeta,$conexion){
    $sql_validacion_tarjetas = "SELECT validacion_tarjeta FROM tarjetas_credito WHERE id = '$tipo_tarjeta'";
    $resultado_validacion_tarjetas = mysqli_query($conexion,$sql_validacion_tarjetas);

    while ($fila_validacion = mysqli_fetch_assoc($resultado_validacion_tarjetas)){
        if (preg_match($fila_validacion['validacion_tarjeta'], $numero_tarjeta)) {
            $tarjeta_valida = true;
        } else {
            $tarjeta_valida = false;
        }
    }
    return $tarjeta_valida;
}
?>

<!DOCTYPE html>
<html lang="en" >
<head>
    <meta charset="UTF-8">
    <title>Abonar</title>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/5.0.0/normalize.min.css">
    <link rel='stylesheet' href='https://fonts.googleapis.com/css?family=Inconsolata'>
    <link rel='stylesheet' href='https://fonts.googleapis.com/css?family=Open+Sans'>
    <link rel='stylesheet' href='https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css'>
    <link rel="stylesheet" href="css/style.css">

    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Lobster">
    <!-- Bootstrap -->
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/gr.css">
</head>

<body>
<?php include "header.php" ?>

<div class="w3-container w3-lobster banda">
    <p class="w3-xxxlarge w3-center">Abonar<img src="img/cohete-espacial-mini.png" class="animated bounceInUp"></p><br>
    <div class="w3-container w3-lobster">
        <p class="w3-xlarge w3-center">Datos de la reserva<p></p><br><br>
        <p class="w3-large">Reserva: "<?php echo $cod_reserva ?>"</p><br>
        <p class="w3-large">Cabina:<?php echo $cabina ?></p><br>
        <p class="w3-large">Precio: $<?php echo $precio ?></p><br>
    </div>
</div>
<?php
if($pagoRealizado == false) {
    echo $error;
    ?>
    <!-- DATOS QUE ESTAN EN LA TARJETA-->
    <div class="checkout">
        <div class="credit-card-box">
            <div class="flip">
                <div class="front">
                    <div class="number"></div>
                    <div class="card-holder">
                        <label>Titular de la tarjeta</label>
                    </div>
                    <div class="card-expiration-date">
                        <label>Expira</label>
                        <div></div>
                    </div>
                </div>
                <div class="back">
                    <div class="strip"></div>
                    <div class="logo">

                    </div>
                    <div class="ccv">
                        <label>Codigo de seguridad</label>
                        <div></div>
                    </div>
                </div>
            </div>
        </div>


    <!-- ACA COMIENZA EL FORMULARIO-->

        <form class="form" autocomplete="off" action="pago.php?reserva=<?php echo $cod_reserva; ?>" method="post">
            <fieldset name="num_tarjeta">
                <label for="card-number">Número de tarjeta</label>
                <input type="num" id="card-number" class="input-cart-number" maxlength="4" name="num_tarjeta[]"/>
                <input type="num" id="card-number-1" class="input-cart-number" maxlength="4" name="num_tarjeta[]"/>
                <input type="num" id="card-number-2" class="input-cart-number" maxlength="4" name="num_tarjeta[]"/>
                <input type="num" id="card-number-3" class="input-cart-number" maxlength="4" name="num_tarjeta[]"/>
            </fieldset>
            <fieldset name="tipo_tarjeta">
                <label for="card-type">Tipo de Tarjeta</label>
                <div class="select">
                    <select id="card-type" name="tipo_tarjeta">

                        <?php
                        while ($fila_tipo_tarjeta = mysqli_fetch_assoc($resultado_tarjetas)) {
                            echo "<option value='" . $fila_tipo_tarjeta['id'] . "'>" . $fila_tipo_tarjeta['tipo_tarjeta'] . "</option>";
                        }
                        ?>
                    </select>
                </div>
            </fieldset>
            <fieldset>
                <label for="card-holder">Titular de la tarjeta</label>
                <input type="text" id="card-holder" name="titular_tarjeta"/>
            </fieldset>

            <fieldset class="fieldset-expiration">

                <label for="card-expiration-month">Fecha de expiracion</label>
                <div class="select">
                    <select id="card-expiration-month" name="fecha_expiracion">

                        <?php
                        while ($fila_meses = mysqli_fetch_assoc($resultado_meses)) {
                            echo "<option value='" . $fila_meses['id'] . "'>" . $fila_meses['meses'] . "</option>";
                        }
                        ?>
                    </select>
                </div>

                <div class="select">
                    <select id="card-expiration-year" name="año_expiracion">
                        <?php
                        for ($i = $año_actual; $i <= ($año_actual + 6); $i++) {
                            echo "<option value='" . $i . "'>$i</option>";
                        }
                        ?>
                    </select>
                </div>
            </fieldset>
            <fieldset class="fieldset-ccv">
                <label for="card-ccv">Codigo de seguridad</label>
                <input type="text" id="card-ccv" maxlength="3" name="codigo_seguridad">
            </fieldset>
            <button class="btn" type="submit" name="enviar"><i class="fa fa-lock" name="enviar"></i>Aceptar</button>
        </form>
    </div>
    <?php
}else if ($pagoRealizado == true){
    echo $error;
    echo "<br>";
    echo "<div class='w3-center'><a href='inicio.php' class='w3-button w3-round-xlarge w3-blue'>Volver al inicio</a></div>";
}
?>
<!-- partial -->
<script src='https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script><script  src="js/tarjeta_credito.js"></script>
</body>
<?php
include "pie.html";
?>
</html>
