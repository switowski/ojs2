{**
 * templates/reviewer/submission.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2003-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Show the reviewer administration page.
 *
 * FIXME: At "Notify The Editor", fix the date.
 *
 *}
{strip}
{assign var="articleId" value=$submission->getId()}
{assign var="reviewId" value=$reviewAssignment->getId()}
{translate|assign:"pageTitleTranslated" key="submission.page.review" id=$articleId}
{assign var="pageCrumbTitle" value="submission.review"}
{include file="common/header.tpl"}
{/strip}

<script>
	var alternativeTitle = '<h2>{translate key="article.submission"} {$submission->getId()}</h2>';
</script>

<script type="text/javascript">
{literal}
<!--
function confirmSubmissionCheck() {
	if (document.getElementById('recommendation').recommendation.value=='') {
		alert('{/literal}{translate|escape:"javascript" key="reviewer.article.mustSelectDecision"}{literal}');
		return false;
	}
	return confirm('{/literal}{translate|escape:"javascript" key="reviewer.article.confirmDecision"}{literal}');
}
// -->
{/literal}
</script>
<div id="submissionToBeReviewed">
<div class="panel panel-default">
  	<div class="panel-heading">
    	<h3 class="panel-header-without-margin">{translate key="reviewer.article.submissionToBeReviewed"}</h3>
  	</div>
  	<div class="panel-body">
		<div class="col-md-12">
			<div class="label col-md-2">{translate key="article.title"}</div>
			<div class="col-md-10">{$submission->getLocalizedTitle()|strip_unsafe_html}</div>
		</div>
		<div class="col-md-12">
			<div class="label col-md-2">{translate key="article.journalSection"}</div>
			<div class="col-md-10">{$submission->getSectionTitle()|escape}</div>
		</div>
		<div class="col-md-12">
			<div class="label col-md-2">{translate key="article.abstract"}</div>
			<div class="col-md-10">{$submission->getLocalizedAbstract()|strip_unsafe_html|nl2br}</div>
		</div>
		{assign var=editAssignments value=$submission->getEditAssignments()}
		{foreach from=$editAssignments item=editAssignment}
			{if !$notFirstEditAssignment}
				{assign var=notFirstEditAssignment value=1}
				<div class="col-md-12">
					<div class="label col-md-2">{translate key="reviewer.article.submissionEditor"}</div>
					<div class="col-md-10">
			{else}
				<div class="col-md-12">
					<div class="col-md-10 col-md-offset-2">
			{/if}
					{assign var=emailString value=$editAssignment->getEditorFullName()|concat:" <":$editAssignment->getEditorEmail():">"}
					{url|assign:"url" page="user" op="email" to=$emailString|to_array redirectUrl=$currentUrl subject=$submission->getLocalizedTitle()|strip_tags articleId=$articleId}
					{$editAssignment->getEditorFullName()|escape} {icon name="mail" url=$url}
					{if !$editAssignment->getCanEdit() || !$editAssignment->getCanReview()}
						{if $editAssignment->getCanEdit()}
							({translate key="submission.editing"})
						{else}
							({translate key="submission.review"})
						{/if}
					{/if}
					</div>
				</div>
		{/foreach}
			<div class="col-md-12">
					<div class="label col-md-2">{translate key="submission.metadata"}</div>
					<div class="col-md-10">
				       <a href="{url op="viewMetadata" path=$reviewId|to_array:$articleId}" class="action btn btn-default btn-xs" target="_new"><i class="material-icons icon-inside-button">subject</i> {translate key="submission.viewMetadata"}</a>
			       </div>
			</div>
	</div>
</div>

<div id="reviewSchedule">
	<div class="page-header"><h3>{translate key="reviewer.article.reviewSchedule"}</h3></div>
	<div class="row">
		<div class="label col-md-2">{translate key="reviewer.article.schedule.request"}</div>
		<div class="col-md-10">{if $submission->getDateNotified()}{$submission->getDateNotified()|date_format:$dateFormatShort}{else}&mdash;{/if}</div>
	</div>
	<div class="row">
		<div class="label col-md-2">{translate key="reviewer.article.schedule.response"}</div>
		<div class="col-md-10">{if $submission->getDateConfirmed()}{$submission->getDateConfirmed()|date_format:$dateFormatShort}{else}&mdash;{/if}</div>
	</div>
	<div class="row">
		<div class="label col-md-2">{translate key="reviewer.article.schedule.submitted"}</div>
		<div class="col-md-10">{if $submission->getDateCompleted()}{$submission->getDateCompleted()|date_format:$dateFormatShort}{else}&mdash;{/if}</div>
	</div>
	<div class="row">
		<div class="label col-md-2">{translate key="reviewer.article.schedule.due"}</div>
		<div class="col-md-10">{if $submission->getDateDue()}{$submission->getDateDue()|date_format:$dateFormatShort}{else}&mdash;{/if}</div>
	</div>
