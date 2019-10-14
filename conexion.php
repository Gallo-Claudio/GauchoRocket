<?php
    $conexion = mysqli_connect("127.0.0.1","root","46598842","gauchorocket");
    if(!$conexion){
        echo "<div class='w3-panel w3-red'><p>ERROR de conexión a la BD</p></div>";
    }
?>