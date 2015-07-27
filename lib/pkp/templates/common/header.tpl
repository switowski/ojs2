{**
 * header.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2000-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Common site header.
 *}
{strip}
{if !$pageTitleTranslated}{translate|assign:"pageTitleTranslated" key=$pageTitle}{/if}
{if $pageCrumbTitle}
	{translate|assign:"pageCrumbTitleTranslated" key=$pageCrumbTitle}
{elseif !$pageCrumbTitleTranslated}
	{assign var="pageCrumbTitleTranslated" value=$pageTitleTranslated}
{/if}
{/strip}
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="{$currentLocale|replace:"_":"-"}" xml:lang="{$currentLocale|replace:"_":"-"}">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset={$defaultCharset|escape}" />
	<title>{$pageTitleTranslated}</title>
	<meta name="description" content="{$metaSearchDescription|escape}" />
	<meta name="keywords" content="{$metaSearchKeywords|escape}" />
	<meta name="generator" content="{$applicationName} {$currentVersionString|escape}" />
	{$metaCustomHeaders}
	{if $displayFavicon}<link rel="icon" href="{$faviconDir}/{$displayFavicon.uploadName|escape:"url"}" type="{$displayFavicon.mimeType|escape}" />{/if}
	
	<!-- W3.CSS -->
	<link rel="stylesheet" href="http://www.w3schools.com/w3css/w3.css">
	<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
	
	<!-- Bootstrap style -->
	<link href="{$baseUrl}/styles/bootstrap/bootstrap.min.css" rel="stylesheet">
	
	<!-- Common style that overwrite the bootstrap to make the changes -->
	<link rel="stylesheet" href="{$baseUrl}/styles/common.css" type="text/css" />

	<!-- Base Jquery -->
	<script type="text/javascript" src="{$baseUrl}/lib/pkp/js/lib/jquery/jquery.min.js"></script>
	<script type="text/javascript" src="{$baseUrl}/lib/pkp/js/lib/jquery/plugins/jqueryUi.min.js"></script>
	
	<!-- Compatibility after the upgrade to version 1.11.3 of jQuery -->
	<script type="text/javascript" src="{$baseUrl}/lib/pkp/js/lib/jquery/jquery-migrate-1.2.1.js"></script>

	<!-- Default global locale keys for JavaScript -->
	{include file="common/jsLocaleKeys.tpl" }

	<!-- Compiled scripts -->
	{if $useMinifiedJavaScript}
		<script type="text/javascript" src="{$baseUrl}/js/pkp.min.js"></script>
	{else}
		{include file="common/minifiedScripts.tpl"}
	{/if}

	<!-- Form validation -->
	<script type="text/javascript" src="{$baseUrl}/lib/pkp/js/lib/jquery/plugins/validate/jquery.validate.js"></script>
	<script type="text/javascript">
		<!--
		// initialise plugins
		{literal}
		$(function(){
			jqueryValidatorI18n("{/literal}{$baseUrl}{literal}", "{/literal}{$currentLocale}{literal}"); // include the appropriate validation localization
			{/literal}{if $validateId}{literal}
				$("form[name={/literal}{$validateId}{literal}]").validate({
					errorClass: "error",
					highlight: function(element, errorClass) {
						$(element).parent().parent().addClass(errorClass);
					},
					unhighlight: function(element, errorClass) {
						$(element).parent().parent().removeClass(errorClass);
					}
				});
			{/literal}{/if}{literal}
			$(".tagit").live('click', function() {
				$(this).find('input').focus();
			});
		});
		// -->
		{/literal}
	</script>

	{if $hasSystemNotifications}
		{url|assign:fetchNotificationUrl page='notification' op='fetchNotification' escape=false}
		<script type="text/javascript">
			$(function(){ldelim}
				$.get('{$fetchNotificationUrl}', null,
					function(data){ldelim}
						var notifications = data.content;
						var i, l;
						if (notifications && notifications.general) {ldelim}
							$.each(notifications.general, function(notificationLevel, notificationList) {ldelim}
								$.each(notificationList, function(notificationId, notification) {ldelim}
									$.pnotify(notification);
								{rdelim});
							{rdelim});
						{rdelim}
				{rdelim}, 'json');
			{rdelim});
		</script>
	{/if}{* hasSystemNotifications *}

	{$additionalHeadData}
	
	{* Bootstrap functions *}
	<script src="{$baseUrl}/js/bootstrap/bootstrap.min.js"></script>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	
