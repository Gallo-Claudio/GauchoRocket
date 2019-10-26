<?php
session_start();
$usuario = $_SESSION['username'];
if(!isset($usuario)){
    header("location:login.php");
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