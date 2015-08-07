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
	$('body').hide();
	removeBreadcrumbInHomePage();
	changeTitle();
	defaultStyle();
	//stickMenuToTopAfterScroll();
	//addJustified();
	addHoverOverElements();
	changeNumbersInTableFooter();
	removeOnMobile();
	changeInputDate();
	$('body').show();
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
	
	//Change icon email
	$('img[alt="Mail"]').each(function() {
		if($(this).parent().is("a")) {
			$(this).parent().addClass("btn btn-default btn-xs");
		} else {
			$(this).parent().addClass("btn btn-default btn-xs disabled");
		}
		$(this).parent().css('margin-left','25px');
		
		$(this).parent().html('<i class="material-icons" style="font-size: 18px;" title="Email">email</i>');
	});
	//Change all input[file]
	//Apply style bootstrap
	$(":file").filestyle({buttonBefore: true, iconName: "file_upload"});
	//Remove actual upload button
	$(".file_upload").parent().parent().parent().next().remove();
	//Change style
	$(".file_upload").parent().parent().parent().html(
			"<span class='group-span-filestyle input-group-btn' tabindex='0' style='min-width:130px'>"+
				"<label for='filestyle-0' class='btn btn-default' style='display:block;border-radius: 4px'>"+
					"<span style='float:left'>"+
						"<span class='material-icons' style='margin-right:10px'>"+
							"<i class='md-icon'>file_upload</i>"+
					"</span></span><span>Choose file</span>"+
				"</label></span> <input style='width:70%' type='text' class='form-control ' disabled=''>"+
				"<input style='margin-left: 5px' type='submit' name='submit' value='Upload' class='btn btn-primary'>");
	
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

/**
 * This function change the three inputs from OJS for including the date to one input type date
 */
function changeInputDate() {
	$(".change-input-date").each(function() {
		$(this).css("display", "none");
		var selectMonth = $(this).children()[0];
		var selectDay = $(this).children()[1];
		var selectYear = $(this).children()[2];
		
		var month = selectMonth.value;
		//Month in javascript starts in 0
		if(month != "") month = parseInt(month) - 1; 
		var day = selectDay.value;
		if(day.length == 1) day="0"+day;
		var year = selectYear.value;
		
		var datepicker = $(this).parent().children().last();
		datepicker.css("display", "block");
		datepicker.datepicker({ dateFormat: 'dd-mm-yy' });
		datepicker.datepicker();
		if(year != "")
			datepicker.datepicker("setDate", new Date(year, month, day));
		datepicker.change(function(){
			afterDatePickerChange(datepicker, selectDay, selectMonth, selectYear)
		});
	});
}

/**
 * This function change the selects of day, month and year when its datepicker
 * change to a correct value, and remove them if the datepicker change to a wrong value
 * @param datepicker
 * @param selectDay
 * @param selectMonth
 * @param selectYear
 */
function afterDatePickerChange(datepicker, selectDay, selectMonth, selectYear) {
	var date = $(datepicker).val(); //dd-mm-yyyy
	if(date != undefined) {
		var dateArray = date.split("-");
		selectDay.selectedIndex = parseInt(dateArray[0]);
		selectMonth.selectedIndex = parseInt(dateArray[1]);
		var founded = false
		var position = 0;
		$(selectYear.options).each(function() {
			if(!founded) {
				if($(this).val() == dateArray[2]) {
					selectYear.selectedIndex = position;
				} else {
					position++;
				}
			}
		});
		if(!founded) {
			//If it was none of the years in the select, we select the first option
			if(position > selectYear.options.length) {
				selectYear.selectedIndex = 1;
			} 
		}
	} else { //Default, all empty
		selectDay.selectedIndex = 0;
		selectMonth.selectedIndex = 0;
		selectYear.selectedIndex = 0;
	}
}

/**
 * If the var alternativeTitle is instanciated it will overwrite the title of the page
 */
function changeTitle() {
	if(typeof alternativeTitle != "undefined")
		$("h2").first().html(alternativeTitle);
}

/**
 * This function launch an action if the user confirm the message
 * @param messageToConfirm This is the message that the user needs to confirm
 * @param actionAfterConfirm This is the action that is going to be performed if confirmed
 * @param stopPropagationEvent If this parameter is true, we stop the event that caused this function 
 */
function cernConfirm(messageToConfirm, actionAfterConfirm, stopPropagationEvent, event) {
	if(stopPropagationEvent) {
		if (event.stopPropagation){
			event.stopPropagation();
		}
	    else if(window.event){
	    	window.event.cancelBubble=true;
	    }
	}
	if(confirm(messageToConfirm)) {
		eval(actionAfterConfirm);
	}
}







