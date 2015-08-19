{**
 * templates/editor/submissionsInEditing.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2003-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Show editor's submissions in editing.
 *
 *}
 
<div id="submissions">
<table width="100%" class="table table-condensed table-hover">
<thead>
	<tr class="heading" valign="bottom">
		<td width="5%">{sort_search key="common.id" sort="id"}</td>
		<td width="5%"><span class="disabled">{translate key="submission.date.mmdd"}</span><br />{sort_heading key="submissions.submit" sort="submitDate"}</td>
		<td width="5%">{sort_search key="submissions.sec" sort="section"}</td>
		<td width="15%">{sort_search key="article.authors" sort="authors"}</td>
		<td width="25%">{sort_search key="article.title" sort="title"}</td>
		<td width="10%">{sort_search key="submission.copyedit" sort="subCopyedit"}</td>
		<td width="10%">{sort_search key="submission.layout" sort="subLayout"}</td>
		<td width="10%">{sort_search key="submissions.proof" sort="subProof"}</td>
		<td width="5%">{translate key="article.sectionEditor"}</td>
	</tr>
</thead>
<tbody>
	{iterate from=submissions item=submission}
	{assign var="layoutSignoff" value=$submission->getSignoff('SIGNOFF_LAYOUT')}
	{assign var="layoutEditorProofSignoff" value=$submission->getSignoff('SIGNOFF_PROOFREADING_LAYOUT')}
	{assign var="copyeditorFinalSignoff" value=$submission->getSignoff('SIGNOFF_COPYEDITING_FINAL')}
	{assign var="highlightClass" value=$submission->getHighlightClass()}
	{assign var="fastTracked" value=$submission->getFastTracked()}
	<tr onclick="window.location = '{url op="submissionEditing" path=$submission->getId()}'" valign="top"{if $highlightClass || $fastTracked} class="{$highlightClass|escape} {if $fastTracked}fastTracked{/if}"{/if}>
		<td>{$submission->getId()}</td>
		<td>{$submission->getDateSubmitted()|date_format:$dateFormatTrunc}</td>
		<td>{$submission->getSectionAbbrev()|escape}</td>
		<td>{$submission->getAuthorString(true)|truncate:40:"..."|escape}</td>
		<td><a href="{url op="submissionEditing" path=$submission->getId()}">{$submission->getLocalizedTitle()|strip_tags|truncate:40:"..."}</a></td>
		<td>{if $copyeditorFinalSignoff->getDateCompleted()}{$copyeditorFinalSignoff->getDateCompleted()|date_format:$dateFormatTrunc}{else}&mdash;{/if}</td>
		<td>{if $layoutSignoff->getDateCompleted()}{$layoutSignoff->getDateCompleted()|date_format:$dateFormatTrunc}{else}&mdash;{/if}</td>
		<td>{if $layoutEditorProofSignoff->getDateCompleted()}{$layoutEditorProofSignoff->getDateCompleted()|date_format:$dateFormatTrunc}{else}&mdash;{/if}</td>
		<td>
			{assign var="editAssignments" value=$submission->getEditAssignments()}
			{foreach from=$editAssignments item=editAssignment}{$editAssignment->getEditorInitials()|escape} {/foreach}
		</td>
	</tr>
{/iterate}
{if $submissions->wasEmpty()}
	<tr>
		<td colspan="9" class="nodata">{translate key="submissions.noSubmissions"}</td>
	</tr>
{else}
	<tr>
		<td colspan="5" align="left" class="number-results-table">{page_info iterator=$submissions}</td>
		<td colspan="4" align="right"  class="footer-table-numbers">{page_links anchor="submissions" name="submissions" iterator=$submissions searchField=$searchField searchMatch=$searchMatch search=$search dateFromDay=$dateFromDay dateFromYear=$dateFromYear dateFromMonth=$dateFromMonth dateToDay=$dateToDay dateToYear=$dateToYear dateToMonth=$dateToMonth dateSearchField=$dateSearchField section=$section sort=$sort sortDirection=$sortDirection}</td>
	</tr>
{/if}
</tbody>
</table>
</div>
<div class="clearfix row col-md-12">
	<h4>{translate key="common.notes"}</h4>
	{translate key="editor.submissionEditing.notes"}
</div>

