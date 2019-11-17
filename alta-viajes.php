<?php
require_once "conexion.php";
$fecha_actual = date("Y-m-d H:i:s");
$fecha_minimo = date("Y-m-d H:i:s",strtotime($fecha_actual."+ 1 days"));

if (isset($_POST['enviar'])) {
    $fecha_salida = $_POST['fecha_salida'];
    $codigo_vuelo = $_POST['codigo_vuelo'];

    for ($i=0;$i<3;$i++){
        $sql = "INSERT INTO viajes_t_final (fecha_hora, codigo_vuelo) VALUES ('$fecha_salida','$codigo_vuelo')";
        $resultado = mysqli_query($conexion, $sql);
        $fecha_salida = date("Y-m-d H:i", strtotime($fecha_salida."+ 5 hours"));
    }

}
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>Buscá tu vuelo</title>
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Lobster">
    <link rel="stylesheet" href="css/gr.css">
    <!-- Bootstrap -->
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" rel="stylesheet">

</head>
<body>
<form method="POST" action="alta-viajes.php" >
    <div class="selector">
        <label for='fecha_salida'>Fecha/Hora de salida:</label>
        <input name="fecha_salida"type="datetime-local" min="<?php echo $fecha_minimo?>">
    </div>
    <div class="selector">
        <label for='codigo_vuelo'>Código de vuelo:</label>
        <input name="codigo_vuelo"type="text">
    </div>
    <button id="submit" type="submit" name="enviar">Ingresar viaje</button>
</form>
</body>
<?php include "pie.html";?>
</html>
