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
        <form method="POST" action="login.php" >
           Nombre: <input type="text" name="usuario"><br><br>
           Contraseña: <input type="password" name="clave"><br><br>
           <button type="submit" name="enviar">Entrar</button>
        </form><br>
        <button type="submit" name="registro"><a href="registro.php">Registrarse</a></button>
    </center>

</body>
</html>
