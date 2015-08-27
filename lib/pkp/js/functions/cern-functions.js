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
	addHoverOverElements();
	changeNumbersInTableFooter();
	removeOnMobile();
	changeInputDate();
	showErrorsOnPage();
	addFunctionClickErrorLink();
	submissionCheckbox();
	checkShowHideFilters();
	$('body').show();
	footerToBottom(); //This function has to be after showing the body
}


/**
* This function removes the breadcrumb if you are in the E-Publishing home
*/
function removeBreadcrumbInHomePage() {
	var url = document.URL; 
	if(url.search(/\/index.php$/) > 0) { // https://e-publishing.ch/index.php
		$("#breadcrumb").hide();
		$("#breadcrumb").next().hide(); //Title
	} else if(url.search(/\/index.php/) < 0) { // https://e-publishing.ch/
		$("#breadcrumb").hide();
		$("#breadcrumb").next().hide(); //Title
	} else if(url.search(/\/index.php\/index$/) > 0) { // https://e-publishing.ch/index.php/index
		$("#breadcrumb").hide();
		$("#breadcrumb").next().hide(); //Title
	} else if(url.search(/\/index.php\/index\/index$/) > 0) { // https://e-publishing.ch/index.php/index/index
		$("#breadcrumb").hide();
		$("#breadcrumb").next().hide(); //Title
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
			$(this).parent().html('<i class="material-icons icon" title="Email">email</i>');
		} else {
			var newButton = document.createElement('button');
			$(newButton).addClass("btn btn-default btn-xs disabled").html('<i class="material-icons icon" title="Email">email</i>');
			$(this).parent().html(newButton);
		}
	});
	
	//Change all input[file]
	$(":file").each(function() {
		var button = $(this).next().removeClass("btn-sm");
		var disabled = $(this).is(":disabled");
		
		$(this).filestyle({buttonBefore: true});
		var buttonChooseFile = $(this).parent().find(".bootstrap-filestyle").find(".btn-default");
		buttonChooseFile.removeClass("btn-default").addClass("btn-primary");
		
		if(disabled) {
			buttonChooseFile.attr('disabled','disabled');
		}
		
		if($(button).is(":submit")) { //It has an upload button
			$(this).parent().find(":text").addClass("input-file-text");
			$(button).clone().appendTo($(this).parent().find(".bootstrap-filestyle"));
			$(button).hide();
		}
	});
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
	var ulElement = $('<ul/>').addClass("pagination numbers-footer");
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


/**
 * This function search the elements that has the class error placed by ojs, and add to the
 * input in the next element the class has-error from bootstrap 
 */
function showErrorsOnPage() {
	$(".error").each(function() {
			$(this).parent().next().addClass("has-error");
	});
}

/**
 * This function will add a function that will be launched
 * after the user clicked in the link to the error to scroll
 * a bit to the top
 */
function addFunctionClickErrorLink() {
	var scrollTopDistance = 60;
	$(".pkp_form_error_list a").each(function() {
		var errorLinkClicked = function() {
			if($($(this).attr("href")).css("display")=="none") {
				$('html, body').animate({
			        scrollTop: $($(this).attr("href")).parent().offset().top
			    }, 0);
			}
			
			setTimeout(function(){
			    //Wait half a second until scroll
				$('html, body').animate({
			        scrollTop: $(window).scrollTop() - scrollTopDistance});
			}, 100);
		};
		
		$(this).on('click',errorLinkClicked);
	});
	
}

/**
 * This function hide all the checkbox and show the checklist-all if this exists
 */
function submissionCheckbox() {
	var checkbox = document.getElementById("checklist-all");
	if(typeof checkbox != 'undefined') {
		var parent = $(checkbox).parent();
		$(parent).show();
		$(parent).addClass("col-xs-1");
		$(parent).next().addClass("col-xs-11 check-box-all");
		var label = $('<label/>').attr('for','checklist-all');
		$(label).css("font-weight","bold");
		$(label).html($(parent).next().html());
		$(parent).next().html("");
		$(label).appendTo(parent.next());
		$(checkbox).prop('checked', true);
		$(".checkbox-remove").each(function() {
			if(!$(this).prop("checked")) {
				$(checkbox).prop('checked', false);
			}
			$(this).hide();
			$(this).parent().addClass("row col-md-1").removeClass("col-xs-1");
		});
	}
}

/**
 * This function check all the checklist if the user check the checkbox checklist-all,
 * and uncheck if the user uncheck it.
 */
function selectChecklist(checkboxAll) {
	if(checkboxAll.checked) { 
		$(".checkbox-remove").each(function() {
			$(this).prop('checked', true);
		});
	} else {
		$(".checkbox-remove").each(function() {
			$(this).prop('checked', false);
		});
	}
}

/**
 * This function test if the page need to show the filters if the user is in the search page 
 */
function checkShowHideFilters() {
	if(typeof showFilters != 'undefined') {
		if(showFilters==false) {
			//By default they are visible, so hide filters
			$("#filtersAdvanceSearch").hide();
		}
	}
}

/**
 * This functions make visibles the filters or hide them
 */
function toogleFilters() {
	$("#filtersAdvanceSearch").toggle("slow", function() {
		footerToBottom(); //Test if the footer need to be place or removed in the bottom part of the page
	});
	$("#icon-advance-search").html($("#icon-advance-search").html()== "expand_more"? "expand_less": "expand_more");
	
}

/**
 * This function add the footerBottom class if the footer is not below the page.
 */
function footerToBottom() {
	if($('.footer').length != 0 && $('.footer').position().top+$('.footer').outerHeight(true) < $(window).height()) {
		$(".footer").addClass("footerBottom");
	} else {
		$(".footer").removeClass("footerBottom");
	}
}