</div>
<div class="separator"></div>

<div id="reviewSteps">
<div class="page-header"><h3>{translate key="reviewer.article.reviewSteps"}</h3></div>

{include file="common/formErrors.tpl"}

{assign var="currentStep" value=1}

<div class="col-md-12 well">
	{assign var=editAssignments value=$submission->getEditAssignments}
	{* FIXME: Should be able to assign primary editorial contact *}
	{if $editAssignments[0]}{assign var=firstEditAssignment value=$editAssignments[0]}{/if}
	<div class="row col-md-1 step-reviewer-page">{$currentStep|escape}{assign var="currentStep" value=$currentStep+1}</div>
	<div class="col-md-11">
		<div class="row"><span class="instruct">{translate key="reviewer.article.notifyEditorA"}{if $firstEditAssignment}, {$firstEditAssignment->getEditorFullName()|escape},{/if} {translate key="reviewer.article.notifyEditorB"}</span></div>
		<div class="row">
		{translate key="submission.response"}&nbsp;&nbsp;&nbsp;&nbsp;
		{if not $confirmedStatus}
			{url|assign:"acceptUrl" op="confirmReview" reviewId=$reviewId}
			{url|assign:"declineUrl" op="confirmReview" reviewId=$reviewId declineReview=1}

			{if !$submission->getCancelled()}
				<a href="{$acceptUrl}" class="btn btn-success btn-xs">{translate key="reviewer.article.canDoReview"}</a>
				<a href="{$declineUrl}" class="btn btn-danger btn-xs">{translate key="reviewer.article.cannotDoReview"}</a>
			{else}
				{translate key="reviewer.article.canDoReview"} {icon name="mail" disabled="disabled" url=$acceptUrl}
				&nbsp;&nbsp;&nbsp;&nbsp;
				{translate key="reviewer.article.cannotDoReview"} {icon name="mail" disabled="disabled" url=$declineUrl}
			{/if}
		{else}
			{if not $declined}<span class="info-text">{translate key="submission.accepted"}</span>{else}<span class="info-text">{translate key="submission.rejected"}</span>{/if}
		{/if}
		</div>
	</div>
</div>

{if $journal->getLocalizedSetting('reviewGuidelines') != ''}
<div class="col-md-12 well">
	<div class="row col-md-1 step-reviewer-page">{$currentStep|escape}{assign var="currentStep" value=$currentStep+1}</div>
	<div class="col-md-11"><span class="instruct">{translate key="reviewer.article.consultGuidelines"}</span></div>
</div>
{/if}
<div class="col-md-12 well">
	<div class="row col-md-1 step-reviewer-page">{$currentStep|escape}{assign var="currentStep" value=$currentStep+1}</div>
	<div class="col-md-11">
		<div class="row"><span class="instruct">{translate key="reviewer.article.downloadSubmission"}</span></div>
		<div class="row">
			{if ($confirmedStatus and not $declined) or not $journal->getSetting('restrictReviewerFileAccess')}
			<div class="label col-md-3">
				{translate key="submission.submissionManuscript"}
			</div>
			<div class="col-md-9">
				{if $reviewFile}
				{if $submission->getDateConfirmed() or not $journal->getSetting('restrictReviewerAccessToFile')}
					<a href="{url op="downloadFile" path=$reviewId|to_array:$articleId:$reviewFile->getFileId():$reviewFile->getRevision()}" class="file">{$reviewFile->getFileName()|escape}</a>
				{else}{$reviewFile->getFileName()|escape}{/if}
				&nbsp;&nbsp;{$reviewFile->getDateModified()|date_format:$dateFormatShort}
				{else}
				{translate key="common.none"}
				{/if}
			</div>
		<div class="row">
		</div>
			<div class="label col-md-3">
				{translate key="article.suppFiles"}
			</div>
			<div class="col-md-9">
				{assign var=sawSuppFile value=0}
				{foreach from=$suppFiles item=suppFile}
					{if $suppFile->getShowReviewers() }
						<div class="row col-md-12">
						{assign var=sawSuppFile value=1}
						<a href="{url op="downloadFile" path=$reviewId|to_array:$articleId:$suppFile->getFileId()}" class="file">{$suppFile->getFileName()|escape}</a><br />
						</div>
					{/if}
				{/foreach}

				{if !$sawSuppFile}
					{translate key="common.none"}
				{/if}
			</div>
			{else}
			<div class="label col-md-12">{translate key="reviewer.article.restrictedFileAccess"}</div>
			{/if}
		</div>
	</div>
