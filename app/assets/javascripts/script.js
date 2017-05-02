$( document ).ready(function() {
	
    //jQuery Minicolors
	$.minicolors.defaults.theme = 'bootstrap';    
	$('.mini-colors').minicolors();
	
	//Tooltip
	$('[data-toggle="tooltip"]').tooltip();

	//Remove anchor tags, then re-add 
	$("#save").click(function(e){
		
					
			//Get CKEDITOR content
			var editor_content = CKEDITOR.instances.map_content.document.$;				
			
			//Remove a tags
			$('a', editor_content).contents().unwrap();
			
			//Add a tags
			$('li', editor_content ).wrap('<a href=\"#"></a>');
			
		
	});
	
});