<?php

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
        Repita su contraseña: <input type="password2" name="clave" placeholder="Confirmar contraseña"><br><br>
        <button type="button" onclick="login.submit()">Registrate</button>
    </form><br>
    <button type="submit" name="registro"><a href="login.php">Iniciar sesion</a></button>

</center>

</body>
</html>
