/**
 * CERN FUNCTIONS
 * Copyright (c) 2015 Adrian Casimiro Alvarez
 * License: Free to use, modify, distribute as long as this header is kept 
 *
 * This files contains all the javascript functions added for the CERN's OJS platform
 */


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