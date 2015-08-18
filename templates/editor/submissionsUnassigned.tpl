{**
 * templates/editor/submissionsUnassigned.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2003-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Show listing of unassigned submissions.
 *}
<div id="submissions">
<table width="100%" class="table table-condensed table-hover">
<thead>
	<tr class="heading" valign="bottom">
		<td width="5%">{sort_search key="common.id" sort="id"}</td>
		<td width="5%"><span class="disabled">{translate key="submission.date.mmdd"}</span><br />{sort_search key="submissions.submit" sort="submitDate"}</td>
		<td width="5%">{sort_search key="submissions.sec" sort="section"}</td>
		<td width="30%">{sort_search key="article.authors" sort="authors"}</td>
		<td width="50%">{sort_search key="article.title" sort="title"}</td>
	</tr>
</thead>
<tbody>	
	{iterate from=submissions item=submission}
	<tr onclick="window.location = '{url op="submission" path=$submission->getId()}'" valign="top" {if $submission->getFastTracked()} class="fastTracked"{/if}>
		<td>{$submission->getId()}</td>
		<td>{$submission->getDateSubmitted()|date_format:$dateFormatTrunc}</td>
		<td>{$submission->getSectionAbbrev()|escape}</td>
		<td>{$submission->getAuthorString(true)|truncate:40:"..."|escape}</td>
		<td><a href="{url op="submission" path=$submission->getId()}">{$submission->getLocalizedTitle()|strip_tags|truncate:60:"..."}</a></td>
	</tr>
{/iterate}
{if $submissions->wasEmpty()}
	<tr>
		<td colspan="5" class="nodata">{translate key="submissions.noSubmissions"}</td>
	</tr>
{else}
	<tr>
		<td colspan="4" align="left" class="number-results-table">{page_info iterator=$submissions}</td>
		<td align="right" class="footer-table-numbers">{page_links anchor="submissions" name="submissions" iterator=$submissions searchField=$searchField searchMatch=$searchMatch search=$search dateFromDay=$dateFromDay dateFromYear=$dateFromYear dateFromMonth=$dateFromMonth dateToDay=$dateToDay dateToYear=$dateToYear dateToMonth=$dateToMonth dateSearchField=$dateSearchField section=$section sort=$sort sortDirection=$sortDirection}</td>
	</tr>
{/if}
</table>
</div>

