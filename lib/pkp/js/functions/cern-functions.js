/**
 * CERN FUNCTIONS
 * Copyright (C) 2015 CERN
 *
 * This files contains all the javascript functions added for the CERN's OJS platform
 */


/** 
 * This function is called after the page is load to do different tasks
 */
function afterPageLoad() {
	removeBreadcrumbInHomePage();
	defaultStyle();
	stickMenuToTopAfterScroll();
	addJustified();
	addHoverOverElements();
	changeNumbersInTableFooter();
	removeOnMobile();
}


/**
 * This function stick the menu to the top after scrolling
 */
function stickMenuToTopAfterScroll() {
	var menu = $('#navigation-bar');
	var origOffsetY = menu.offset().top;
	
	function scroll() {
	    if ($(window).scrollTop() >= origOffsetY) {
	        $('#navigation-bar').addClass('navbar-fixed-top');
	    } else {
	        $('#navigation-bar').removeClass('navbar-fixed-top');
	    }
	}
	
	document.onscroll = scroll;
}


/**
* This function removes the breadcrumb if you are in the E-Publishing home
*/
function removeBreadcrumbInHomePage() {
	var url = document.URL; 
	if(url.search(/\/index.php$/) > 0) { // https://e-publishing.ch/index.php
		document.getElementById("breadcrumb").innerHTML = "";
	} else if(url.search(/\/index.php/) < 0) { // https://e-publishing.ch/
		document.getElementById("breadcrumb").innerHTML = "";
	} else if(url.search(/\/index.php\/index$/) > 0) { // https://e-publishing.ch/index.php/index
		document.getElementById("breadcrumb").innerHTML = "";
	} else if(url.search(/\/index.php\/index\/index$/) > 0) { // https://e-publishing.ch/index.php/index/index
			document.getElementById("breadcrumb").innerHTML = "";
	}
}

/**
 * This function applys the default bootstrap style to the buttons, inputs and selects that do not have it
 */
function defaultStyle() {	
	//Get all input[text], select and textarea
	$(":input").not(":submit, button, :button, :file, :checkbox, :radio, .form-control").addClass("form-control")
	
	//Get all the input[submit]
	$(":submit").not('.btn').addClass("btn btn-default btn-sm");
	
	//Get all buttons that are not submit
	$("button").not('.btn').addClass("btn btn-default btn-sm");
	
	//Get all input[button]
	$(":button").not('.btn').addClass("btn btn-default btn-sm");
	
	//Get all input[file]
	$(":file").filestyle({buttonBefore: true, iconName: "file_upload"});
	//Change button of input[file] to have icon
	$(".file_upload").parent().parent().html("<span class='group-span-filestyle input-group-btn' tabindex='0' style='min-width:130px'><label for='filestyle-0' class='btn btn-info' style='display:block;border-radius: 4px'><span style='float:left'><span class='material-icons' style='margin-right:10px'><i class='md-icon'>file_upload</i></span></span> <span>Choose file</span></label></span>");
}

/**
* This funcion add the "btn-group-justified" class to elements that has the class "add-justified"
* if we are in a screen of 735px or bigger, and if we are in smaller screens it will remove the 
* btn-group from the element and children and add to the buttons the class btn-block to take up all the screen
*/
function addJustified() {
	//Add btn-group-justified to add-justified classes when the browser is bigger than 564px
	if($( document ).width() > 735) {
		$(".add-justified").removeClass("add-justified").addClass("btn-group-justified")
	} else { 
		//Remove btn-group class and add col-md-12 class to children to be more natural in mobile
		$(".add-justified").removeClass("add-justified btn-group").children().removeClass("btn-group").children().addClass("btn-block");
	}
}

/**
 * This function parse some elements to add them as a hover instead of the default text.
 * It search elements that has the class "hoverize-text" and basing on the innerHtml
 * it will keep the text that are before the first : and the text after will become the hover.
 * If it does not find : it will not do anything.
 */
function addHoverOverElements() {
	$(".hoverize-text").each(function() {
		var text = $(this).html();
		var positionOfPoints = text.search(":");
		if(positionOfPoints > 0) {
			var newText = text.slice(0,positionOfPoints); 
			var hover = text.slice(positionOfPoints+1,text.length);
			$(this).html(newText);
			$(this).attr("title", hover);
		}
	});
}

/**
 * This function with take the element with the class "footer-table-numbers" and will change
 * the style to the elements inside it to have bootstrap style
 */
function changeNumbersInTableFooter () {
	var ulElement = $('<ul/>').addClass("pagination").css("margin", "0px");
	$(".footer-table-numbers").children().each(function(){
		if($(this).is("a")) { //Enabled options
			$(ulElement).append(
					$('<li/>').append($(this))
			)
		} else { //Disabled option (actual)
			$(ulElement).append(
					$('<li/>').addClass("active").append(
							$('<a/>').append($(this))
					)
			)
		}
	});
	$(".footer-table-numbers").html(ulElement);
}

/**
 * This function removes the elements that have the class remove-on-mobile when
 * the size of the window is less than 975
 */

function removeOnMobile() {
	if($( document ).width() < 975) {
		$(".remove-on-mobile").remove();
	}
}