</head>
<body id="pkp-{$pageTitle|replace:'.':'-'}">
<div id="container">
	<nav class="navbar navbar-default navbar-fixed-top">
        <div class="col-md-1">
			<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
				<span class="sr-only">Toggle navigation</span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
        </div>
        <div id="navbar" class="navbar-collapse collapse col-md-4" aria-expanded="false" style="margin-top:8px">
			<ul class="nav navbar-nav">
				<li><a href="{url page="index"}"><span class="menu-option">{translate key="navigation.home"}</span></a></li>
				{if $currentJournal}
					<li class="dropdown">
						<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><span class="menu-option">{translate key="navigation.about"}</span></a>
						<ul class="dropdown-menu">
							<li><a href="{url page="about"}"><h5>About this page</h5></a></li>
							<li role="separator" class="divider"></li>
							<li><a href="{url page="pages"}/view/for_editors"><h5>Information for editors</h5></a></li>              
							<li><a href="{url page="pages"}/view/for_authors"><h5>Information for authors</h5></a></li>
							<li><a href="{url page="pages"}/view/for_readers"><h5>Information for readers</h5></a></li>
							<li><a href="{url page="pages"}/view/for_librarians"><h5>Information for librarians</h5></a></li>
						</ul>
					</li>
				{else}
					<li><a href="{url page="about"}"><span class="menu-option">{translate key="navigation.about"}</span></a></li>
				{/if}
				{if $currentJournal}
					<li class="dropdown">
						<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><span class="menu-option">Content</span></a>
						<ul class="dropdown-menu">
							<li><a href="{url page="issue" op="current"}"><h5>{translate key="navigation.current"}</h5></a></li>
							<li><a href="{url page="issue" op="archive"}"><h5>{translate key="navigation.archives"}</h5></a></li>
							<li><a href="{url page="forth_titles"}"><h5>Forthcoming titles</h5></a></li>
						</ul>
					</li>
					<li> <a href="{url page="about"}/contact"><span class="menu-option">Contact</span></a></li>
				{/if}
			</ul>
        </div>
		<div class="search-nav">
			<form method="post" id="searchForm" action="{url page="search"}">
				<input id="simpleQuery" name="simpleQuery" type="text" class="form-control" placeholder="{translate key="common.search"}">
				<input type="hidden" id="searchField" name="searchField" value="query">
				<button type="submit" class="btn btn-default btn-sm"><i class="material-icons w3-xlarge">search</i></button>
			</form>
		</div>
    </nav>
<div id="header">
<div id="headerTitle">
<h1>
{if $displayPageHeaderLogo && is_array($displayPageHeaderLogo)}
	<img src="{$publicFilesDir}/{$displayPageHeaderLogo.uploadName|escape:"url"}" width="{$displayPageHeaderLogo.width|escape}" height="{$displayPageHeaderLogo.height|escape}" {if $displayPageHeaderLogoAltText != ''}alt="{$displayPageHeaderLogoAltText|escape}"{else}alt="{translate key="common.pageHeaderLogo.altText"}"{/if} />
{/if}
{if $displayPageHeaderTitle && is_array($displayPageHeaderTitle)}
	<img src="{$publicFilesDir}/{$displayPageHeaderTitle.uploadName|escape:"url"}" width="{$displayPageHeaderTitle.width|escape}" height="{$displayPageHeaderTitle.height|escape}" {if $displayPageHeaderTitleAltText != ''}alt="{$displayPageHeaderTitleAltText|escape}"{else}alt="{translate key="common.pageHeader.altText"}"{/if} />
{elseif $displayPageHeaderTitle}
	{$displayPageHeaderTitle}
{elseif $alternatePageHeader}
	{$alternatePageHeader}
{elseif $siteTitle}
	{$siteTitle}
{else}
	{$applicationName}
{/if}
</h1>
</div>
</div>

<div id="body">

{if $leftSidebarCode || $rightSidebarCode}
	<div id="sidebar">
		{if $leftSidebarCode}
			<div id="leftSidebar">
				{$leftSidebarCode}
			</div>
		{/if}
		{if $rightSidebarCode}
			<div id="rightSidebar">
				{$rightSidebarCode}
			</div>
		{/if}
	</div>
{/if}

<div id="main">
{include file="common/navbar.tpl"}

{include file="common/breadcrumbs.tpl"}

<h2>{$pageTitleTranslated}</h2>

{if $pageSubtitle && !$pageSubtitleTranslated}{translate|assign:"pageSubtitleTranslated" key=$pageSubtitle}{/if}
{if $pageSubtitleTranslated}
	<h3>{$pageSubtitleTranslated}</h3>
{/if}

<div id="content">

