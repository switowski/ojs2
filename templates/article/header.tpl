{**
 * templates/article/header.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2003-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Article View -- Header component.
 *}
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="{$currentLocale|replace:"_":"-"}" xml:lang="{$currentLocale|replace:"_":"-"}">
<head>
	<style type="text/css">
      .js #flash {display: none;}
    </style>
	<title>{$article->getLocalizedTitle()|strip_tags|escape} | {$article->getFirstAuthor(true)|strip_tags|escape} | {$currentJournal->getLocalizedTitle()|strip_tags|escape}</title>
	<meta http-equiv="Content-Type" content="text/html; charset={$defaultCharset|escape}" />
	<meta name="description" content="{$article->getLocalizedTitle()|strip_tags|escape}" />
	{if $article->getLocalizedSubject()}
		<meta name="keywords" content="{$article->getLocalizedSubject()|escape}" />
	{/if}

	{if $displayFavicon}<link rel="icon" href="{$faviconDir}/{$displayFavicon.uploadName|escape:"url"}" type="{$displayFavicon.mimeType|escape}" />{/if}

	{include file="article/dublincore.tpl"}
	{include file="article/googlescholar.tpl"}
	{call_hook name="Templates::Article::Header::Metadata"}
	
	<!-- Base Jquery -->
	<script type="text/javascript" src="{$baseUrl}/lib/pkp/js/lib/jquery/jquery.min.js"></script>
	<!-- Hide Document until are the javascript style changes are aplied -->
	<script>
	
	</script>
	<script type="text/javascript" src="{$baseUrl}/lib/pkp/js/lib/jquery/plugins/jqueryUi.min.js"></script>
	
	<!-- Compatibility after the upgrade to version 1.11.3 of jQuery -->
	<script type="text/javascript" src="{$baseUrl}/lib/pkp/js/lib/jquery/jquery-migrate-1.2.1.min.js"></script>
	
	<!-- W3.CSS -->
	<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
	
	<!-- Jquery UI Style -->
	<link href="{$baseUrl}/lib/pkp/styles/lib/jqueryUi/jqueryUi.css" rel="stylesheet">
	<link href="{$baseUrl}/lib/pkp/styles/lib/jquery.pnotify.default.css" rel="stylesheet">
	
	<!-- Bootstrap style -->
	<link href="{$baseUrl}/styles/bootstrap/bootstrap.min.css" rel="stylesheet">
	<link href="{$baseUrl}/styles/bootstrap/bootstrap-theme.min.css" rel="stylesheet">
	
	<!-- Common style that overwrite the bootstrap to make the changes -->
	<link rel="stylesheet" href="{$baseUrl}/styles/common.css" type="text/css" />
	
	<!-- Roboto font for the title -->
	<link href='https://fonts.googleapis.com/css?family=Roboto:400,900' rel='stylesheet' type='text/css'>

	<!-- Compiled scripts -->
	{if $useMinifiedJavaScript}
		<script type="text/javascript" src="{$baseUrl}/js/pkp.min.js"></script>
	{else}
		{include file="common/minifiedScripts.tpl"}
	{/if}

	{$additionalHeadData}
	
	{* Bootstrap functions *}
	<script src="{$baseUrl}/js/bootstrap/bootstrap.min.js"></script>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	
	<script type="text/javascript">
      $('html').addClass('js');
      $(document).ready(afterPageLoad);  
    </script>
</head>
<body id="pkp-{$pageTitle|replace:'.':'-'}">

<div id="container">

