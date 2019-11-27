<?php
session_start();
require_once "conexion.php";
$ran=rand(1,10000);
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
if (isset($_POST['busca'])) {
    $busca = $_POST['busca']; /*Aca agarro lo del input*/
        if ($busca == ""){ /*SI $busca esta vacio que me tire este error. Sino que haga la query*/
            echo "<center><p class='w3-panel w3-red'>Ingrese un campo a buscar</center></p>";
            }else {
            $busqueda = "SELECT nombre, apellido,email FROM usuarios WHERE email  LIKE '$busca'";
            $resultado_busqueda = mysqli_query($conexion, $busqueda);
            $final_busqueda = mysqli_fetch_all($resultado_busqueda);
            $i = 0;
            $idf = $final_busqueda[$i][0]; /*ID DE LA FACTURA ES LO MISMO QUE EL ID DEL REGISTRO*/
            $nombre = $final_busqueda[$i][1]; /*NOMBRE DEL USUARIO*/
            $apellido = $final_busqueda[$i][2]; /*APELLIDO DEL USUARIO*/

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
                while ($i < count($final_busqueda)) {
                    echo "<tr>
        <td>" . $final_busqueda[$i][0] . "</td> <!-- Nombre -->
        <td>" . $final_busqueda[$i][1] . "</td> <!-- Apellido -->
        <td>" . $final_busqueda[$i][2] . "</td> <!-- Email -->
        <td><a href='factura.php?id=" . $ran . "&nombre=" . $final_busqueda[$i][0] . "&apellido=" . $final_busqueda[$i][1] . "'>Factura</a></td> <!-- ID -->
      </tr>";
                    $i++;
                }
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

