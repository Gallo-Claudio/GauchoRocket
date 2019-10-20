<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Busca tu vuelo</title>
    <meta charset="UTF-8">
    <title>Inicio</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Lobster">
    <link rel="stylesheet" href="css/gr.css">
    <?php include "header.php" ?>
</head>
<body>


<div class="w3-container w3-lobster banda">
    <p class="w3-xxxlarge w3-center">Busca tu vuelo ideal<img src="img/cohete-espacial-mini.png"></p>
    <a href='salir.php' class="w3-button w3-round-xlarge w3-red derecha">Salir</a>
</div>


<form action="vuelo.php" method="post">

    <center>Origen:  <select name="selectO">
            <option value="value1">Buenos Aires</option>
            <option value="value2" selected>Ankara</option>
        </select></center><br>



    <center>Destino:  <select name="selectD">
            <option value="value1">Estación Espacial Internacional</option>
            <option value="value2">OrbiterHotel</option>
            <option value="value3" selected>Luna </option>
            <option value="value4">Marte</option>
            <option value="value4">Ganimedes</option>
            <option value="value4">Europa</option>
            <option value="value4">Io</option>
            <option value="value4">Encedalo</option>
            <option value="value4">Titán</option>

        </select></center><br><br>

    <center> <label for="start">Fecha de salida</label>

        <input type="date" name="calendario"
               value="2018-07-22"
               min="2019-12-12" max="2021-01-01"<br>

        <label for="start">Fecha de llegada</label>

        <input type="date" name="calendario"
               value="2018-07-22"
               min="2019-12-12" max="2021-01-01"<br></center><br><br>



    <center>Tipo de vuelo:  <select name="tipoVuelo">
            <option value="value1">Suborbital</option>
            <option value="value2" selected>Orbital</option>
            <option value="value2" selected>Entre destino</option>
        </select></center><br>

    <center><button class="w3-button w3-round-xlarge w3-dark-grey" type="submit" name="aceptar">Aceptar</button><br><br></center>
</form>



</body>

<div class="w3-display-container">
</div>
<?php
include "pie.html";
?>