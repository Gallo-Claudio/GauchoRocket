<?php
session_start();
require_once "conexion.php";
$error = "";
?>
<!-- Primero hago el HTML porque sino me imprime el cuadro de busqueda arriba,
esto hace que se imprima donde corresponda -->
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Buscador de usuarios</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="css/w3.css">
    <link rel="stylesheet" href="css/animate.min.css">
    <link rel="stylesheet" href="css/gr.css">
    <?php include "header.php" ?><br>
</head>
<form class="w3-container w3-card-4 w3-content" method="post" action="buscarUsuarios.php">
<center>
    <h3 class="w3-xxxlarge w3-center w3-lobster">Buscar usuario</h3>
        <input name="busca" type="text">
        <button class="w3-button w3-round-xlarge w3-blue" type="submit" name="Submit" value="buscar">Buscar</button><br><br>
</center>
</form><br>
</html>

<?php
$busca=$_POST['busca']; /*Aca agarro lo del boton buscar*/
    if($busca==""){ /*SI $busca esta vacio que me tire este error. Sino que haga la query*/
        echo "<center><p class='w3-panel w3-red'>Ingrese un campo a buscar</center></p>";
    }else {
        $busqueda = "SELECT * FROM usuarios WHERE nombre LIKE '%" . $busca . "%'";
        $resultado_busqueda = mysqli_query($conexion, $busqueda);
    ?>
<center>
<div class="w3-display-container">
    <div class="w3-container w3-card-4 w3-content">
        <table class="w3-table-all">
            <tr>
                <td width="157"><b>Nombre</b></td>
                <td width="221"><b>Apellido</b></td>
                <td width="176"><b>Email</b></td>
                <td width="73"><b>Ver factura</b></td>

            </tr>

    <?php
    while($final_busqueda=mysqli_fetch_array($resultado_busqueda)){
        echo '<tr>';
        echo '<td width="19">'.$final_busqueda['nombre'].'</td>';
        echo '<td width="61">'.$final_busqueda['apellido'].'</td>';
        echo '<td width="157">'.$final_busqueda['email'].'</td>';
        echo '<td><a href="factura.php">Factura</a></td>';
        echo '</tr>';
    }
    }
    ?>
        </table>
    </div>
</div>
</center>

<?php
include "pie.html";
?>