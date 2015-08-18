{**
 * templates/author/submit/step2.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2003-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Step 2 of author article submission.
 *
 *}
{assign var="pageTitle" value="author.submit.step2"}
{include file="author/submit/submitHeader.tpl"}

<form method="post" action="{url op="saveSubmit" path=$submitStep}" enctype="multipart/form-data">
<input type="hidden" name="articleId" value="{$articleId|escape}" />
{include file="common/formErrors.tpl"}

<div id="uploadInstructions">{translate key="author.submit.uploadInstructions"}</div>

{if $journalSettings.supportPhone}
	{assign var="howToKeyName" value="author.submit.howToSubmit"}
{else}
	{assign var="howToKeyName" value="author.submit.howToSubmitNoPhone"}
{/if}

<div class="separator"></div>

<div id="submissionFileInfo">
<div class="page-header"><h3>{translate key="author.submit.submissionFile"}</h3></div>
<div class="row">
{if $submissionFile}
	<div class="col-md-12">
		<div class="label col-md-2">{translate key="common.fileName"}</div>
		<div class="col-md-10"><a href="{url op="download" path=$articleId|to_array:$submissionFile->getFileId()}">{$submissionFile->getFileName()|escape}</a></div>
	</div>
	<div class="col-md-12">
		<div class="label col-md-2">{translate key="common.originalFileName"}</div>
		<div class="col-md-10">{$submissionFile->getOriginalFileName()|escape}</div>
	</div>
	<div class="col-md-12">
		<div class="label col-md-2">{translate key="common.fileSize"}</div>
		<div class="col-md-10">{$submissionFile->getNiceFileSize()}</div>
	</div>
	<div class="col-md-12">
		<div class="label col-md-2">{translate key="common.dateUploaded"}</div>
		<div class="col-md-10">{$submissionFile->getDateUploaded()|date_format:$datetimeFormatShort}</div>
	</div>
{else}
	<div class="col-md-12">
		<div class="label col-md-12">{translate key="author.submit.noSubmissionFile"}</div>
	</div>
{/if}
</div>
</div>

<div class="separator"></div>

<div id="addSubmissionFile">
<div class="row col-md-12">
	<div class="label col-md-2">
		{if $submissionFile}
			{fieldLabel name="submissionFile" key="author.submit.replaceSubmissionFile"}
		{else}
			{fieldLabel name="submissionFile" key="author.submit.uploadSubmissionFile"}
		{/if}
	</div>
	<div class="col-md-10">
		<input type="file" name="submissionFile" id="submissionFile" /> <input name="uploadSubmissionFile" type="submit" class="button" value="{translate key="common.upload"}" />
		{if $currentJournal->getSetting('showEnsuringLink')}<a class="action" href="javascript:openHelp('{get_help_id key="editorial.sectionEditorsRole.review.blindPeerReview" url="true"}')">{translate key="reviewer.article.ensuringBlindReview"}</a>{/if}
	</div>
</div>
</div>

<div class="cleafix"></div>

<div class="row div-buttons-submission"><input type="submit"{if !$submissionFile} onclick="return confirm('{translate|escape:"jsparam" key="author.submit.noSubmissionConfirm"}')"{/if} value="NEXT STEP" class="btn btn-success btn-lg" /> <input type="button" value="{translate key="common.cancel"}" class="btn btn-default" onclick="confirmAction('{url page="author"}', '{translate|escape:"jsparam" key="author.submit.cancelSubmission"}')" /></div>

</form>

{include file="common/footer.tpl"}

