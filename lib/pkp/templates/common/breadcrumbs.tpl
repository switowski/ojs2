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
    <!-- If it's the home page, don't display "Home" link -->
    <a href="{url page="index"}">{translate key="navigation.home"}</a>
	{foreach from=$pageHierarchy item=hierarchyLink}
		   &gt; <a href="{$hierarchyLink[0]|escape}" class="hierarchyLink">{if not $hierarchyLink[2]}{translate key=$hierarchyLink[1]}{else}{$hierarchyLink[1]|escape}{/if}</a>
	{/foreach}
    {* Disable linking to the current page if the request is a post (form) request. Otherwise following the link will lead to a form submission error. *}
    {if ! preg_match("/index\.php(\/index)*$/", $currentUrl)}
         &gt; {if $requiresFormRequest}<span class="current">{else}<a href="{$currentUrl|escape}" class="current">{/if}{$pageCrumbTitleTranslated}{if $requiresFormRequest}</span>{else}</a>{/if}
    {/if}
</div>
