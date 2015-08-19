{**
 * templates/editor/selectSectionEditor.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2003-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * List editors or section editors and give the ability to select one.
 *
 *}
{strip}
{assign var="pageTitle" value=$roleName|concat:"s"}
{include file="common/header.tpl"}
{/strip}

<h3>{translate key="editor.article.selectEditor" roleName=$roleName|translate}</h3>

<form id="submit" method="post" action="{url op="assignEditor" path=$rolePath articleId=$articleId}">
	<div class="col-md-2">
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
	<div class="col-md-6">
		<input type="text" name="search" class="textField" value="{$search|escape}" />
	</div>
	<div class="col-md-2">
		<input type="submit" value="{translate key="common.search"}" class="button" />
	</div>
</form>

<div class="row col-md-12 margin-minus-10-top-bottom"><hr></div>
<div class="col-md-12">
<p>{foreach from=$alphaList item=letter}<a class="btn btn-default btn-xs {if $letter == $searchInitial}active{/if}" href="{url op="assignEditor" path=$rolePath articleId=$articleId searchInitial=$letter}">{$letter|escape}</a> {/foreach}<a class="btn btn-default btn-xs {if $searchInitial==''}active{/if}" href="{url op="assignEditor" articleId=$articleId}">{translate key="common.all"}</a></p>
</div>

<div id="editors">
<table width="100%" class="table table-condensed">
<thead>
<tr valign="bottom">
	<td class="heading" width="10%">{translate key="common.assign"}</td>
	<td class="heading" width="30%">{translate key="user.name"}</td>
	<td class="heading" width="20%">{translate key="section.sections"}</td>
	<td class="heading" width="20%">{translate key="submissions.completed"}</td>
	<td class="heading" width="20%">{translate key="submissions.active"}</td>
</tr>
</thead>
<tbody>
{iterate from=editors item=editor}
{assign var=editorId value=$editor->getId()}
<tr valign="top">
	<td>
		<a class="btn btn-success btn-xs" href="{url op="assignEditor" articleId=$articleId editorId=$editorId}">
			<i class="material-icons icon-inside-button">trending_down</i>
			{translate key="common.assign"}
		</a>
	</td>
	<td><a class="action" href="{url op="userProfile" path=$editorId}">{$editor->getFullName()|escape}</a></td>
	<td>
		{assign var=thisEditorSections value=$editorSections[$editorId]}
		{foreach from=$thisEditorSections item=section}
			{$section->getLocalizedAbbrev()|escape}&nbsp;
		{foreachelse}
			&mdash;
		{/foreach}
	</td>
	<td>
		{if $editorStatistics[$editorId] && $editorStatistics[$editorId].complete}
			{$editorStatistics[$editorId].complete}
		{else}
			0
		{/if}
	</td>
	<td>
		{if $editorStatistics[$editorId] && $editorStatistics[$editorId].incomplete}
			{$editorStatistics[$editorId].incomplete}
		{else}
			0
		{/if}
	</td>
</tr>
{/iterate}
{if $editors->wasEmpty()}
<tr>
<td colspan="5" class="nodata">{translate key="manager.people.noneEnrolled"}</td>
</tr>
{else}
	<tr>
		<td colspan="2" align="left" class="number-results-table">{page_info iterator=$editors}</td>
		<td colspan="3" align="right" class="footer-table-numbers">{page_links anchor="editors" name="editors" iterator=$editors searchInitial=$searchInitial searchField=$searchField searchMatch=$searchMatch search=$search dateFromDay=$dateFromDay dateFromYear=$dateFromYear dateFromMonth=$dateFromMonth dateToDay=$dateToDay dateToYear=$dateToYear dateToMonth=$dateToMonth articleId=$articleId}</td>
	</tr>
{/if}
</tbody>
</table>
</div>
{include file="common/footer.tpl"}

