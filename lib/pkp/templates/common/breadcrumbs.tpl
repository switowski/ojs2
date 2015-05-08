{**
 * breadcrumbs.tpl
 *
 * Copyright (c) 2013-2014 Simon Fraser University Library
 * Copyright (c) 2000-2014 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Breadcrumbs
 *
 *}
<div id="breadcrumb">
    <!-- Always keep the "Home" element -->
    <a href="/">{translate key="navigation.home"}</a>
	{foreach from=$pageHierarchy item=hierarchyLink}
		 &gt; <a href="{$hierarchyLink[0]|escape}" class="hierarchyLink">{if not $hierarchyLink[2]}{translate key=$hierarchyLink[1]}{else}{$hierarchyLink[1]|escape}{/if}</a>
	{/foreach}
    {* DON'T DISPLAY THE CURRENT PAGE IF IT'S THE HOME PAGE*}
    {if ! preg_match("/ojs-css\/index.php(\/index)*$/", $currentUrl)}
        {* Disable linking to the current page if the request is a post (form) request. Otherwise following the link will lead to a form submission error. *}
        &gt; {if $requiresFormRequest}<span class="current">{else}<a href="{$currentUrl|escape}" class="current">{/if}{$pageCrumbTitleTranslated}{if $requiresFormRequest}</span>{else}</a>{/if}
   {/if}
</div>