</div>

<table>
{if $currentJournal->getSetting('requireReviewerCompetingInterests')}
<div class="col-md-12 well">
	<div class="row col-md-1 step-reviewer-page">{$currentStep|escape}{assign var="currentStep" value=$currentStep+1}</div>
	<div class="col-md-11">
		<div class="row">
			{url|assign:"competingInterestGuidelinesUrl" page="information" op="competingInterestGuidelines"}
			<span class="instruct">{translate key="reviewer.article.enterCompetingInterests" competingInterestGuidelinesUrl=$competingInterestGuidelinesUrl}</span>
			{if not $confirmedStatus or $declined or $submission->getCancelled() or $submission->getRecommendation()}<br/>
				{$reviewAssignment->getCompetingInterests()|strip_unsafe_html|nl2br}
			{else}
				<form action="{url op="saveCompetingInterests" reviewId=$reviewId}" method="post">
					<textarea {if $cannotChangeCI}disabled="disabled" {/if}name="competingInterests" class="textArea" id="competingInterests" rows="5" cols="40">{$reviewAssignment->getCompetingInterests()|escape}</textarea><br />
					<input {if $cannotChangeCI}disabled="disabled" {/if}class="button defaultButton" type="submit" value="{translate key="common.save"}" />
				</form>
			{/if}
		</div>
	</div>
</div>
{/if}{* $currentJournal->getSetting('requireReviewerCompetingInterests') *}

{if $reviewAssignment->getReviewFormId()}
<div class="col-md-12 well">
	<div class="row col-md-1 step-reviewer-page">{$currentStep|escape}{assign var="currentStep" value=$currentStep+1}</div>
	<div class="col-md-11">
		<div class="row"><span class="instruct">{translate key="reviewer.article.enterReviewForm"}</span></div>
		<div class="row">
			{if $confirmedStatus and not $declined}
				<a href="{url op="editReviewFormResponse" path=$reviewId|to_array:$reviewAssignment->getReviewFormId()}" class="btn btn-default btn-sm">
					REVIEW
				</a>
			{else}
				<a href="#" class="btn btn-default btn-sm disabled">
					REVIEW
				</a>
			{/if}
		</div>
	</div>
</div>
{else}{* $reviewAssignment->getReviewFormId() *}
<div class="col-md-12 well">
	<div class="row col-md-1 step-reviewer-page">{$currentStep|escape}{assign var="currentStep" value=$currentStep+1}</div>
	<div class="col-md-11">
		<div class="row"><span class="instruct">{translate key="reviewer.article.enterReviewA"}</span></div>
		<div class="row">
			{if $confirmedStatus and not $declined}
				<a href="javascript:openComments('{url op="viewPeerReviewComments" path=$articleId|to_array:$reviewId}');" class="btn btn-default btn-sm">
					REVIEW
				</a>
			{else}
				<a href="#" class="btn btn-default btn-sm disabled">
					REVIEW
				</a>
			{/if}
		</div>
	</div>
