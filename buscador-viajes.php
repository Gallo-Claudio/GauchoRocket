<?php
    $conexion = mysqli_connect("127.0.0.1","pw2","pw22019","gauchorocket");
    if(!$conexion){
        echo "<p>ERROR de conexion a la BD</p>";
        die;
    }

    $sql_dias= "select * from dias";
    $resultado_dias = mysqli_query($conexion, $sql_dias);
    $registro_dias = mysqli_fetch_all($resultado_dias);

    $sql_horas= "select * from horas";
    $resultado_horas = mysqli_query($conexion, $sql_horas);
    $registro_horas = mysqli_fetch_all($resultado_horas);

    $sql_tipo_viajes= "select * from tipo_viajes";
    $resultado_tipo_viajes = mysqli_query($conexion, $sql_tipo_viajes);
    $registro_tipo_viajes = mysqli_fetch_all($resultado_tipo_viajes);










    if (isset($_POST['enviar'])) {
        $dias = $_POST['dias'];
        $horas = $_POST['horas'];
        $tipo_viajes = $_POST['tipo_viajes'];


            $sql = "select dias.dia, horas.hora, tipo_viajes.tipo_viaje, duracion from viajes as v
                left outer join dias
               on v.dia = dias.id 
                left outer join horas
               on v.hora = horas.id
                 left outer join tipo_viajes
               on v.tipo_viaje = tipo_viajes.id
                 where v.dia = '$dias' and v.hora='$horas' and v.tipo_viaje = '$tipo_viajes'";
            $resultado = mysqli_query($conexion, $sql);
            $lista = mysqli_fetch_all($resultado);

            if (empty($lista)) {
                $error = "<p class='error animated shake'>No se ha encontrado ningún viaje</p>";
            }
    }


?>

<form method="POST" action="buscador-viajes.php">
    <?php echo $error; ?>

    <div class="selector"><label for='dias'>Dias:</label>
        <select name='dias'>
            <?php
            $d=0;
            while($d < count($registro_dias)) {
                echo"<option value='".$registro_dias[$d][0]."'>".$registro_dias[$d][1]."</option>";
                $d++;
            }
            ?>
        </select></div>

    <div class="selector"><label for='horas'>Horas:</label>
        <select name='horas'>
            <?php
            $h=0;
            while($h < count($registro_horas)) {
                echo"<option value='".$registro_horas[$h][0]."'>".$registro_horas[$h][1]."</option>";
                $h++;
            }
            ?>
        </select></div>

    <div class="selector"><label for='tipo_viajes'>Tipo de viaje:</label>
        <select name='tipo_viajes'>
            <?php
            $tv=0;
            while($tv < count($registro_tipo_viajes)) {
                echo"<option value='".$registro_tipo_viajes[$tv][0]."'>".$registro_tipo_viajes[$tv][1]."</option>";
                $tv++;
            }
            ?>
        </select></div>


    <button type="submit" name="enviar">Buscar</button>
</form>


<?php

echo "<table>
                <thead>
                  <tr>
                    <td>Dia</td>
                    <td>Hora</td>
                    <td>Tipo de viaje</td>
                    <td>Duracion</td>
                  </tr>
                 </thead>
                 <tbody>";

$i=0;

while($i < count($lista)) {


    echo "<tr>
                    <td>".$lista[$i][0]."</td>
                    <td>".$lista[$i][1]."</td>
                    <td>".$lista[$i][2]."</td>
                    <td>".$lista[$i][3]."</td>
                   </tr>";
    $i++;
}
echo "</tbody></table>";
?>