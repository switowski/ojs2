{**
 * templates/author/submission/status.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2003-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Subtemplate defining the submission status table.
 *
 *}
<div id="status">
<div class="page-header"><h3>{translate key="common.status"}</h3></div>

<div class="row">
	<div class="col-md-12">
		<div class="label col-md-2">
			{assign var="status" value=$submission->getSubmissionStatus()}
			{translate key="common.status"}
		</div>
		<div class="col-md-10">
			{if $status == STATUS_ARCHIVED}{translate key="submissions.archived"}
			{elseif $status==STATUS_QUEUED_UNASSIGNED}{translate key="submissions.queuedUnassigned"}
			{elseif $status==STATUS_QUEUED_EDITING}{translate key="submissions.queuedEditing"}
			{elseif $status==STATUS_QUEUED_REVIEW}{translate key="submissions.queuedReview"}
			{elseif $status==STATUS_PUBLISHED}{translate key="submissions.published"}&nbsp;&nbsp;&nbsp;&nbsp;{$issue->getIssueIdentification()|escape}
			{elseif $status==STATUS_DECLINED}{translate key="submissions.declined"}
			{/if}
		</div>
	</div>
	<div class="col-md-12">
		<div class="label col-md-2">{translate key="submission.initiated"}</div>
		<div class="col-md-10">{$submission->getDateStatusModified()|date_format:$dateFormatShort}</div>
	</div>
	<div class="col-md-12">
		<div class="label col-md-2">{translate key="submission.lastModified"}</div>
		<div class="col-md-10">{$submission->getLastModified()|date_format:$dateFormatShort}</div>
	</div>
</table>
</div>

