<?php
$error="";
$conexion = mysqli_connect("127.0.0.1:3307","pw2","pw22019","gauchorocket");

if(!$conexion){
    echo "<p>ERROR de conexion a la BD</p>";
    die;
}

$sql_id_viajes = "SELECT id FROM viajes";
$resultado_id_viajes = mysqli_query($conexion,$sql);
$registro_id_viajes = mysqli_fetch_all($resultado_id_viajes);

$error = "";
if(isset($_POST['enviar'])){
    $cant = $_POST['cant'];

if($cant >0){
    for($i=0;$i<$cant;$i++){
        $sql = "INSERT INTO reservas (cantidad) VALUES ('$cant')";
        $consulta = mysqli_query($conexion,$sql);
    }
}
    else {
        $error = "<div class='w3-panel w3-red'><p>La reserva no se pudo realizar</div>";
        $clase ="animated shake";
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
    <?php include "header.php" ?>
</head>

<body>
<div class="w3-container w3-lobster banda">
    <p class="w3-xxxlarge w3-center">Reservas</p><img src="img/cohete-espacial-mini.png" class="animated bounceInUp">
</div>
</body>

<div class="w3-display-container">

    <form class="w3-container w3-card-4 w3-content" method="POST" action="reservas.php" >
        <center>Cantidad de pasajes a reservar: <input type="number" name="cant" min="0"></center><br><br>
        <center><button class="w3-button w3-round-xlarge w3-red" type="submit" name="enviar">Aceptar</button></center>
    </form>
</div>
</html>
<?php
include "pie.html";
?>
