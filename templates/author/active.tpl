{**
 * templates/author/active.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2003-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Show the details of active submissions.
 *
 *}

<div id="submissions">
<table class="table table-condensed">
<thead>
	<tr class="heading" valign="bottom">
		<td>{sort_heading key="common.id" sort="id" sortOrder="ASC"}</td>
		<td><span class="disabled">{translate key="submission.date.mmdd"}</span><br />{sort_heading key="submissions.submit" sort="submitDate"}</td>
		<td>{sort_heading key="submissions.sec" sort="section"}</td>
		<td>{sort_heading key="article.authors" sort="authors"}</td>
		<td>{sort_heading key="article.title" sort="title"}</td>
		<td align="right">{sort_heading key="common.status" sort="status"}</td>
	</tr>
</thead>
<tbody>
{iterate from=submissions item=submission}
	{assign var="articleId" value=$submission->getId()}
	{assign var="progress" value=$submission->getSubmissionProgress()}
	<tr valign="top">
		<td>{$articleId|escape}</td>
		<td>{if $submission->getDateSubmitted()}{$submission->getDateSubmitted()|date_format:$dateFormatTrunc}{else}&mdash;{/if}</td>
		<td>{$submission->getSectionAbbrev()|escape}</td>
		<td>{$submission->getAuthorString(true)|truncate:40:"..."|escape}</td>
		{if $progress == 0}
			<td><a href="{url op="submission" path=$articleId}" class="action">{if $submission->getLocalizedTitle()}{$submission->getLocalizedTitle()|strip_tags|truncate:60:"..."}{else}{translate key="common.untitled"}{/if}</a></td>
			<td align="right">
				{assign var="status" value=$submission->getSubmissionStatus()}
				{if $status==STATUS_QUEUED_UNASSIGNED}{translate key="submissions.queuedUnassigned"}
				{elseif $status==STATUS_QUEUED_REVIEW}
					<a href="{url op="submissionReview" path=$articleId}" class="btn btn-default btn-xs">
						{assign var=decision value=$submission->getMostRecentDecision()}
						{if $decision == $smarty.const.SUBMISSION_EDITOR_DECISION_PENDING_REVISIONS}{translate key="author.submissions.queuedReviewRevisions"}
						{elseif $submission->getCurrentRound() > 1}{translate key="author.submissions.queuedReviewSubsequent" round=$submission->getCurrentRound()}
						{else}{translate key="submissions.queuedReview"}
						{/if}
					</a>
				{elseif $status==STATUS_QUEUED_EDITING}
					{assign var="proofSignoff" value=$submission->getSignoff('SIGNOFF_PROOFREADING_AUTHOR')}
					<a href="{url op="submissionEditing" path=$articleId}" class="btn btn-default btn-xs">
						{if $proofSignoff->getDateNotified() && !$proofSignoff->getDateCompleted()}{translate key="author.submissions.queuedEditingCopyedit"}
						{elseif $proofSignoff->getDateNotified() && !$proofSignoff->getDateCompleted()}{translate key="author.submissions.queuedEditingProofread"}
						{else}{translate key="submissions.queuedEditing"}
						{/if}
					</a>
				{/if}

				{** Payment related actions *}
				{if $status==STATUS_QUEUED_UNASSIGNED || $status==STATUS_QUEUED_REVIEW}
					{if $submissionEnabled && !$completedPaymentDAO->hasPaidSubmission($submission->getJournalId(), $submission->getId())}
						<br />
						<a href="{url op="paySubmissionFee" path="$articleId"}" class="btn btn-default btn-xs">{translate key="payment.submission.paySubmission"}</a>					
					{elseif $fastTrackEnabled}
						<br />
						{if $submission->getFastTracked()}
							{translate key="payment.fastTrack.inFastTrack"}
						{else}
							<a href="{url op="payFastTrackFee" path="$articleId"}" class="btn btn-default btn-xs">{translate key="payment.fastTrack.payFastTrack"}</a>
						{/if}
					{/if}
				{elseif $status==STATUS_QUEUED_EDITING}
					{if $publicationEnabled}
						<br />
						{if $completedPaymentDAO->hasPaidPublication($submission->getJournalId(), $submission->getId())}
							{translate key="payment.publication.publicationPaid}
						{else}
							<a href="{url op="payPublicationFee" path="$articleId"}" class="btn btn-default btn-xs">{translate key="payment.publication.payPublication"}</a>
						{/if}
				{/if}		
		{/if}
			</td>
		{else}
			<td><a href="{url op="submit" path=$progress articleId=$articleId}">{if $submission->getLocalizedTitle()}{$submission->getLocalizedTitle()|strip_tags|truncate:60:"..."}{else}{translate key="common.untitled"}{/if}</a></td>
			<td align="right"><span class="text-near-button">{translate key="submissions.incomplete"}</span><a class="btn btn-danger btn-xs" onclick="return cernConfirm('{translate|escape:"jsparam" key="author.submissions.confirmDelete"}','window.location.href = \'{url op="deleteSubmission" path=$articleId}\'', true, event)">{translate key="common.delete"}</a></td>
		{/if}

	</tr>

{/iterate}
{if $submissions->wasEmpty()}
	<tr>
		<td colspan="6" class="nodata">{translate key="submissions.noSubmissions"}</td>
	</tr>
{else}
	<tr>
		<td colspan="4" align="left" class="number-results-table">{page_info iterator=$submissions}</td>
		<td colspan="2" align="right" class="footer-table-numbers">{page_links anchor="submissions" name="submissions" iterator=$submissions sort=$sort sortDirection=$sortDirection}</td>
	</tr>
{/if}
</tbody>
</table>
</div>

