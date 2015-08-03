{**
 * templates/editor/index.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2003-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Editor index.
 *
 *}
{strip}
{assign var="pageTitle" value="editor.home"}
{assign var="pageCrumbTitle" value="user.role.editor"}
{include file="common/header.tpl"}
{/strip}
<div id="articleSubmissions">
<h3 style="font-style: italic;">{translate key="article.submissions"}...</h3>

<div class="btn-group add-justified" role"group">
	<a class="btn-group" role="group" href="{url op="submissions" path="submissionsUnassigned"}"><button class="btn btn-primary btn-lg">{translate key="common.queue.short.submissionsUnassigned"}<span style="margin-left:10px" class="badge">{if $submissionsCount[0]}{$submissionsCount[0]}{else}0{/if}</span></button></a>
	<a class="btn-group" role="group" href="{url op="submissions" path="submissionsInReview"}"><button class="btn btn-primary btn-lg active">{translate key="common.queue.short.submissionsInReview"}<span style="margin-left:10px" class="badge">{if $submissionsCount[1]}{$submissionsCount[1]}{else}0{/if}</span></button></a>
	<a class="btn-group" role="group" href="{url op="submissions" path="submissionsInEditing"}"><button class="btn btn-primary btn-lg">{translate key="common.queue.short.submissionsInEditing"}<span style="margin-left:10px" class="badge">{if $submissionsCount[2]}{$submissionsCount[2]}{else}0{/if}</span></button></a>
	<a class="btn-group" role="group" href="{url op="submissions" path="submissionsArchives"}"><button class="btn btn-primary btn-lg">{translate key="common.queue.short.submissionsArchives"}</button></a>
	{call_hook name="Templates::Editor::Index::Submissions"}
</div>
</div>
<div class="separator">&nbsp;</div>

&nbsp;<br />

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
<div class="col-md-12">
<form method="post" id="submit" action="{url path="search"}">
	{if $section}<input type="hidden" name="section" value="{$section|escape:"quotes"}"/>{/if}
	<input type="hidden" name="sort" value="id"/>
	<input type="hidden" name="sortDirection" value="ASC"/>
	<div class="col-md-12">
		<span class="col-md-3">
			<select name="searchField" size="1">
				{html_options_translate options=$fieldOptions selected=$searchField}
			</select>
		</span>
		<span class="col-md-1 remove-on-mobile"><i class="material-icons">forward</i></span>
		<span class="col-md-3">
			<select name="searchMatch" size="1">
				<option value="contains"{if $searchMatch == 'contains'} selected="selected"{/if}>{translate key="form.contains"}</option>
				<option value="is"{if $searchMatch == 'is'} selected="selected"{/if}>{translate key="form.is"}</option>
				<option value="startsWith"{if $searchMatch == 'startsWith'} selected="selected"{/if}>{translate key="form.startsWith"}</option>
			</select>
		</span>
		<span class="col-md-1 remove-on-mobile"><i class="material-icons">forward</i></span>
		<span class="col-md-4" >
			<input type="text" size="15" name="search" value="{$search|escape}" />
		</span>
	</div>
	<div class="row col-md-12" style="margin-top: -10px;margin-bottom: -10px;"><hr></div>
	<div class="col-md-12">
		<span class="col-md-3">
			<select name="dateSearchField" size="1">
				{html_options_translate options=$dateFieldOptions selected=$dateSearchField}
			</select>
		</span>
		<span class="col-md-2">{translate key="common.between"}</span>
		<span class="col-md-3">
			{html_select_date prefix="dateFrom" time=$dateFrom all_extra="class=\"selectMenu\"" year_empty="" month_empty="" day_empty="" start_year="-5" end_year="+1"}
		</span>
		<span class="col-md-1">{translate key="common.and"}</span>
		<span class="col-md-3">
			{html_select_date prefix="dateTo" time=$dateTo all_extra="class=\"selectMenu\"" year_empty="" month_empty="" day_empty="" start_year="-5" end_year="+1"}
		</span>
		<input type="hidden" name="dateToHour" value="23" />
		<input type="hidden" name="dateToMinute" value="59" />
		<input type="hidden" name="dateToSecond" value="59" />
	</div>
	<div class="col-md-12" style="height:60px">
		<input type="submit" value="{translate key="common.search"}" class="btn btn-success btn-lg" style="float:right; margin-right:15%; margin-top:10px;" />
	</div>
</form>
</div>

{if $displayResults}
<div class="col-md-12">
	<button type="button" class="btn btn-default btn-xs" style="float:right; clear:right" data-toggle="modal" data-target="#modalInformation">
	  <i class="material-icons">info_outline</i>
	</button>
	<div class="modal fade bs-example-modal-lgv" role="dialog" aria-labelledby="gridSystemModalLabel" id="modalInformation">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h3 class="modal-title" id="gridSystemModalLabel">{translate key="common.notes"}</h3>
	      </div>
	      <div class="modal-body">
	        <div class="container-fluid">
	          <div class="row col-md-12">
	          	<h4>{translate key="article.submissions"} {translate key="common.queue.short.submissionsInReview"}</h4>
	            {translate key="editor.submissionReview.notes"}
	            <h4>{translate key="article.submissions"} {translate key="common.queue.short.submissionsInEditing"}</h4>
	            {translate key="editor.submissionEditing.notes"}
	          </div>
	        </div>
	      </div>
	    </div><!-- /.modal-content -->
	  </div><!-- /.modal-dialog -->
	</div><!-- /.modal -->
