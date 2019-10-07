<?php
    $error="";
    require 'conexion.php';

    if (isset($_POST['enviar'])) {
        $usuario = $_POST['usuario'];
        $clave = $_POST['clave'];

        if(empty($usuario) or empty($clave)){
            $error = "<div class='w3-panel w3-red'><p>Los datos ingresados son incorrectos</p></div>";
        }else {
            $sql = "SELECT * FROM usuarios WHERE usuario = '" . $usuario . "' AND clave = '" . $clave . "'";
            $consulta = mysqli_query($conexion, $sql);

            if (!$consulta) {
                $error = "<div class='w3-panel w3-red'><p>Los datos ingresados son incorrectos</p></div>";
            } else {
                $resultado = mysqli_fetch_assoc($consulta); /*Todos los datos que trae los guardo aca*/

                if ($resultado['clave'] == $clave) {
                    session_start();
                    $_SESSION['username'] = $usuario;
                    header("location:inicio.php");
                    exit();
                } else {
                    $error = "<div class='w3-panel w3-red'><p>Los datos ingresados son incorrectos</p></div>";
                }
            }
        }
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
    <link rel="stylesheet" href="css/gr.css">
</head>
<body>

<div class="w3-container w3-lobster banda">
    <p class="w3-xxxlarge w3-center">Login a Gaucho Rocket<img src="img/cohete-espacial-mini.png"></p>
</div>

<div class="w3-display-container">
        <form class="w3-container w3-card-4 w3-content login" method="POST" action="login.php">

            <?php echo $error; ?>
            <label class="w3-xlarge w3-lobster">Nombre:</label>
            <input class="w3-input w3-margin-bottom w3-hover-gray" type="text" name="usuario">

            <label class="w3-xlarge w3-lobster">Contraseña:</label>
            <input class="w3-input w3-margin-bottom w3-hover-gray" type="password" name="clave">

            <button class="w3-button w3-round-xlarge w3-green derecha" type="submit" name="enviar">Entrar</button><br><br>
            <button class="w3-button w3-round-xlarge w3-dark-grey derecha" type="submit" name="registro"><a href="registro.php">Registrarse</a></button>
        </form>
</div>
</body>
</html>