</div>
{/if}{* $reviewAssignment->getReviewFormId() *}
<div class="col-md-12 well">
	<div class="row col-md-1 step-reviewer-page">{$currentStep|escape}{assign var="currentStep" value=$currentStep+1}</div>
	<div class="col-md-11">
		<div class="row"><span class="instruct">{translate key="reviewer.article.uploadFile"}</span></div>
		<div class="row">
			{if $submission->getRecommendation() === null || $submission->getRecommendation() === ''}
				<div class="col-md-6">
					<form method="post" action="{url op="uploadReviewerVersion"}" enctype="multipart/form-data">
						<input type="hidden" name="reviewId" value="{$reviewId|escape}" />
						<input type="file" name="upload" {if not $confirmedStatus or $declined or $submission->getCancelled()}disabled="disabled"{/if} class="uploadField" />
						<input type="submit" name="submit" value="{translate key="common.upload"}" {if not $confirmedStatus or $declined or $submission->getCancelled()}disabled="disabled"{/if} class="button" />
					</form>
		
					{if $currentJournal->getSetting('showEnsuringLink')}
					<span class="instruct">
						<a class="action btn btn-xs btn-default margin-top-10" href="javascript:openHelp('{get_help_id key="editorial.sectionEditorsRole.review.blindPeerReview" url="true"}')"><i class="material-icons icon-inside-button">warning</i> {translate key="reviewer.article.ensuringBlindReview"}</a>
					</span>
					{/if}
				</div>
			{/if}

		
			<div class="col-md-6">
				{foreach from=$submission->getReviewerFileRevisions() item=reviewerFile key=key}
					<div class="row">
						{assign var=uploadedFileExists value="1"}
						<div class="col-md-4 label">
							{if $key eq "0"}
								{translate key="reviewer.article.uploadedFile"}
							{/if}
						</div>
						<div class="col-md-8">
							<a href="{url op="downloadFile" path=$reviewId|to_array:$articleId:$reviewerFile->getFileId():$reviewerFile->getRevision()}" class="file">{$reviewerFile->getFileName()|escape}</a>
							{$reviewerFile->getDateModified()|date_format:$dateFormatShort}
							{if ($submission->getRecommendation() === null || $submission->getRecommendation() === '') && (!$submission->getCancelled())}
								<a class="action btn btn-xs btn-default" href="{url op="deleteReviewerVersion" path=$reviewId|to_array:$reviewerFile->getFileId():$reviewerFile->getRevision()}"><i class="material-icons icon-inside-button">delete</i> {translate key="common.delete"}</a>
							{/if}
						</div>
					</div>
				{foreachelse}
					<div class="row">
						<div class="col-md-4 label">
							{translate key="reviewer.article.uploadedFile"}
						</div>
						<div class="col-md-8">
							{translate key="common.none"}
						</div>
					</div>
				{/foreach}
			</div>
		</div>
	</div>
</div>


<div class="col-md-12 well">
	<div class="row col-md-1 step-reviewer-page">{$currentStep|escape}{assign var="currentStep" value=$currentStep+1}</div>
	<div class="col-md-11">
		<div class="row"><span class="instruct">{translate key="reviewer.article.selectRecommendation"}</span></div>
		<div class="row">
			<div class="col-md-3 label">{translate key="submission.recommendation"}</div>
			<div class="col-md-9">
					{if $submission->getRecommendation() !== null && $submission->getRecommendation() !== ''}
						{assign var="recommendation" value=$submission->getRecommendation()}
						<strong>{translate key=$reviewerRecommendationOptions.$recommendation}</strong>&nbsp;&nbsp;
						{$submission->getDateCompleted()|date_format:$dateFormatShort}
					{else}
						<form id="recommendation" method="post" action="{url op="recordRecommendation"}">
						<input type="hidden" name="reviewId" value="{$reviewId|escape}" />
						<div class="col-md-6">
							<select name="recommendation" {if not $confirmedStatus or $declined or $submission->getCancelled() or (!$reviewFormResponseExists and !$reviewAssignment->getMostRecentPeerReviewComment() and !$uploadedFileExists)}disabled="disabled"{/if} class="selectMenu">
								{html_options_translate options=$reviewerRecommendationOptions selected=''}
							</select>&nbsp;&nbsp;&nbsp;&nbsp;
						</div>
						<div class="col-md-6">
							<input type="submit" name="submit" onclick="return confirmSubmissionCheck()" class="button" value="{translate key="reviewer.article.submitReview"}" {if not $confirmedStatus or $declined or $submission->getCancelled() or (!$reviewFormResponseExists and !$reviewAssignment->getMostRecentPeerReviewComment() and !$uploadedFileExists)}disabled="disabled"{/if} />
						</div>
						</form>
					{/if}
			</div>
		</div>
	</div>
</div>
</div>
{if $journal->getLocalizedSetting('reviewGuidelines') != ''}
<div class="separator"></div>
<div id="reviewerGuidelines">
<h3>{translate key="reviewer.article.reviewerGuidelines"}</h3>
<p>{$journal->getLocalizedSetting('reviewGuidelines')|nl2br}</p>
</div>
{/if}

{include file="common/footer.tpl"}


