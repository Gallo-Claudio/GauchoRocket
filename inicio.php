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

if($fila_turno['fecha']<=$hoy){
    $codigo_generado = random_int(0,3);
    $sql_nivel_de_vuelo = "UPDATE usuarios SET nivel_vuelo = '$codigo_generado', se_chequeo = 1  WHERE id='$id_usuario'";
    $resultado_nivel_de_vuelo = mysqli_query($conexion,$sql_nivel_de_vuelo);
}

?>

    <!DOCTYPE html>
    <html lang="es">
    <head>
        <meta charset="UTF-8">
        <title>Inicio</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Lobster">
        <link rel="stylesheet" href="css/gr.css">
        <?php include "header.php" ?>
    </head>
<body>

<div class="w3-container w3-lobster banda">
    <p class="w3-xxxlarge w3-center">Bienvenido <?php echo $usuario; ?> a Gaucho Rocket<img src="img/cohete-espacial-mini.png"></p>
    <a href='salir.php' class="w3-button w3-round-xlarge w3-red derecha">Salir</a>
</div>


<?php
include "pie.html";
?>