<?php
session_start();
$id_usuario = $_SESSION['id'];
$error="";
require 'conexion.php';

$sql_centro_medico = "SELECT * FROM centros_medicos";
$resultado_centro_medico = mysqli_query($conexion,$sql_centro_medico);

$hoy = date("Y-m-d");
$fecha_minimo = date("Y-m-d",strtotime($hoy."+ 1 days"));
$nuevo_turno = false;

$sql_se_chequeo = "SELECT se_chequeo FROM usuarios WHERE id = '$id_usuario'";
$resultado_se_chequeo = mysqli_query($conexion,$sql_se_chequeo);
$fila_se_chequeo = mysqli_fetch_assoc($resultado_se_chequeo);

$se_chequeo = $fila_se_chequeo['se_chequeo'];
if($se_chequeo == false) {
    if (isset($_POST['enviar'])) {
        $centro_medico = $_POST['centro_medico'];
        $fecha = $_POST['fecha'];

        $sql_verificar_turno_pendiente = "SELECT (id_usuario) COUNT FROM turnos WHERE id_usuario = '$id_usuario';";
        $resultado_verificar_turno_pendiente = mysqli_query($conexion, $sql_verificar_turno_pendiente);
        $fila_verificar_turno_pendiente = mysqli_fetch_array($resultado_verificar_turno_pendiente);

        if (!$fila_verificar_turno_pendiente) {
            if ($fecha >= $fecha_minimo) {
                $sql_cantidad = "SELECT turnos_diarios FROM centros_medicos WHERE id = '$centro_medico'";
                $resultado_cantidad = mysqli_query($conexion, $sql_cantidad);
                $fila_cantidad = mysqli_fetch_assoc($resultado_cantidad);
                $cantidad_turnos = $fila_cantidad['turnos_diarios'];

                $sql_turnos = "SELECT COUNT (t.id) as cantidad FROM turnos as t inner join centros_medicos as cm on t.centro_medico = cm.id WHERE cm.id = '$centro_medico'";
                $resultado_turnos = mysqli_query($conexion, $sql_turnos);

                if (mysqli_affected_rows($conexion) > 0) {
                    $fila_turnos = mysqli_fetch_assoc($resultado_turnos);
                    $cantidad_turnos -= $fila_turnos['cantidad'];
                }

                if ($cantidad_turnos > 0) {
                    $sql_nuevo_turno = "INSERT INTO turnos (fecha,id_usuario,centro_medico) values('$fecha','$id_usuario','$centro_medico')";
                    $resultado_nuevo_turno = mysqli_query($conexion, $sql_nuevo_turno);
                    $nuevo_turno = true;
                } else {
                    $error = "<div class='w3-panel w3-red'><p>No hay mas turnos disponibles para esta fecha</p></div>";
                }
            } else {
                $error = "<div class='w3-panel w3-red'><p>La fecha ingresada es incorrecta</p></div>";
            }
        } else {
            $error = "<div class='w3-panel w3-red'><p>Ya tiene un turno pendiente</p></div>";
        }
    }

}else {
    echo "<link rel=\"stylesheet\" href=\"css/w3.css\">
        <link rel=\"stylesheet\" href=\"https://fonts.googleapis.com/css?family=Lobster\">
        <link rel=\"stylesheet\" href=\"https://cdnjs.cloudflare.com/ajax/libs/animate.css/3.7.2/animate.min.css\">
        <link rel=\"stylesheet\" href=\"css/gr.css\">";
    include "header.php";

    echo "El usuario ya realizo el chequeo medico.";
    include "pie.html";
    die;
}
?>
    <!DOCTYPE html>
    <html lang="es">
    <head>
        <meta charset="UTF-8">
        <title>Turno medico</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="css/w3.css">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Lobster">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/3.7.2/animate.min.css">
        <link rel="stylesheet" href="css/gr.css">
    </head>
<body>
<?php include "header.php" ?>
<div class="w3-container banda">
    <p class="w3-xxlarge w3-center">Reservas de turno médico</p>
</div>

<div class="w3-display-container">

    <form class="w3-container w3-card-4 w3-content login" autocomplete="off" method="POST" action="reservar_turno.php">

        <?php echo $error; ?>
       <center>
           <label class="w3-xlarge"> Centro Medico:</label><br>
              <select name="centro_medico" >
                <?php
                while ($fila_centro_medico = mysqli_fetch_assoc($resultado_centro_medico)){
                    echo "<option value='" . $fila_centro_medico['id'] . "'>" . $fila_centro_medico['nombre'] . "</option>";
                }
                ?>
              </select><br><br>

           <center>
               <label class="w3-xlarge">Fecha:</label><br>
               <input  type="text" name="fecha" id="fecha" placeholder="yy-mm-dd">
           </center><br><br>


           <button class="w3-button w3-round-xlarge w3-green" type="submit" name="enviar">Reservar</button><br><br>

       </center>
</div>


<link rel="stylesheet" href="//code.jquery.com/ui/1.11.2/themes/smoothness/jquery-ui.css">
<script src="//code.jquery.com/jquery-1.10.2.js"></script>
<script src="//code.jquery.com/ui/1.11.2/jquery-ui.js"></script>
<link rel="stylesheet" href="/resources/demos/style.css">

<script>
    $(function() {
        $('#fecha').datepicker({
            dateFormat: 'yy-mm-dd',
            maxDate: '+ 3m',
            minDate: '-0d',
            beforeShowDay: $ .datepicker.noWeekends
        });
    });
</script>
</body>

<?php
include "pie.html";
?>