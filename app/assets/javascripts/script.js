$( document ).ready(function() {
	
    //jQuery Minicolors
	$.minicolors.defaults.theme = 'bootstrap';    
	$('.mini-colors').minicolors();
	
	//Tooltip
	$('[data-toggle="tooltip"]').tooltip(); 
});