{**
 * templates/sectionEditor/selectReviewer.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2003-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * List reviewers and give the ability to select a reviewer.
 *
 *}
{strip}
{assign var="pageTitle" value="user.role.reviewers"}
{include file="common/header.tpl"}
{/strip}

<script type="text/javascript">
{literal}
<!--
function sortSearch(heading, direction) {
	var submitForm = document.getElementById('submit');
	submitForm.sort.value = heading;
	submitForm.sortDirection.value = direction;
	submitForm.submit();
}
// -->
{/literal}
</script>

<script>
	var alternativeTitle = '<h2>{translate key="editor.article.selectReviewer"}</h2>';
</script>

<div id="selectReviewer">

<div class="col-md-12">
<p><a class="btn btn-default btn-xs" href="{url op="enrollSearch" path=$articleId}">{translate key="sectionEditor.review.enrollReviewer"}</a>
<a class="btn btn-default btn-xs" href="{url op="createReviewer" path=$articleId}">{translate key="sectionEditor.review.createReviewer"}</a>
{foreach from=$reviewerDatabaseLinks item="link"}{if !empty($link.title) && !empty($link.url)}<a class="btn btn-default btn-xs" href="{$link.url|escape}" target="_new" class="action">{$link.title|escape}</a>{/if}{/foreach}</p>
</div>

<div class="row col-md-12 margin-minus-10-top-bottom"><hr></div>

<form id="submit" method="post" action="{url op="selectReviewer" path=$articleId}">
	<input type="hidden" name="sort" value="name"/>
	<input type="hidden" name="sortDirection" value="ASC"/>
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
		<input type="text" size="10" name="search" class="textField" value="{$search|escape}" />
	</div>
	<div class="col-md-2">
		<input type="submit" value="{translate key="common.search"}" class="button" />
	</div>
</form>

<div class="row col-md-12 margin-minus-10-top-bottom"><hr></div>

<div class="col-md-12">
<p>{foreach from=$alphaList item=letter}<a class="btn btn-default btn-xs {if $letter == $searchInitial}active{/if}" href="{url op="selectReviewer" path=$articleId searchInitial=$letter}">{$letter|escape}</a> {/foreach}<a class="btn btn-default btn-xs {if $searchInitial==''}active{/if}" href="{url op="selectReviewer" path=$articleId}">{translate key="common.all"}</a></p>
</div>

<div id="reviewers">
<table class="table table-condensed">
<thead>
{assign var=numCols value=7}
{if $rateReviewerOnQuality}
	{assign var=numCols value=$numCols+1}
{/if}
<tr class="heading" valign="bottom">
	<td class="heading">{translate key="common.assign"}</td>
	<td >{sort_search key="user.name" sort="reviewerName"}</td>
	<td>{translate key="user.interests"}</td>
	{if $rateReviewerOnQuality}
		<td>{sort_search key="reviewer.averageQuality" sort="quality"}</td>
	{/if}
	<td>{sort_search key="reviewer.completedReviews" sort="done"}</td>
	<td>{sort_search key="editor.submissions.averageTime" sort="average"}</td>
	<td>{sort_search key="editor.submissions.lastAssigned" sort="latest"}</td>
	<td>{sort_search key="common.active" sort="active"}</td>
</tr>
</thead>
<tbody>
{iterate from=reviewers item=reviewer}
{assign var="userId" value=$reviewer->getId()}
{assign var="qualityCount" value=$averageQualityRatings[$userId].count}
{assign var="reviewerStats" value=$reviewerStatistics[$userId]}

<tr valign="top">
	<td>
		{if $reviewer->review_id}
			{if $reviewer->declined}
				<a class="btn btn-warning btn-xs" href="{url op="reassignReviewer" path=$articleId|to_array:$reviewer->getUserId()}">
					<i class="material-icons icon-inside-button">trending_down</i>
					{translate key="editor.reassign"}
				</a>
			{else}
				<span class="assigned-select-reviewer">{translate key="common.alreadyAssigned"}</span>
			{/if}
		{else}
		<a class="btn btn-success btn-xs" href="{url op="selectReviewer" path=$articleId|to_array:$reviewer->getId()}">
			<i class="material-icons icon-inside-button">trending_down</i>
			{translate key="common.assign"}
		</a>
		{/if}
	</td>
	<td><a class="action" href="{url op="userProfile" path=$userId}">{$reviewer->getFullName()|escape}</a></td>
	<td>{$reviewer->getInterestString()|escape}</td>
	{if $rateReviewerOnQuality}<td>
		{if $qualityCount}{$averageQualityRatings[$userId].average|string_format:"%.1f"}
		{else}{translate key="common.notApplicableShort"}{/if}
	</td>{/if}

	<td>
		{if $completedReviewCounts[$userId]}
			{$completedReviewCounts[$userId]}
		{else}
			0
		{/if}
	</td>

	<td>
		{if $reviewerStats.average_span}
			{math equation="round(theSpan)" theSpan=$reviewerStats.average_span}
		{else}
			&mdash;
		{/if}
	</td>
	<td>{if $reviewerStats.last_notified}{$reviewerStats.last_notified|date_format:$dateFormatShort}{else}&mdash;{/if}</td>
	<td>{$reviewerStats.incomplete|default:0}</td>
</tr>
{/iterate}
{if $reviewers->wasEmpty()}
<tr>
<td colspan="{$numCols|escape}" class="nodata">{translate key="manager.people.noneEnrolled"}</td>
</tr>
{else}
	<tr>
		<td colspan="2" align="left" class="number-results-table">{page_info iterator=$reviewers}</td>
		<td colspan="{$numCols-2}" align="right" class="footer-table-numbers">{page_links anchor="reviewers" name="reviewers" iterator=$reviewers searchInitial=$searchInitial searchField=$searchField searchMatch=$searchMatch search=$search dateFromDay=$dateFromDay dateFromYear=$dateFromYear dateFromMonth=$dateFromMonth dateToDay=$dateToDay dateToYear=$dateToYear dateToMonth=$dateToMonth sort=$sort sortDirection=$sortDirection}</td>
	</tr>
{/if}
</tbody>
</table>

<h4>{translate key="common.notes"}</h4>
<p>{translate key="editor.article.selectReviewerNotes"}</p>
</div>
</div>

{include file="common/footer.tpl"}

