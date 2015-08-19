{**
 * templates/author/submit/step4.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2003-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Step 4 of author article submission.
 *
 *}
{assign var="pageTitle" value="author.submit.step4"}
{include file="author/submit/submitHeader.tpl"}

<script type="text/javascript">
{literal}
<!--
function confirmForgottenUpload() {
	var fieldValue = document.getElementById('submitForm').uploadSuppFile.value;
	if (fieldValue) {
		return confirm("{/literal}{translate key="author.submit.forgottenSubmitSuppFile"}{literal}");
	}
	return true;
}
// -->
{/literal}
</script>

<form id="submitForm" method="post" action="{url op="saveSubmit" path=$submitStep}" enctype="multipart/form-data">
<input type="hidden" name="articleId" value="{$articleId|escape}" />
{include file="common/formErrors.tpl"}

<p>{translate key="author.submit.supplementaryFilesInstructions"}</p>

<table class="table table-condensed table-stripped">
<thead>
<tr class="heading" valign="bottom">
	<td>{translate key="common.id"}</td>
	<td>{translate key="common.title"}</td>
	<td>{translate key="common.originalFileName"}</td>
	<td class="nowrap">{translate key="common.dateUploaded"}</td>
	<td align="right">{translate key="common.action"}</td>
</tr>
</thead>
<tbody>
{foreach from=$suppFiles item=file}
<tr valign="top">
	<td>{$file->getSuppFileId()}</td>
	<td>{$file->getSuppFileTitle()|escape}</td>
	<td>{$file->getOriginalFileName()|escape}</td>
	<td>{$file->getDateSubmitted()|date_format:$dateFormatTrunc}</td>
	<td align="right">
		<a href="{url op="submitSuppFile" path=$file->getSuppFileId() articleId=$articleId}" class="btn btn-default btn-xs"><i class="material-icons icon-inside-button">mode_edit</i> {translate key="common.edit"}</a>
		<a href="{url op="deleteSubmitSuppFile" path=$file->getSuppFileId() articleId=$articleId}" onclick="return confirm('{translate|escape:"jsparam" key="author.submit.confirmDeleteSuppFile"}')" class="btn btn-danger btn-xs"><i class="material-icons icon-inside-button">delete</i> {translate key="common.delete"}</a>
	</td>
</tr>
{foreachelse}
<tr valign="top">
	<td colspan="6" class="nodata">{translate key="author.submit.noSupplementaryFiles"}</td>
</tr>
{/foreach}
</tbody>
</table>

<div class="row">
	<div class="col-md-12">
		<div class="label col-md-3">{fieldLabel name="uploadSuppFile" key="author.submit.uploadSuppFile"}</div>
		<div class="col-md-9">
			<input type="file" name="uploadSuppFile" id="uploadSuppFile"  class="uploadField" /> <input name="submitUploadSuppFile" type="submit" class="button" value="{translate key="common.upload"}" />
			{if $currentJournal->getSetting('showEnsuringLink')}<a class="action" href="javascript:openHelp('{get_help_id key="editorial.sectionEditorsRole.review.blindPeerReview" url="true"}')">{translate key="reviewer.article.ensuringBlindReview"}</a>{/if}
		</div>
	</div>
</div>

<div class="row div-buttons-submission"><input type="submit" onclick="return confirmForgottenUpload()" value="NEXT STEP" class="btn btn-success btn-lg" /> <input type="button" value="{translate key="common.cancel"}" class="btn btn-default" onclick="confirmAction('{url page="author"}', '{translate|escape:"jsparam" key="author.submit.cancelSubmission"}')" /></div>

</form>

{include file="common/footer.tpl"}

