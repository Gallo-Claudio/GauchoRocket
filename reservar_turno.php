<?php
session_start();
$id_usuario = $_SESSION['id'];
$error="";
require 'conexion.php';
$sql_centro_medico = "SELECT * FROM centros_medicos";
$resultado_centro_medico = mysqli_query($conexion,$sql_centro_medico);
$hoy = date("Y-m-d");
$fecha_minimo = date("Y-m-d",strtotime($hoy."+ 1 days"));
$nuevo_turno = false;
$sql_se_chequeo = "SELECT se_chequeo FROM usuarios WHERE id = '$id_usuario'";
$resultado_se_chequeo = mysqli_query($conexion,$sql_se_chequeo);
$fila_se_chequeo = mysqli_fetch_assoc($resultado_se_chequeo);
$se_chequeo = $fila_se_chequeo['se_chequeo'];
if($se_chequeo == false) {
    if (isset($_POST['enviar'])) {
        $centro_medico = $_POST['centro_medico'];
        $fecha = $_POST['fecha'];
        if ($fecha >= $fecha_minimo) {
            $sql_cantidad = "SELECT turnos_diarios FROM centros_medicos WHERE id = '$centro_medico'";
            $resultado_cantidad = mysqli_query($conexion, $sql_cantidad);
            $fila_cantidad = mysqli_fetch_assoc($resultado_cantidad);
            $cantidad_turnos = $fila_cantidad['turnos_diarios'];

            $sql_turnos = "SELECT COUNT (t.id) as cantidad FROM turnos as t inner join centros_medicos as cm on t.centro_medico = cm.id WHERE cm.id = '$centro_medico'";
            $resultado_turnos = mysqli_query($conexion, $sql_turnos);
            if (mysqli_affected_rows($conexion) > 0) {
                $fila_turnos = mysqli_fetch_assoc($resultado_turnos);
                $cantidad_turnos -= $fila_turnos['cantidad'];
            }
            if ($cantidad_turnos > 0) {
                $sql_nuevo_turno = "INSERT INTO turnos (fecha,id_usuario,centro_medico) values('$fecha','$id_usuario','$centro_medico')";
                $resultado_nuevo_turno = mysqli_query($conexion, $sql_nuevo_turno);
                $nuevo_turno = true;
            } else {
                $error = "No hay mas turnos disponibles para esta fecha";
            }
        } else {
            $error = "La fecha ingresada es incorrecta";
        }
    }
}else {
    $error = "El usuario ya realizo el chequeo medico.";
}
?>
    <!DOCTYPE html>
    <html lang="es">
    <head>
        <meta charset="UTF-8">
        <title>Iniciar sesión</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Lobster">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/3.7.2/animate.min.css">
        <link rel="stylesheet" href="css/gr.css">
    </head>
<body>

<div class="w3-container w3-lobster banda">
    <p class="w3-xxxlarge w3-center">Login a Gaucho Rocket<img src="img/cohete-espacial-mini.png" class="animated bounceInUp"></p>
</div>

<div class="w3-display-container">

    <form class="w3-container w3-card-4 w3-content login" method="POST" action="reservar_turno.php">

        <?php echo $error; ?>
        <select name="centro_medico" >Centro Medico:
        <?php
            while ($fila_centro_medico = mysqli_fetch_assoc($resultado_centro_medico)){
                echo "<option value='" . $fila_centro_medico['id'] . "'>" . $fila_centro_medico['nombre'] . "</option>";
            }
        ?></select>

        <label class="w3-xlarge w3-lobster">Fecha:</label>
        <input class="w3-input w3-margin-bottom w3-hover-gray" type="date" name="fecha" min="<?php echo($fecha_minimo); ?>">


        <button class="w3-button w3-round-xlarge w3-green derecha" type="submit" name="enviar">Reservar</button><br><br>

    </form>
</div>
<?php
include "pie.html";
?>