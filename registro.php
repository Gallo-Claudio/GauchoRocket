<?php
$error="";
$nombre = "";
$apellido = "";
$email = "";
$usuario="";
$clase="";
require 'conexion.php';
if (isset($_POST['enviar'])) {
    $nombre = $_POST['nombre'];
    $apellido = $_POST['apellido'];
    $email = $_POST['email'];
    $usuario = $_POST['usuario'];
    $clave = md5($_POST['clave']);
    $clave2 = md5($_POST['clave2']);
    if(empty($usuario) or empty($clave)){
        $error = "<div class='w3-panel w3-red'><p>Nombre/Contraseña<br>NO pueden estar vacios</p></div>";
        $clase ="animated shake";
    }else{
        $sql= "SELECT * FROM credenciales as c INNER JOIN usuarios as u 
                ON c.id_usuario = u.id     
                WHERE c.usuario = '$usuario'";
        $resultado = mysqli_query($conexion,$sql);
        $lista = mysqli_fetch_all($resultado);
        if(!empty($lista)){
            $error = "<div class='w3-panel w3-red'><p>El nombre de usuario ya existe</p></div>";
            $clase ="animated shake";
        }else {
            $sql_email = "SELECT email FROM usuarios WHERE email = '$email'";
            $resultado_email = mysqli_query($conexion,$sql_email);
            $lista_email = mysqli_fetch_all($resultado_email);
            if(!empty($lista_email)){
                $error = "<div class='w3-panel w3-red'><p>ERROR<br>El Email ingresado ya existe</p></div>";
                $clase = "animated shake";
            }else {
                if ($clave == $clave2) {
                    $sql_usuario = "INSERT INTO usuarios (nombre, apellido,email) VALUES ('$nombre','$apellido','$email')";
                    $consulta_usuario = mysqli_query($conexion, $sql_usuario);
                    if (!$consulta_usuario) {
                        $error = "<div class='w3-panel w3-red'><p>ERROR<br>No se pudieron guardar los datos</p></div>";
                        $clase = "animated shake";
                    } else {
                        $sql_idUsuario = "SELECT id FROM usuarios WHERE email = '$email'";
                        $resultado_idUsuario = mysqli_query($conexion,$sql_idUsuario);
                        $filaIdUsuario = mysqli_fetch_assoc($resultado_idUsuario);
                        $idUsuario = $filaIdUsuario['id'];

                        $sql_credenciales = "INSERT INTO credenciales(usuario,rol,clave,id_usuario) VALUES ('$usuario',2,'$clave','$idUsuario')";
                        $resultado_credenciales = mysqli_query($conexion,$sql_credenciales);

                        $nombre = "";
                        $apellido = "";
                        $email = "";
                        $usuario="";
                        $error = "<div class='w3-panel w3-light-green'><p>Usuario ingresado!!</p></div>";
                }
                } else {
                    $error = "<div class='w3-panel w3-red'><p>La contraseña no coincide<br>Vuelva a tipearla</p></div>";
                    $clase = "animated shake";
                }
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
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/3.7.2/animate.min.css">
    <link rel="stylesheet" href="css/gr.css">
</head>
<body>

<body>
<div class="w3-container w3-lobster banda">
    <p class="w3-xxxlarge w3-center">Registro a Gaucho Rocket</p><img src="img/cohete-espacial-mini.png" class="animated bounceInUp">
</div>

<div class="w3-display-container">
    <form class="w3-container w3-card-4 w3-content login <?php echo $clase; ?>" method="POST" action="registro.php" >

        <?php echo $error; ?>
        <label class="w3-xlarge w3-lobster">Nombre:</label>
        <input class="w3-input w3-margin-bottom w3-hover-gray" type="text" name="nombre" value="<?php echo$nombre; ?>">

        <label class="w3-xlarge w3-lobster">Apellido:</label>
        <input class="w3-input w3-margin-bottom w3-hover-gray" type="text" name="apellido" value="<?php echo$apellido; ?>">

        <label class="w3-xlarge w3-lobster">Email:</label>
        <input class="w3-input w3-margin-bottom w3-hover-gray" type="email" name="email" value="<?php echo$email; ?>">

        <label class="w3-xlarge w3-lobster">Nombre de Usuario:</label>
        <input class="w3-input w3-margin-bottom w3-hover-gray" type="text" name="usuario" value="<?php echo$usuario; ?>">

        <label class="w3-xlarge w3-lobster">Contraseña:</label>
        <input class="w3-input w3-margin-bottom w3-hover-gray" type="password" name="clave">

        <label class="w3-xlarge w3-lobster">Repita su contraseña:</label>
        <input class="w3-input w3-margin-bottom w3-hover-gray" type="password" name="clave2">

        <button class="w3-button w3-round-xlarge w3-green derecha" type="submit" name="enviar">Registrarse</button><br><br>
        <button class="w3-button w3-round-xlarge w3-dark-grey derecha" name="iniciosesion"><a href="login.php">Iniciar sesion</button>
    </form>
</div>
<?php
include "pie.html";
?>
