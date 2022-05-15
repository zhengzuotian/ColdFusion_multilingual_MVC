$( function() {
	// ajax for register form
	$('.ajax-register-form').ajaxForm({success: handleResponse});

	function handleResponse(responseText, statusText, xhr, $form) {
		displayMessage(responseText);
		var data = JSON.parse(responseText);

		// more action
		// ...
	}

	function displayMessage(response) {
		var data = JSON.parse(response);
		if (data.error) {
			$('#ajax-result').html('<div class="alert alert-danger" style="margin-bottom:0px;">'+data.message+'</div>').show().delay(6000).fadeOut(1000);
		} else {
			$('#ajax-result').html('<div class="alert alert-success" style="margin-bottom:0px;">'+data.message+'</div>').show().delay(3000).fadeOut(1000);
		}
	}

});