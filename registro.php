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

if ($array['user'] > 0) {
    $_SESSION['username'] = $usuario;
    header("location:registro.php");
} else {
    echo "Datos incorrectos";
}
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
<body>

<center>
    <form method="POST" action="registro.php" >
        Nombre: <input type="text" name="usuario" placeholder="Usuario"><br><br>
        Contraseña: <input type="password" name="clave" placeholder="Contraseña"><br><br>
        Repita su contraseña: <input type="password" name="clave2" placeholder="Confirmar contraseña"><br><br>
        <button type="button" onclick="login.submit()" name="enviar">Registrate</button>
    </form><br>
    <button type="submit" name="registro"><a href="login.php">Iniciar sesion</a></button>

</center>

</body>
</html>
