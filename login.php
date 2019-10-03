<?php
session_start();
require 'conexion.php';

if (isset($_POST['enviar'])) {
    $usuario = $_POST['usuario'];
    $clave = $_POST['clave'];

    $sql = "SELECT COUNT(*) as contar FROM usuarios WHERE usuario = '$usuario' AND clave = '$clave'";
    $consulta = mysqli_query($conexion, $sql);
    $array = mysqli_fetch_assoc($consulta); /*Todos los datos que trae los guardo aca*/

    if(empty($_POST['usuario'] == $usuario && $_POST['clave'] == $clave)){
        $_SESSION['username'] = $usuario;
        header("location:inicio.php");
        exit();
    }else{
        echo "error al iniciar sesion";
    }

}

?>

<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Iniciar sesion</title>
</head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<body>
<div class="w3-container">
<div class="w3-container w3-teal">
    <center><h1 class="w3-center w3-animate-bottom">Bienvenidos a Gaucho Rocket</h1></center>
</div></div>
    <center>
        <form class="w3-container w3-card-4" method="POST" action="login.php" >
            <label class="w3-text-blue"><b>Nombre:</b></label>
            <input class="w3-input w3-border" type="text" name="usuario"><br><br>

            <label class="w3-text-blue"><b>Contraseña</b></label>
            <input class="w3-input w3-border" type="password" name="clave"><br><br>
           <button class="w3-button w3-black w3-round-xlarge" type="submit" name="enviar">Entrar</button><br><br>
            <button class="w3-button w3-black w3-round-xlarge" type="submit" name="registro"><a href="registro.php">Registrarse</a></button>
        </form><br>

    </center>

</body>
</html>
