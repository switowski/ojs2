/**
 * CERN FUNCTIONS
 * Copyright (c) 2015 Adrian Casimiro Alvarez
 * License: Free to use, modify, distribute as long as this header is kept 
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