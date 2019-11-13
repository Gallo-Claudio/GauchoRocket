<?php
session_start();
$id_usuario = $_SESSION['id'];
$error="";
require 'conexion.php';

$sql_meses= "SELECT * FROM meses";
$resultado_meses = mysqli_query($conexion,$sql_meses);

$sql_anio= "SELECT * FROM anio";
$resultado_anio = mysqli_query($conexion,$sql_anio);

$sql_pago = "SELECT pago FROM reservas WHERE id_usuario = '$id_usuario'";
$resultado_pago = mysqli_query($conexion,$sql_pago);
$fila_pago = mysqli_fetch_assoc($resultado_pago);

$pago = $fila_pago['pago'];
if($pago == false) {
    if (empty($_POST['enviar'])) {
        echo "<b>Debe completar los campos</b>";
    } else{
        $num_tarjeta = md5($_POST['num_tarjeta']);
        $titular_tarjeta = $_POST['titular_tarjeta'];
        $fecha_expiracion = $_POST['fecha_expiracion'];
        $año_expiracion = $_POST['año_expiracion'];
        $codigo_seguridad = md5($_POST['codigo_seguridad']);



                $sql = "SELECT pago FROM reservas as r 
                        INNER JOIN usuarios as u 
                        ON r.id_usuario = u.id     
                        WHERE r.usuario = '$usuario'";
                $consulta = mysqli_query($conexion, $sql);
                $lista =  mysqli_fetch_all($resultado);
                if (!$consulta) {
                    $error = "<div class='w3-panel w3-red'><p>Los datos ingresados son incorrectos</p></div>";
                    $clase ="animated shake";
                }else{
                    $sql_cod_seguridad = "INSERT INTO usuarios (cod_seguridad) VALUES ('$codigo_seguridad')";
                    $consulta_cod = mysqli_query($conexion, $sql_cod_seguridad);
                    if (!$consulta_cod) {
                        $error = "<div class='w3-panel w3-red'><p>ERROR<br>Ingrese un numero de seguridad correcto</p></div>";
                        $clase = "animated shake";
                    }
                }
            }
        if(!empty($lista)){
            $error = "<div class='w3-panel w3-red'><p>Ya ha abonado esta reserva anteriormente</p></div>";
            $clase ="animated shake";
        }

    }else {
    $error = "<div class='w3-panel w3-red'><p>Pago realizado con éxito</p></div>";
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
    <link rel="stylesheet" href="css/gr.css">
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Lobster">
    <!-- Bootstrap -->
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>
<?php include "header.php" ?>

<div class="w3-container w3-lobster banda">
    <p class="w3-xxxlarge w3-center">Abonar<img src="img/cohete-espacial-mini.png" class="animated bounceInUp"></p>
</div>
<!-- DATOS QUE ESTAN EN LA TARJETA-->
<div class="checkout">
    <div class="credit-card-box">
        <div class="flip">
            <div class="front">
                <div class="number"></div>
                    <div class="card-holder">
                        <label>Titular de la tarjeta</label>
                        <div></div>
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
                    <label >Codigo de seguridad</label>
                    <div></div>
                </div>
            </div>
        </div>
    </div>

    <!-- ACA COMIENZA EL FORMULARIO-->

    <form class="form" autocomplete="off" action="pago.php" method="post">
        <fieldset name="num_tarjeta">
            <label for="card-number">Número de tarjeta</label>
            <input type="num" id="card-number" class="input-cart-number" maxlength="4"  />
            <input type="num" id="card-number-1" class="input-cart-number" maxlength="4" />
            <input type="num" id="card-number-2" class="input-cart-number" maxlength="4" />
            <input type="num" id="card-number-3" class="input-cart-number" maxlength="4" />
        </fieldset>
        <fieldset>
            <label for="card-holder">Titular de la tarjeta</label>
            <input type="text" id="card-holder" name="titular_tarjeta" />
        </fieldset>

        <fieldset class="fieldset-expiration">

            <label for="card-expiration-month">Fecha de expiracion</label>
            <div class="select">
                <select id="card-expiration-month" name="fecha_expiracion">

                    <?php
                    while ($fila_meses = mysqli_fetch_assoc($resultado_meses)){
                        echo "<option value='" . $fila_meses['id'] . "'>" . $fila_meses['meses'] . "</option>";
                    }
                    ?>
                </select>
            </div>

            <div class="select">
               <select id="card-expiration-year" name="año_expiracion">
                   <option>2019</option>
                   <option>2020</option>
                   <option>2021</option>
                   <option>2022</option>
                   <option>2023</option>
                   <option>2024</option>
                   <option>2025</option>
                </select>
            </div>
        </fieldset>
        <fieldset class="fieldset-ccv">
            <label for="card-ccv">Codigo de seguridad</label>
            <input type="text" id="card-ccv"  maxlength="3" name="codigo_seguridad">
        </fieldset>
        <button class="btn"><i class="fa fa-lock" name="enviar"></i> Aceptar</button>
    </form>

<!-- partial -->
<script src='https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script><script  src="js/tarjeta_credito.js"></script>
</div>
</body>
<?php
include "pie.html";
?>
</html>