</div>

	<div id="submissions">

<table width="100%" class="table table-condensed table-hover">
	<thead>
	<tr class="heading" valign="bottom">
		<td>{sort_search key="common.id" sort="id"}</td>
		<td><span class="disabled">{translate key="submission.date.mmdd"}</span><br />{sort_search key="submissions.submit" sort="submitDate"}</td>
		<td>{sort_search key="submissions.sec" sort="section"}</td>
		<td>{sort_search key="article.authors" sort="authors"}</td>
		<td>{sort_search key="article.title" sort="title"}</td>
		<td align="right">{sort_search key="common.status" sort="status"}</td>
	</tr>
	</thead>
	<tbody>
	{iterate from=submissions item=submission}
	{assign var="highlightClass" value=$submission->getHighlightClass()}
	{assign var="fastTracked" value=$submission->getFastTracked()}
	<tr onclick="window.location = '{url op="submission" path=$submission->getId()}'" valign="top"{if $highlightClass || $fastTracked} class="{$highlightClass|escape} {if $fastTracked}fastTracked{/if}"{/if}>
		<td>{$submission->getId()}</td>
		<td>{$submission->getDateSubmitted()|date_format:$dateFormatTrunc}</td>
		<td>{$submission->getSectionAbbrev()|escape}</td>
		<td>{$submission->getAuthorString(true)|truncate:40:"..."|escape}</td>
		<td><a href="{url op="submission" path=$submission->getId()}" class="action">{$submission->getLocalizedTitle()|strip_tags|truncate:60:"..."}</a></td>
		<td class="hoverize-text" align="right">
			{assign var="status" value=$submission->getSubmissionStatus()}
			{if $status == STATUS_ARCHIVED}
				{translate key="submissions.archived"}
			{elseif $status == STATUS_PUBLISHED}
				{print_issue_id articleId=$submission->getId()}
			{elseif $status == STATUS_DECLINED}
				{translate key="submissions.declined"}&nbsp;&nbsp;<a href="{url op="deleteSubmission" path=$articleId}" onclick="return confirm('{translate|escape:"jsparam" key="editor.submissionArchive.confirmDelete"}')" class="action">{translate key="common.delete"}</a>
			{elseif $status==STATUS_QUEUED_UNASSIGNED}{translate key="submissions.queuedUnassigned"}
			{elseif $status==STATUS_QUEUED_EDITING}{translate key="submissions.queuedEditing"}
			{elseif $status==STATUS_QUEUED_REVIEW}{translate key="submissions.queuedReview"}
			{else}{* SUBMISSION_QUEUED -- between cracks? *}
				{translate key="submissions.queued"}
			{/if}
		</td>
	</tr>
{/iterate}
{if $submissions->wasEmpty()}
	<tr>
		<td colspan="6" class="nodata">{translate key="submissions.noSubmissions"}</td>
	</tr>
{else}
	<tr>
		<td colspan="4" align="left" style="font-weight: bold;">{page_info iterator=$submissions}</td>
		<td align="right" colspan="2" class="footer-table-numbers">{page_links anchor="submissions" name="submissions" iterator=$submissions searchField=$searchField searchMatch=$searchMatch search=$search dateFromDay=$dateFromDay dateFromYear=$dateFromYear dateFromMonth=$dateFromMonth dateToDay=$dateToDay dateToYear=$dateToYear dateToMonth=$dateToMonth dateSearchField=$dateSearchField section=$section sort=$sort sortDirection=$sortDirection}</td>
	</tr>
{/if}
</table>
</div>
{else}

<div class="row col-md-12" style="margin-top: -10px;margin-bottom: -10px;"><hr></div>

{/if}{* displayResults *}
<div id="issues">
<h3>{translate key="editor.navigation.issues"}</h3>

<div class="col-md-4 list-group equilibrium">
		<a class="list-group-item btn btn-info btn-sm" href="{url op="createIssue"}">{translate key="editor.navigation.createIssue"}</a>
		<a class="list-group-item btn btn-info btn-sm" href="{url op="futureIssues"}">{translate key="editor.navigation.futureIssues"}</a>
		<a class="list-group-item btn btn-info btn-sm" href="{url op="backIssues"}">{translate key="editor.navigation.issueArchive"}</a>
		{call_hook name="Templates::Editor::Index::Issues"}
</div>
<div class="col-md-4 list-group">
	<a class="list-group-item btn btn-info btn-sm" href="{url op="notifyUsers"}">{translate key="editor.notifyUsers"}</a>
</div>

<div class="col-md-12">
{call_hook name="Templates::Editor::Index::AdditionalItems"}
</div>

{include file="common/footer.tpl"}

