<?php
session_start();
require_once "conexion.php";
$id_Usuario = 1;
$usuario = $_SESSION['username'];
$date= date("Y-m-d");

$sql = "SELECT apellido FROM usuarios where id = $id_Usuario";
$resultado_apellido = mysqli_query($conexion,$sql);
$final = mysqli_fetch_assoc($resultado_apellido);
$apellido = $final['apellido'];

$sql_reservas = "select estaciones.nombre as Origen, r.estacion_destino,r.cod_reserva as CodigoReserva from reservas as r
                 inner join estaciones on
                 r.estacion_origen = estaciones.id
                 where pago = 1 and id_usuario = '$id_Usuario'";
$resultado_reservas = mysqli_query($conexion, $sql_reservas);
$final_reservas = mysqli_fetch_assoc($resultado_reservas);



if(!isset($usuario)){
    header("location:login.php");
}
if ($_POST["generar_factura"] == "true")
{

//Recibir detalles de factura
$id_factura = $_POST["id_factura"];
$fecha_factura = $_POST["fecha_factura"];

//Recibir los datos de la empresa
$nombre_tienda = $_POST["nombre_tienda"];
$direccion_tienda = $_POST["direccion_tienda"];
$poblacion_tienda = $_POST["poblacion_tienda"];
$provincia_tienda = $_POST["provincia_tienda"];
$codigo_postal_tienda = $_POST["codigo_postal_tienda"];
$telefono_tienda = $_POST["telefono_tienda"];
$fax_tienda = $_POST["fax_tienda"];
$identificacion_fiscal_tienda = $_POST["identificacion_fiscal_tienda"];

//Recibir los datos del cliente
$nombre_cliente = $_POST["nombre_cliente"];
$apellidos_cliente = $_POST["apellidos_cliente"];
$direccion_cliente = $_POST["direccion_cliente"];
$poblacion_cliente = $_POST["poblacion_cliente"];
$provincia_cliente = $_POST["provincia_cliente"];
$codigo_postal_cliente = $_POST["codigo_postal_cliente"];
$identificacion_fiscal_cliente = $_POST["identificacion_fiscal_cliente"];

//Recibir los datos de los productos
$iva = $_POST["iva"];
$gastos_de_envio = $_POST["gastos_de_envio"];
$unidades = $_POST["unidades"];
$productos = $_POST["productos"];
$precio_unidad = $_POST["precio_unidad"];

//variable que guarda el nombre del archivo PDF
$archivo="factura-$id_factura.pdf";

//Llamada al script fpdf
require_once "fpdf.php";


$archivo_de_salida=$archivo;

$pdf=new FPDF();  //crea el objeto
$pdf->AddPage();  //añadimos una página. Origen coordenadas, esquina superior izquierda, posición por defeto a 1 cm de los bordes.

// Encabezado de la factura
$pdf->SetFont('Arial','B',14);
$pdf->Cell(190, 10, "FACTURA", 0, 2, "C");
$pdf->SetFont('Arial','B',10);
$pdf->MultiCell(190,5, "Número de factura: $id_factura"."\n"."Fecha: $fecha_factura", 0, "C", false);
$pdf->Ln(2);

// Datos de la tienda
$pdf->SetFont('Arial','B',12);
$top_datos=45;
$pdf->SetXY(40, $top_datos);
$pdf->Cell(190, 10, "Datos de la tienda:", 0, 2, "J");
$pdf->SetFont('Arial','',9);
$pdf->MultiCell(190, //posición X
5, //posición Y
$nombre_tienda."\n".
"Dirección: ".$direccion_tienda."\n".
"Población: ".$poblacion_tienda."\n".
"Provincia: ".$provincia_tienda."\n".
"Código Postal: ".$codigo_postal_tienda."\n".
"Teléfono: ".$telefono_tienda."\n".
"Fax: ".$fax_tienda."\n".
"Indentificación Fiscal: ".$identificacion_fiscal_tienda,
 0, // bordes 0 = no | 1 = si
 "J", // texto justificado
 false);


// Datos del cliente
$pdf->SetFont('Arial','B',12);
$pdf->SetXY(125, $top_datos);
$pdf->Cell(190, 10, "Datos del cliente:", 0, 2, "J");
$pdf->SetFont('Arial','',9);
$pdf->MultiCell(
190, //posición X
5, //posicion Y
"Nombre: ".$nombre_cliente."\n".
"Apellidos: ".$apellidos_cliente."\n".
"Dirección: ".$direccion_cliente."\n".
"Población: ".$poblacion_cliente."\n".
"Provincia: ".$provincia_cliente."\n".
"Código Postal: ".$codigo_postal_cliente."\n".
"Identificación Fiscal: ".$identificacion_fiscal_cliente,
0, // bordes 0 = no | 1 = si
"J", // texto justificado
false);

//Salto de línea
$pdf->Ln(2);



// extracción de los datos de los productos a través de la función explode
$e_productos = explode(",", $productos);
$e_unidades = explode(",", $unidades);
$e_precio_unidad = explode(",", $precio_unidad);

//Creación de la tabla de los detalles de los productos productos
$top_productos = 110;
    $pdf->SetXY(45, $top_productos);
    $pdf->Cell(40, 5, 'UNIDADES', 0, 1, 'C');
    $pdf->SetXY(80, $top_productos);
    $pdf->Cell(40, 5, 'PRODUCTOS', 0, 1, 'C');
    $pdf->SetXY(115, $top_productos);
    $pdf->Cell(40, 5, 'PRECIO UNIDAD', 0, 1, 'C');

$precio_subtotal = 0; // variable para almacenar el subtotal
$y = 115; // variable para la posición top desde la cual se empezarán a agregar los datos
$x=0;
while($x <= count($e_productos) - 1)
{
$pdf->SetFont('Arial','',8);

   $pdf->SetXY(45, $y);
    $pdf->Cell(40, 5, $e_unidades[$x], 0, 1, 'C');
    $pdf->SetXY(80, $y);
    $pdf->Cell(40, 5, $e_productos[$x], 0, 1, 'C');
    $pdf->SetXY(115, $y);
    $pdf->Cell(40, 5, $e_precio_unidad[$x]." €", 0, 1, 'C');

//Cálculo del subtotal
$precio_subtotal += $e_precio_unidad[$x] * $e_unidades[$x];
$x++;

// aumento del top 5 cm
$y = $y + 5;
}

//Cálculo del Impuesto
$add_iva = $precio_subtotal * $iva / 100;

//Cálculo del precio total
$total_mas_iva = round($precio_subtotal + $add_iva + $gastos_de_envio, 2);

$pdf->Ln(2);
$pdf->SetFont('Arial','B',10);
$pdf->Cell(190, 5, "Gastos de envío: $gastos_de_envio €", 0, 1, "C");
$pdf->Cell(190, 5, "I.V.A: $iva %", 0, 1, "C");
$pdf->Cell(190, 5, "Subtotal: $precio_subtotal €", 0, 1, "C");
$pdf->Cell(190, 5, "TOTAL: ".$total_mas_iva." €", 0, 1, "C");


$pdf->Output($archivo_de_salida);//cierra el objeto pdf

//Creacion de las cabeceras que generarán el archivo pdf
header ("Content-Type: application/download");
header ("Content-Disposition: attachment; filename=$archivo");
header("Content-Length: " . filesize("$archivo"));
$fp = fopen($archivo, "r");
fpassthru($fp);
fclose($fp);

//Eliminación del archivo en el servidor
unlink($archivo);
}
?>


