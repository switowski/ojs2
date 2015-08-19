{**
 * templates/reviewer/active.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2003-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Show reviewer's active submissions.
 *
 *}
<div id="submissions">
<table class="table table-condensed table-hover">
<thead>
	<tr class="heading" valign="bottom">
		<td>{sort_heading key="common.id" sort='id'}</td>
		<td><span class="disabled">{translate key="submission.date.mmdd"}</span><br />{sort_heading key="common.assigned" sort='assignDate'}</td>
		<td>{sort_heading key="submissions.sec" sort='section'}</td>
		<td>{sort_heading key="article.title" sort='title'}</td>
		<td>{sort_heading key="submission.due" sort='dueDate'}</td>
		<td>{sort_heading key="submissions.reviewRound" sort='round'}</td>
	</tr>
</thead>
<tbody>

{iterate from=submissions item=submission}
	{assign var="articleId" value=$submission->getId()}
	{assign var="reviewId" value=$submission->getReviewId()}

	<tr valign="top" onclick="window.location = '{url op="submission" path=$reviewId}'">
		<td>{$articleId|escape}</td>
		<td>{$submission->getDateNotified()|date_format:$dateFormatTrunc}</td>
		<td>{$submission->getSectionAbbrev()|escape}</td>
		<td><a href="{url op="submission" path=$reviewId}" class="action">{$submission->getLocalizedTitle()|strip_tags|truncate:60:"..."}</a></td>
		<td class="nowrap">{$submission->getDateDue()|date_format:$dateFormatTrunc}</td>
		<td>{$submission->getRound()}</td>
	</tr>
{/iterate}
{if $submissions->wasEmpty()}
<tr>
		<td colspan="6" class="nodata">{translate key="submissions.noSubmissions"}</td>
	</tr>
{else}
	<tr>
		<td colspan="3" align="left" class="number-results-table">{page_info iterator=$submissions}</td>
		<td colspan="3" align="right" class="footer-table-numbers">{page_links anchor="submissions" name="submissions" iterator=$submissions sort=$sort sortDirection=$sortDirection}</td>
	</tr>
{/if}
</tbody>
</table>
</div>

