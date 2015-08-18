{**
 * templates/sectionEditor/searchUsers.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2003-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Search form for enrolled users.
 *
 *
 *}
{strip}
{assign var="pageTitle" value="manager.people.enrollment"}
{include file="common/header.tpl"}
{/strip}

<form id="submit" method="post" action="{url op="enrollSearch" path=$articleId}">
	<div class="col-md-3">
		<select name="searchField" size="1" class="selectMenu">
			{html_options_translate options=$fieldOptions selected=$searchField}
		</select>
	</div>
	<div class="col-md-2">
		<select name="searchMatch" size="1" class="selectMenu">
			<option value="contains"{if $searchMatch == 'contains'} selected="selected"{/if}>{translate key="form.contains"}</option>
			<option value="is"{if $searchMatch == 'is'} selected="selected"{/if}>{translate key="form.is"}</option>
			<option value="startsWith"{if $searchMatch == 'startsWith'} selected="selected"{/if}>{translate key="form.startsWith"}</option>
		</select>
	</div>
	<div class="col-md-5">
		<input type="text" size="15" name="search" class="textField" value="{$search|escape}" />
	</div>
	<div class="col-md-2">
		<input type="submit" value="{translate key="common.search"}" class="button" />
	</div>
</form>

<div class="row col-md-12 margin-minus-10-top-bottom"><hr></div>

<div class="col-md-12">
<p>{foreach from=$alphaList item=letter}<a class="btn btn-default btn-xs {if $letter == $searchInitial}active{/if}" href="{url op="enrollSearch" path=$articleId searchInitial=$letter}">{$letter|escape}</a> {/foreach}<a class="btn btn-default btn-xs {if $searchInitial==''}active{/if}" href="{url op="enrollSearch" path=$articleId}">{translate key="common.all"}</a></p>
</div>

<div id="users">
<form action="{url op="enroll" path=$articleId}" method="post">
<table class="table table-condensed">
<thead>
<tr class="heading" valign="bottom">
	<td width="5%">&nbsp;</td>
	<td width="25%">{translate key="user.username"}</td>
	<td width="27%">{translate key="user.name"}</td>
	<td width="30%">{translate key="user.email"}</td>
	<td width="13%">{translate key="common.action"}</td>
</tr>
</thead>
<tbody>
{iterate from=users item=user}
{assign var="userid" value=$user->getId()}
{assign var="stats" value=$statistics[$userid]}
<tr valign="top">
	<td><input type="checkbox" name="users[]" value="{$user->getId()}" /></td>
	<td><a class="action" href="{url op="userProfile" path=$userid}">{$user->getUsername()|escape}</a></td>
	<td>{$user->getFullName(true)|escape}</td>
	<td>{$user->getEmail(true)|escape}</td>
	<td>
		<a class="btn btn-success btn-xs" href="{url op="enroll" path=$articleId userId=$user->getId()}">
			<i class="material-icons icon-inside-button">trending_down</i>
			{translate key="manager.people.enroll"}
		</a>
	</td>
</tr>
<tr>
{/iterate}
{if $users->wasEmpty()}
	<tr>
	<td colspan="5" class="nodata">{translate key="common.none"}</td>
	</tr>
{else}
	<tr>
		<td colspan="3" align="left" class="number-results-table">{page_info iterator=$users}</td>
		<td colspan="2" align="right" class="footer-table-numbers">{page_links anchor="users" name="users" iterator=$users searchInitial=$searchInitial searchField=$searchField searchMatch=$searchMatch search=$search dateFromDay=$dateFromDay dateFromYear=$dateFromYear dateFromMonth=$dateFromMonth dateToDay=$dateToDay dateToYear=$dateToYear dateToMonth=$dateToMonth}</td>
	</tr>
{/if}
</thead>
</table>
</div>
<div style="float:right">
	<input type="submit" value="{translate key="manager.people.enrollSelected"}" class="btn btn-success btn-sm" /> 
	<input type="button" value="{translate key="common.cancel"}" class="btn btn-danger btn-sm" onclick="document.location.href='{url page="manager" escape=false}'" />
</div>

</form>


{if $backLink}
<a href="{$backLink}">{translate key="$backLinkLabel"}</a>
{/if}

{include file="common/footer.tpl"}

