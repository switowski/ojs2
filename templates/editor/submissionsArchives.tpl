{**
 * templates/editor/submissionsArchives.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2003-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Show listing of submission archives.
 *
 *}
<div id="submissions">
<table width="100%" class="table table-condensed table-hover">
<thead>
	<tr class="heading" valign="bottom">
		<td width="5%">{sort_search key="common.id" sort="id"}</td>
		<td width="15%">{sort_search key="submissions.submitted" sort="submitDate"}</td>
		<td width="5%">{sort_search key="submissions.sec" sort="section"}</td>
		<td width="25%">{sort_search key="article.authors" sort="authors"}</td>
		<td width="30%">{sort_search key="article.title" sort="title"}</td>
		<td width="20%" align="right">{sort_search key="common.status" sort="status"}</td>
	</tr>
</thead>
<tbody>	
	{iterate from=submissions item=submission}
	{assign var="articleId" value=$submission->getId()}

	<tr onclick="window.location = '{url op="submissionEditing" path=$articleId}'" valign="top" {if $submission->getFastTracked()} class="fastTracked"{/if}>
		<td>{$articleId|escape}</td>
		<td>{$submission->getDateSubmitted()|date_format:$dateFormatShort}</td>
		<td>{$submission->getSectionAbbrev()|escape}</td>
		<td>{$submission->getAuthorString(true)|truncate:40:"..."|escape}</td>
		<td><a href="{url op="submissionEditing" path=$articleId}">{$submission->getLocalizedTitle()|strip_tags|truncate:60:"..."}</a></td>
		<td align="right">
			{assign var="status" value=$submission->getStatus()}
			{if $status == STATUS_ARCHIVED}
				<span class="text-before-button-in-table">{translate key="submissions.archived"}</span><a class="btn btn-danger btn-xs" onclick="return cernConfirm('{translate|escape:"jsparam" key="editor.submissionArchive.confirmDelete"}','window.location.href = \'{url op="deleteSubmission" path=$articleId}\'', true, event)">{translate key="common.delete"}</a>
			{elseif $status == STATUS_PUBLISHED}
				<span class="hoverize-text">{print_issue_id articleId="$articleId"}</span>
			{elseif $status == STATUS_DECLINED}
				<span class="text-before-button-in-table">{translate key="submissions.declined"}</span><a class="btn btn-danger btn-xs" onclick="return cernConfirm('{translate|escape:"jsparam" key="editor.submissionArchive.confirmDelete"}','window.location.href = \'{url op="deleteSubmission" path=$articleId}\'', true, event)">{translate key="common.delete"}</a>
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
		<td colspan="4" align="left" class="number-results-table">{page_info iterator=$submissions}</td>
		<td colspan="2" align="right" class="footer-table-numbers">{page_links anchor="submissions" name="submissions" iterator=$submissions searchField=$searchField searchMatch=$searchMatch search=$search dateFromDay=$dateFromDay dateFromYear=$dateFromYear dateFromMonth=$dateFromMonth dateToDay=$dateToDay dateToYear=$dateToYear dateToMonth=$dateToMonth dateSearchField=$dateSearchField section=$section sort=$sort sortDirection=$sortDirection}</td>
	</tr>
{/if}
</tbody>
</table>
</div>

