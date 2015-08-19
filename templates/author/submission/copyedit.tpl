{**
 * templates/author/submission/copyedit.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2003-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Subtemplate defining the copyediting table.
 *
 *}
<div id="copyedit">
<div class="page-header"><h3>{translate key="submission.copyediting"}</h3></div>

<div class="row" class="margin-bottom-10">
	<div class="col-md-6">
		<a href="{url op="viewMetadata" path=$submission->getId()}" class="action btn btn-default btn-sm"><i class="material-icons icon-inside-button">subject</i> {translate key="submission.reviewMetadata"}</a>
	</div>
	<div class="col-md-6">
		{if $currentJournal->getLocalizedSetting('copyeditInstructions')}
		<a href="javascript:openHelp('{url op="instructions" path="copy"}')" class="action btn btn-default btn-sm copyeditor-instructions"><i class="material-icons icon-inside-button">info_outline</i> {translate key="submission.copyedit.instructions"}</a>
		{/if}
	</div>
</div>

{if $useCopyeditors}
<div class="col-md-12">
	<div class="label col-md-2">{translate key="user.role.copyeditor"}</div>
	<div class="col-md-10">{if $submission->getUserIdBySignoffType('SIGNOFF_COPYEDITING_INITIAL')}{$copyeditor->getFullName()|escape}{else}{translate key="common.none"}{/if}</div>
</div>
{/if}


<div class="col-md-12 well">
	<div class="col-md-1 step-copyediting-number">1</div>
	{assign var="copyeditInitialSignoff" value=$submission->getSignoff('SIGNOFF_COPYEDITING_INITIAL')}
	<div class="col-md-5"><h4>{translate key="submission.copyedit.initialCopyedit"}</h4></div>
	<div class="col-md-2">
		<div class="col-md-12 label">{translate key="submission.request"}</div>
		<div class="col-md-12">{$copyeditInitialSignoff->getDateNotified()|date_format:$dateFormatShort|default:"&mdash;"}</div>
	</div>
	<div class="col-md-2">
		<div class="col-md-12 label">{translate key="submission.underway"}</div>
		<div class="col-md-12">{$copyeditInitialSignoff->getDateUnderway()|date_format:$dateFormatShort|default:"&mdash;"}</div>
	</div>	
	<div class="col-md-2">
		<div class="col-md-12 label">{translate key="submission.complete"}</div>
		<div class="col-md-12">{$copyeditInitialSignoff->getDateCompleted()|date_format:$dateFormatShort|default:"&mdash;"}</div>
	</div>
	<div class="col-md-9">
			{translate key="common.file"}:
			{if $copyeditInitialSignoff->getDateCompleted() && $initialCopyeditFile}
				<a href="{url op="downloadFile" path=$submission->getId()|to_array:$copyeditInitialSignoff->getFileId():$copyeditInitialSignoff->getFileRevision()}" class="file">{$initialCopyeditFile->getFileName()|escape}</a>&nbsp;&nbsp;{$initialCopyeditFile->getDateModified()|date_format:$dateFormatShort}
			{else}
				{translate key="common.none"}
			{/if}
	</div>
</div>

