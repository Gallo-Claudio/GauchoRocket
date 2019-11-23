<?php
session_start();
require_once "conexion.php";
$usuario = $_SESSION['username'];
if(!isset($usuario)){
    header("location:login.php");
}
$id_usuario = $_SESSION['id'];
$hoy = date("Y-m-d");
$sql_turno = "SELECT fecha FROM turnos WHERE id_usuario = '$id_usuario'";
$resultado_turno = mysqli_query($conexion,$sql_turno);
$fila_turno = mysqli_fetch_assoc($resultado_turno);
if($fila_turno){
    if($fila_turno['fecha']<=$hoy){
        $codigo_generado = random_int(0,3);
        $sql_nivel_de_vuelo = "UPDATE usuarios SET nivel_vuelo = '$codigo_generado', se_chequeo = 1  WHERE id='$id_usuario'";
        $resultado_nivel_de_vuelo = mysqli_query($conexion,$sql_nivel_de_vuelo);
    }
}
?>

    <!DOCTYPE html>
    <html lang="es">
    <head>
        <meta charset="UTF-8">
        <title>Inicio</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="css/w3.css">
        <link rel="stylesheet" href="css/gr.css">
        <?php include "header.php" ?>
    </head>
<body>

<div class="w3-container banda">
    <p class="w3-xxxlarge w3-center w3-lobster">Bienvenido <?php echo $usuario; ?> a Gaucho Rocket<img src="img/cohete-espacial-mini.png"></p>
<div class="bienvenida">
    <p>Recuerde que:</p>
    <li>Si al realizar la reserva, el cupo de la cabina está lleno, su reserva entra en lista de esperá. La misma se activa 2Hs antes de la partida de la nave</li>
    <li>Una vez hecha la reserva, deberá sacar un turno en alguno de nuestros 3 centros médicos, para realizar un chequeo y saber si apto para realizar el viaje</li>
    <li>La reserva puede ser hecha de forma grupal, pero los turnos para el chequeo médico, se tramitan de forma individual</li>
    <li> De no llegar en el chequeo médico, al nivel requerido para realizar el vuelo, la reserva será dada de baja de forma automática</li>
    <li>Si la reserva es grupal, y un integrante no pasa el chequeo médico, cae toda la reserva grupal</li>
    <li>Aprobado el chequeo médico, debe realizar el pago. El mismo debe estar efectuado para poder realizar el Check-in</li>
    <li>El Check-in debe realizarse entre las 48Hs y 2Hs antes de la partida de la nave. De no realizarse, cae automaticamente la reserva y no hay devolución del pago</li>
</div>


</div>
<?php
include "pie.html";
?>