{**
 * templates/copyeditor/completed.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2003-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Show copyeditor's submission archive.
 *
 *}
{if !$dateFrom}
{assign var="dateFrom" value="--"}
{/if}

{if !$dateTo}
{assign var="dateTo" value="--"}
{/if}

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

<div id="search" class="col-md-12 well">
<form method="post" id="submit" action="{url op="index" path=$pageToDisplay}">
	<div class="col-md-12">
		<div class="col-md-2">
			<select name="searchField" size="1" class="selectMenu">
				{html_options_translate options=$fieldOptions selected=$searchField}
			</select>
		<input type="hidden" name="sort" value="id"/>
		<input type="hidden" name="sortDirection" value="ASC"/>
		</div>
		<div class="col-md-1 remove-on-mobile" class="center"><i class="material-icons">forward</i></div>
		<div class="col-md-2">
			<select name="searchMatch" size="1" class="selectMenu">
				<option value="contains"{if $searchMatch == 'contains'} selected="selected"{/if}>{translate key="form.contains"}</option>
				<option value="is"{if $searchMatch == 'is'} selected="selected"{/if}>{translate key="form.is"}</option>
				<option value="startsWith"{if $searchMatch == 'startsWith'} selected="selected"{/if}>{translate key="form.startsWith"}</option>
			</select>
		</div>
		<div class="col-md-1 remove-on-mobile" class="center"><i class="material-icons">forward</i></div>
		<div class="col-md-6" >
			<input type="text" size="15" name="search" class="textField" value="{$search|escape}" />
		</div>
	</div>
	<div class="row col-md-12" class="margin-minus-10-top-bottom"><hr></div>
	<div class="col-md-12">
		<div class="col-md-3">
			<select name="dateSearchField" size="1" class="selectMenu">
				{html_options_translate options=$dateFieldOptions selected=$dateSearchField}
			</select>
		</div>
		<div class="col-md-2" class="padding-top-5 center">{translate key="common.between"}</div>
		<div class="col-md-3">
			<div class="change-input-date">
				{html_select_date prefix="dateFrom" time=$dateFrom all_extra="class=\"selectMenu\"" year_empty="" month_empty="" day_empty="" start_year="-5" end_year="+1"}
			</div>
			<input type="text" value="" class="display-none"/>
		</div>
		<div class="col-md-1" class="padding-top-5 center">{translate key="common.and"}</div>
		<div class="col-md-3">
			<div class="change-input-date">	
				{html_select_date prefix="dateTo" time=$dateTo all_extra="class=\"selectMenu\"" year_empty="" month_empty="" day_empty="" start_year="-5" end_year="+1"}
			</div>
			<input type="text" value="" class="display-none"/>
		</div>
		<input type="hidden" name="dateToHour" value="23" />
		<input type="hidden" name="dateToMinute" value="59" />
		<input type="hidden" name="dateToSecond" value="59" />
	</div>
	<div class="col-md-3 col-md-offset-5" >
		<input type="submit" value="{translate key="common.search"}" class="btn btn-success btn-lg btn-block margin-top-10" />
	</div>
</form>
</div>

<div id="submissions">
<table width="100%" class="table table-condensed table-hover">
<thead>
	<tr class="heading" valign="bottom">
		<td>{sort_search key="common.id" sort="id"}</td>
		<td><span class="disabled">{translate key="submission.date.mmdd"}</span><br />{sort_search key="common.assign" sort="assignDate"}</td>
		<td>{sort_search key="submissions.sec" sort="section"}</td>
		<td>{sort_search key="article.authors" sort="authors"}</td>
		<td>{sort_search key="article.title" sort="title"}</td>
		<td>{sort_search key="submission.complete" sort="dateCompleted"}</td>
		<td align="right">{sort_search key="common.status" sort="status"}</td>
	</tr>
</thead>
<tbody>
{iterate from=submissions item=submission}
	{assign var="articleId" value=$submission->getId()}
	{assign var="initialCopyeditSignoff" value=$submission->getSignoff('SIGNOFF_COPYEDITING_INITIAL')}
	{assign var="finalCopyeditSignoff" value=$submission->getSignoff('SIGNOFF_COPYEDITING_FINAL')}
	<tr onclick="window.location = '{url op="submission" path=$articleId}'" valign="top">
		<td>{$articleId|escape}</td>
		<td>{$initialCopyeditSignoff->getDateNotified()|date_format:$dateFormatTrunc}</td>
		<td>{$submission->getSectionAbbrev()|escape}</td>
		<td>{$submission->getAuthorString(true)|truncate:40:"..."|escape}</td>
		<td><a href="{url op="submission" path=$articleId}" class="action">{$submission->getLocalizedTitle()|strip_tags|truncate:60:"..."}</a></td>
		<td>{$finalCopyeditSignoff->getDateCompleted()|date_format:$dateFormatTrunc}</td>
		<td align="right">
			{assign var="status" value=$submission->getStatus()}
			{if $status == STATUS_ARCHIVED}
				{translate key="submissions.archived"}
			{elseif $status == STATUS_QUEUED}
				{translate key="submissions.queued"}
			{elseif $status == STATUS_PUBLISHED}
				{print_issue_id articleId="$articleId"}
			{elseif $status == STATUS_DECLINED}
				{translate key="submissions.declined"}
			{/if}
		</td>
	</tr>
{/iterate}
{if $submissions->wasEmpty()}
	<tr>
		<td colspan="7" class="nodata">{translate key="submissions.noSubmissions"}</td>
	</tr>
{else}
	<tr>
		<td colspan="5" align="left" class="number-results-table">{page_info iterator=$submissions}</td>
		<td colspan="3" align="right" class="footer-table-numbers">{page_links anchor="submissions" name="submissions" iterator=$submissions searchInitial=$searchInitial searchField=$searchField searchMatch=$searchMatch search=$search dateFromDay=$dateFromDay dateFromYear=$dateFromYear dateFromMonth=$dateFromMonth dateToDay=$dateToDay dateToYear=$dateToYear dateToMonth=$dateToMonth dateSearchField=$dateSearchField sort=$sort sortDirection=$sortDirection}</td>
	</tr>
{/if}
</tbody>
</table>
</div>

