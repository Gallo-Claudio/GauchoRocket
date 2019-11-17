$(document).ready(function() {
    var origen;

    $('#reserva-lugares').on('change', '#acompaniantes',function (event) {
        event.preventDefault();
        origen = $('#acompaniantes').val();
        // console.log(origen);
        genera_formularios();
    })

    $('#reserva-lugares').on('keyup', '#acompaniantes', function (event) {
        event.preventDefault();
        origen = $('#acompaniantes').val();
        // console.log(origen);
        genera_formularios();
    })

    var genera_formularios = function () {
        console.log(origen);
        formulario = '';

        if(origen>1){
            formulario += '<p>Ingrese el nombre y correo de los acompañantes, para que puedan loguearse en el sistema y pedir turno para el chequeo médico</p>';
            for(i=1;i<origen;i++){
                formulario += `
                <div class="caja">
                <label class="acompaniante">Nombre: </label><input type="text" name="nombre[]"><br>
                <label class="acompaniante">Apellido: </label><input type="text" name="apellido[]"><br>
                <label class="acompaniante">E-mail: </label><input type="email" name="email[]">
                </div>`
            }
        }

        $('#area-formularios').html(formulario);

    }
});