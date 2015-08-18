{**
 * templates/sectionEditor/submission/status.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2003-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Subtemplate defining the submission status table.
 *}
<div id="status">
<div class="page-header"><h3>{translate key="common.status"}</h3></div>

<div class="row">
		{assign var="status" value=$submission->getSubmissionStatus()}
	<div class="col-md-12">
		<div class="label col-md-2">{translate key="common.status"}</div>
		<div class="col-md-2">
			{if $status == STATUS_ARCHIVED}{translate key="submissions.archived"}
			{elseif $status==STATUS_QUEUED_UNASSIGNED}{translate key="submissions.queuedUnassigned"}
			{elseif $status==STATUS_QUEUED_EDITING}{translate key="submissions.queuedEditing"}
			{elseif $status==STATUS_QUEUED_REVIEW}{translate key="submissions.queuedReview"}
			{elseif $status==STATUS_PUBLISHED}{translate key="submissions.published"}&nbsp;&nbsp;&nbsp;&nbsp;{$issue->getIssueIdentification()|escape}
			{elseif $status==STATUS_DECLINED}{translate key="submissions.declined"}
			{/if}
		</div>
		<div class="col-md-8">
			{if $status != STATUS_ARCHIVED}
				<a href="{url op="unsuitableSubmission" articleId=$submission->getId()}" class="action btn btn-default btn-sm">{translate key="editor.article.archiveSubmission"}</a>
			{else}
				<a href="{url op="restoreToQueue" path=$submission->getId()}" class="action btn btn-default btn-sm">{translate key="editor.article.restoreToQueue"}</a>
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
{if $enableComments}
	<div class="col-md-12">
		<div class="label col-md-2">{translate key="comments.readerComments"}</div>
		<div class="col-md-2">{translate key=$submission->getCommentsStatusString()}</div>
		<div class="col-md-8">
			<form action="{url op="updateCommentsStatus" path=$submission->getId()}" method="post">
				<div class="col-md-2">{translate key="submission.changeComments"}</div>
				<div class="col-md-7"><select name="commentsStatus" size="1" class="selectMenu">{html_options_translate options=$commentsStatusOptions selected=$submission->getCommentsStatus()}</select></div>
				<div class="col-md-3"><input type="submit" value="{translate key="common.record"}" class="button" /></div>
			</form>
		</div>
	</div>
{/if}
</div>
</div>

