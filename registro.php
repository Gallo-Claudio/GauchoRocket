<?php
    $error="";
    $usuario="";
    require 'conexion.php';

    if (isset($_POST['enviar'])) {
        $usuario = $_POST['usuario'];
        $clave = $_POST['clave'];
        $clave2 = $_POST['clave2'];

        if(empty($usuario) or empty($clave)){
            $error = "<div class='w3-panel w3-red'><p>Nombre/Contraseña<br>NO pueden estar vacios</p></div>";
        }else{

            $sql= "SELECT * FROM usuarios WHERE usuario = '$usuario'";
            $resultado = mysqli_query($conexion,$sql);
            $lista = mysqli_fetch_all($resultado);

            if(!empty($lista)){
                $error = "<div class='w3-panel w3-red'><p>El nombre de usuario ya existe</p></div>";
            }else {

                if ($clave == $clave2) {
                    $sql = "INSERT INTO usuarios (usuario, clave, rol) VALUES ('$usuario','$clave','2')";
                    $consulta = mysqli_query($conexion, $sql);

                    if (!$consulta) {
                        $error = "<div class='w3-panel w3-red'><p>ERROR<br>No se pudieron guardar los datos</p></div>";
                    } else {
                        $usuario = "";
                        $error = "<div class='w3-panel w3-light-green'><p>Usuario ingresado!!</p></div>";
                    }

                } else {
                    $error = "<div class='w3-panel w3-red'><p>La contraseña no coincide<br>Vuelva a tipearla</p></div>";
                }
            }
        }
    }
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Registro</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Lobster">
    <link rel="stylesheet" href="css/gr.css">
</head>
<body>

<body>
<div class="w3-container w3-lobster banda">
    <p class="w3-xxxlarge w3-center">Registro a Gaucho Rocket</p><img src="img/cohete-espacial-mini.png"></div>

<div class="w3-display-container">
        <form class="w3-container w3-card-4 w3-content login" method="POST" action="registro.php" >

            <?php echo $error; ?>
            <label class="w3-xlarge w3-lobster">Nombre:</label>
            <input class="w3-input w3-margin-bottom w3-hover-gray" type="text" name="usuario" value="<?php echo$usuario; ?>">

            <label class="w3-xlarge w3-lobster">Contraseña:</label>
            <input class="w3-input w3-margin-bottom w3-hover-gray" type="password" name="clave">

            <label class="w3-xlarge w3-lobster">Repita su contraseña:</label>
            <input class="w3-input w3-margin-bottom w3-hover-gray" type="password" name="clave2">

            <button class="w3-button w3-round-xlarge w3-green derecha" type="submit" name="enviar">Registrarse</button><br><br>
            <button class="w3-button w3-round-xlarge w3-dark-grey derecha" name="iniciosesion"><a href="login.php">Iniciar sesion</button>
        </form>
</div>
</body>
</html>
