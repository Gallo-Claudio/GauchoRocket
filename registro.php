<?php
session_start();
require 'conexion.php';

if (isset($_POST['enviar'])) {
    $usuario = $_POST['usuario'];
    $clave = $_POST['clave'];
    $clave2 = $_POST['clave2'];


$sql = "SELECT * FROM usuarios as user WHERE usuario = '$usuario' AND clave = '$clave' AND clave2 = '$clave2'";
$consulta = mysqli_query($conexion,$sql);
$array = mysqli_fetch_array($consulta);


}



?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Iniciar sesion</title>
</head>

<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Lobster">
<style>
    .w3-lobster {
        font-family: "Lobster", serif;
    }
</style>
<body>

<body>
    <div class="w3-container w3-lobster">
        <center> <p class="w3-xxxlarge">Bienvenido al registro</p></center>

<center>

    <form class="w3-container w3-card-4" method="POST" action="registro.php" >

        <label class="w3-xlarge"><b>Nombre:</b></label>
        <input class="w3-xlarge" type="text" name="usuario"><br><br>

        <label class="w3-xlarge"><b>Contraseña:</b></label>
        <input class="w3-xlarge" type="password" name="clave"><br><br>

        <label class="w3-xlarge"><b>Repita su contraseña:</b></label>
        <input class="w3-xlarge" type="password" name="clave2"><br><br>

        <button class="w3-button w3-black w3-round-xlarge" type="button" name="enviar"><a href="login.php">Registrarse</a></button><br><br>
        <button class="w3-button w3-black w3-round-xlarge" name="iniciosesion"><a href="login.php">Iniciar sesion</button>
    </form><br>


</center>
</div>
</body>
</html>