<!DOCTYPE HTML>
<html>
<head>
    <meta charset="UTF-8">
    <title>Factura</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="css/w3.css">
        <link rel="stylesheet" href="css/gr.css">
        <?php include "header.php" ?>
</head>
<body>
<center>
    <h3>Factura</h3>
<div class="w3-display-container">
    <form class="w3-container w3-card-4 w3-content" method="post" action="factura.php">
        <button type="submit">GENERAR FACTURA PDF</button>

        <h3>Los datos de la factura son los siguientes</h3>

        <table>
            <tr>
                <td>ID de factura:</td>
                <td><input type="text" name="id_factura" value="1" size="5"></td>
            </tr>
            <tr>
                <td>fecha emisión de factura:</td>
                <td><?php echo $date; ?></td>
            </tr>
            <tr>
                <td>Nombre de la empresa</td>
                <td>Gaucho Rocket</td>
            </tr>
            <tr>
                <td>Dirección de la empresa:</td>
                <td>Florencio Varela 1903</td>
            </tr>
            <tr>
                <td>Provincia de la empresa:</td>
                <td>Buenos Aires</td>
            </tr>
            <tr>
                <td>Código Postal:</td>
                <td>1754</td>
            </tr>
            <tr>
                <td>Teléfono:</td>
                <td>4480-8900</td>
            </tr>
            <tr>
                <td>Identificacion Fiscal de la tienda:</td>
                <td>11223344N</td>
            </tr>
            <tr>
                <td><hr></td>
                <td><hr></td>
            </tr>
            <tr>
                <td>Nombre del cliente:</td>
                <td><?php echo$usuario;?></td>
            </tr>
            <tr>
                <td>Apellidos del cliente:</td>
                <td><?php echo$apellido;?></td>
            </tr>
        </table><br>

        <table cellpadding="5" border="1">
            <tr><th>Origen</th>
                <th>Destino</th>
                <th>Codigo de reserva</th>
            </tr>
            <?php
            while ( $final_reservas = mysqli_fetch_assoc($resultado_reservas)){
                echo "<tr>
                          <td class='reservas'>".$final_reservas['Origen']."</td>
                          <td class='reservas'>".$final_reservas['estacion_destino']."</td>
                          <td class='reservas'>".$final_reservas['CodigoReserva']."</td>
                     </tr>";
            }
            ?>
        </table>

        <input type="hidden" name="unidades" value="<?php echo $unidades; ?>">
        <input type="hidden" name="productos" value="<?php echo $productos; ?>">
        <input type="hidden" name="precio_unidad" value="<?php echo $precio_unidad; ?>">
        <!-- Campo que hace la llamada al script que genera la factura -->
        <input type="hidden" name="generar_factura" value="true">
    </form>
</div>
    <br><br><br><br>
</center>
</body>
<?php
include "pie.html";
?>
</html>