<nav id="navigation-bar" class="navbar navbar-default navbar-fixed-top">
    <div class="col-md-12 col-xs-2">
		<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
			<span class="sr-only">Toggle navigation</span>
			<span class="icon-bar"></span>
			<span class="icon-bar"></span>
			<span class="icon-bar"></span>
		</button>
    </div>
    <div class="col-md-6 col-xs-10">
	    <div id="navbar" class="navbar-collapse collapse general-menu-nav" aria-expanded="false">
			<ul class="nav navbar-nav">
				<li><a href="{url journal="index"}"><span class="menu-option">{translate key="navigation.home"}</span></a></li>
				{if $currentJournal}
					<li class="dropdown">
						<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><span class="menu-option">{translate key="navigation.about"}</span></a>
						<ul class="dropdown-menu">
							<li><a href="{url page="about"}"><h5>About this publication</h5></a></li>
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
						<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><span class="menu-option">Journal content</span></a>
						<ul class="dropdown-menu">
							<li><a href="{url page="issue" op="current"}"><h5>{translate key="navigation.current"}</h5></a></li>
							<li><a href="{url page="issue" op="archive"}"><h5>{translate key="navigation.archives"}</h5></a></li>
							{foreach from=$navMenuItems item=navItem key=navItemKey}
								{if $navItem.url != '' && $navItem.name != ''}
									<li id="navItem-{$navItemKey|escape}"><a href="{if $navItem.isAbsolute}{$navItem.url|escape}{else}{$baseUrl}{$navItem.url|escape}{/if}"><h5>{if $navItem.isLiteral}{$navItem.name|escape}{else}{translate key=$navItem.name}{/if}</h5></a></li>
								{/if}
							{/foreach}
						</ul>
					</li>
				{/if}
			</ul>
	    </div>
    </div>
    
    <div class="col-md-3 col-xs-10">
	    <form method="post" id="searchForm" action="{url page="search"}">
			<div class="search-nav">
				<div class="input-group">
					<input id="simpleQuery" name="simpleQuery" type="text" class="form-control search-input" placeholder="{translate key="common.search"}">
					<input type="hidden" id="searchField" name="searchField" value="query">
					<span class="input-group-btn">
						<button type="submit" class="btn btn-default btn-sm"><i class="material-icons w3-xlarge">search</i></button>
					</span>
				</div>
			</div>
		</form>
	</div>
    
    <div class="col-md-3 col-xs-12">
	    {if $isUserLoggedIn}
			<div id="user-nav-on"  class="user-nav user-nav-on">
				<a href="#" class="dropdown-toggle user-option" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
					<div class="logged-div">
						<span class="hello-text">You are logged in as...</span>
						<span class="menu-option user-name"><strong>{$emailUser}</strong></span>
					</div>
				</a>
				<ul class="dropdown-menu dropdown-menu-right">
					<li><a href="{url page="user"}"><h5>{translate key="navigation.userHome"}</h5></a></li>
					{if $currentJournal}
						<li><a href="{url page="notification"}"><h5>{translate key="notification.notifications"}</h5><span class="badge notification-badge">{if $unreadNotifications}{$unreadNotifications}{else}0{/if}</span></a></li>
					{/if}
					<li><a href="{url page="login" op="signOut"}"><h5>{translate key="user.logOut"}</h5></a></li>
				</ul>
			</div>
		{else}
			<div id="user-nav-off" class="user-nav user-nav-off" aria-expanded="false">
				<a class="btn btn-default btn-xs" href="https://e-publishing.cern.ch/index.php/CYR/login/implicitAuthLogin"><span class="menu-option">{translate key="navigation.login"}</span></a>
			</div>
		{/if}
	</div>
    
</nav>
<a href="{url page="index"}" class="a-without-decoration">
	<div id="header">
		<div id="headerTitle" class="jumbotron">
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
</a>

<div id="body">

<div id="main">
{include file="common/navbar.tpl"}

<div id="breadcrumb">
	<ol class="breadcrumb">
	<li><a href="{url page="index"}" target="_parent">{if $siteTitle}{$siteTitle}{else}{$applicationName}{/if}</a></li>
	<li><a href="{url page="issue" op="archive"}">{translate key="navigation.archives"}</a></li>
	{if $issue}<li><a href="{url page="issue" op="view" path=$issue->getBestIssueId($currentJournal)}" target="_parent">{$issue->getIssueIdentification(false,true)|escape}</a></li>{/if}
	<li class="active">{$article->getFirstAuthor(true)|escape}</li>
	</ol>
</div>

<div id="content">
<div class="row">
<div class="col-md-8">