<div class="col-md-12 well">
	<div class="col-md-1 step-copyediting-number">2</div>
	{assign var="copyeditAuthorSignoff" value=$submission->getSignoff('SIGNOFF_COPYEDITING_AUTHOR')}
	<div class="col-md-5"><h4>{translate key="submission.copyedit.editorAuthorReview"}</h4></div>
	<div class="col-md-2">
		<div class="col-md-12 label">{translate key="submission.request"}</div>
		<div class="col-md-12">{$copyeditAuthorSignoff->getDateNotified()|date_format:$dateFormatShort|default:"&mdash;"}</div>
	</div>
	<div class="col-md-2">
		<div class="col-md-12 label">{translate key="submission.underway"}</div>
		<div class="col-md-12">{$copyeditAuthorSignoff->getDateUnderway()|date_format:$dateFormatShort|default:"&mdash;"}</div>
	</div>
	<div class="col-md-2">
		<div class="col-md-12 label">{translate key="submission.complete"}</div>
		<div class="col-md-12">
			{if not $copyeditAuthorSignoff->getDateNotified() or $copyeditAuthorSignoff->getDateCompleted()}
				{icon name="mail" disabled="disabled"}
			{else}
				{url|assign:"url" op="completeAuthorCopyedit" articleId=$submission->getId()}
				{translate|assign:"confirmMessage" key="common.confirmComplete"}
				{icon name="mail" onclick="return confirm('$confirmMessage')" url=$url}
			{/if}
			{$copyeditAuthorSignoff->getDateCompleted()|date_format:$dateFormatShort|default:""}
		</div>
	</div>
	<div class="col-md-9">
		<div class="row col-md-12">
			{translate key="common.file"}:
			{if $copyeditAuthorSignoff->getDateNotified() && $editorAuthorCopyeditFile}
				<a href="{url op="downloadFile" path=$submission->getId()|to_array:$copyeditAuthorSignoff->getFileId():$copyeditAuthorSignoff->getFileRevision()}" class="file">{$editorAuthorCopyeditFile->getFileName()|escape}</a>&nbsp;&nbsp;{$editorAuthorCopyeditFile->getDateModified()|date_format:$dateFormatShort}
			{else}
				{translate key="common.none"}
			{/if}
		</div>
		<div class="row col-md-9">
			<form method="post" action="{url op="uploadCopyeditVersion"}"  enctype="multipart/form-data">
				<input type="hidden" name="articleId" value="{$submission->getId()}" />
				<input type="hidden" name="copyeditStage" value="author" />
				<input type="file" name="upload"{if not $copyeditAuthorSignoff->getDateNotified() or $copyeditAuthorSignoff->getDateCompleted()} disabled="disabled"{/if} class="uploadField" />
				<input type="submit" class="button" value="{translate key="common.upload"}"{if not $copyeditAuthorSignoff->getDateNotified() or $copyeditAuthorSignoff->getDateCompleted()} disabled="disabled"{/if} />
			</form>
		</div>
	</div>
</div>

<div class="col-md-12 well">
	<div class="col-md-1 step-copyediting-number">3</div>
	{assign var="copyeditFinalSignoff" value=$submission->getSignoff('SIGNOFF_COPYEDITING_FINAL')}
	<div class="col-md-5"><h4>{translate key="submission.copyedit.finalCopyedit"}</h4></div>
	<div class="col-md-2">
		<div class="col-md-12 label">{translate key="submission.request"}</div>
		<div class="col-md-12">{$copyeditFinalSignoff->getDateNotified()|date_format:$dateFormatShort|default:"&mdash;"}</div>
	</div>	
	<div class="col-md-2">
		<div class="col-md-12 label">{translate key="submission.underway"}</div>
		<div class="col-md-12">{$copyeditFinalSignoff->getDateUnderway()|date_format:$dateFormatShort|default:"&mdash;"}</div>	
	</div>		
	<div class="col-md-2">
		<div class="col-md-12 label">{translate key="submission.underway"}</div>
		<div class="col-md-12">{$copyeditFinalSignoff->getDateCompleted()|date_format:$dateFormatShort|default:"&mdash;"}</div>
	</div>
	<div class="row col-md-9">
		{translate key="common.file"}:
		{if $copyeditFinalSignoff->getDateCompleted() && $finalCopyeditFile}
			<a href="{url op="downloadFile" path=$submission->getId()|to_array:$copyeditFinalSignoff->getFileId():$copyeditFinalSignoff->getFileRevision()}" class="file">{$finalCopyeditFile->getFileName()|escape}</a>&nbsp;&nbsp;{$finalCopyeditFile->getDateModified()|date_format:$dateFormatShort}
		{else}
			{translate key="common.none"}
		{/if}
	</div>
</div>

<div class="row col-md-12">
	<div class="label col-md-2">{translate key="submission.copyedit.copyeditComments"}</div>
	<div class="col-md-10">
		{if $submission->getMostRecentCopyeditComment()}
			{assign var="comment" value=$submission->getMostRecentCopyeditComment()}
			<a href="javascript:openComments('{url op="viewCopyeditComments" path=$submission->getId() anchor=$comment->getId()}');" class="btn btn-default btn-xs">{icon name="comment"} {$comment->getDatePosted()|date_format:$dateFormatShort}</a>
		{else}
			<a href="javascript:openComments('{url op="viewCopyeditComments" path=$submission->getId()}');" class="btn btn-default btn-xs">{icon name="comment"} {translate key="common.noComments"}</a>
		{/if}
	</div>
</div>
</div>
