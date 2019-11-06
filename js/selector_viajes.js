$(document).ready(function() {
	var form_data;

	var ejecutajax = function(){
		$.ajax({
			url: 'buscar-f.php',
			type: 'POST',
			data: form_data,
			success: function (response) {
				//	console.log(response);

				let resultados = JSON.parse(response);
				let listado = '';

				resultados.forEach(resultado => {
					listado += `<tr><td>
								${resultado.codigo_vuelo}												
								</td>
								<td>
								${resultado.fecha}												
								</td>
								<td>
								${resultado.hora}												
								</td>
								<td>
								${resultado.origen}												
								</td>
								<td>
								${resultado.destino}												
								</td>
								<td>
								${resultado.duracion}												
								</td>
								<td>
								${resultado.nave}												
								</td>
								<td>
								<button class='w3-button w3-round-xlarge w3-green reserva' type='submit'><a href='reservas.php?${resultado.id}'>Reservar</button>											
								</td></tr>`
				})
				$('#resultados').html(listado);
			}

		})
	}



	$('#orbital').submit(function(event) {
		event.preventDefault();
		form_data = $(this).serialize();
		console.log(form_data);
		ejecutajax();
	})



	$('#tours').submit(function(event) {
		event.preventDefault();
		form_data = $(this).serialize();
			console.log(form_data);
		ejecutajax();
	})



	$('#destinos').submit(function(event) {
		event.preventDefault();
		form_data = $(this).serialize();
			console.log(form_data);
		ejecutajax();
	})



    $('#origen').on('change', function(event) {
        event.preventDefault();
		let origen = $('#origen').val();
		console.log(origen);

		$.ajax({
			url: 'estacion_circuito.php',
			type: 'POST',
			data: {origen},
			success: function (response) {
				//	console.log(response);

				let resultados = JSON.parse(response);
				let listado = '';

				resultados.forEach(resultado => {
					listado += `<option value='${resultado.id}'>${resultado.nombre}</option>`
				})
				$('#estaciones').html(listado);
	}

		})
    })

});