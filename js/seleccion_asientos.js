$(document).ready(function() {

  /* Cambia de color segun se haya seleccionado o no un asiento */
    $('input[type=checkbox]').on('change', function() {
        if ($(this).is(':checked') ) {
            var seleccionado = $(this).parent();
            $(seleccionado).removeClass('vacante');
            $(seleccionado).addClass('seleccionado');
        } else {
            var seleccionado = $(this).parent();
            $(seleccionado).removeClass('seleccionado');
            $(seleccionado).addClass('vacante');
        }
    });

  /*************************************************************************************************/
  /* Persisto en la Bd los asientos seleccionados */

    $('#ubicacion_asientos').submit(function(event) {
        event.preventDefault();
        form_data = $(this).serialize();
        console.log(form_data);
        $.ajax({
            url: 'reserva_asiento.php',
            type: 'POST',
            data: form_data,
            success:
                function(html){
                $("#mensaje").html(html);
            }
        })
    })




});
