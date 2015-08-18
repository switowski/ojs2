{**
 * templates/sectionEditor/submission/copyedit.tpl
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

<div class="row margin-bottom-10">
	<div class="col-md-6">
		<a href="{url op="viewMetadata" path=$submission->getId()}" class="action btn btn-default btn-sm"><i class="material-icons icon-inside-button">subject</i> {translate key="submission.reviewMetadata"}</a>

		{if $useCopyeditors}
		<table width="100%" class="data">
			<tr>
				<td width="20%" class="label">{translate key="user.role.copyeditor"}</td>
				{if $submission->getUserIdBySignoffType('SIGNOFF_COPYEDITING_INITIAL')}<td width="20%" class="value">{$copyeditor->getFullName()|escape}</td>{/if}
				<td class="value"><a href="{url op="selectCopyeditor" path=$submission->getId()}" class="action btn btn-default btn-sm">{translate key="editor.article.selectCopyeditor"}</a></td>
			</tr>
		</table>
		{/if}
	</div>
	<div class="col-md-6">
		{if $currentJournal->getLocalizedSetting('copyeditInstructions')}
		<a href="javascript:openHelp('{url op="instructions" path="copy"}')" class="action btn btn-default btn-sm copyeditor-instructions"><i class="material-icons icon-inside-button">info_outline</i> {translate key="submission.copyedit.instructions"}</a>
		{/if}
	</div>
</div>

<div class="col-md-12 well">
	<div class="col-md-1 step-copyediting-number">1</div>
		{assign var="initialCopyeditSignoff" value=$submission->getSignoff('SIGNOFF_COPYEDITING_INITIAL')}
	<div class="col-md-3"><h4>{translate key="submission.copyedit.initialCopyedit"}</h4></div>
	<div class="col-md-2">
		<div class="col-md-12 label">{translate key="submission.request"}</div>
		<div class="col-md-12">
			{if $useCopyeditors}
				{if $submission->getUserIdBySignoffType('SIGNOFF_COPYEDITING_INITIAL') && $initialCopyeditFile}
					{url|assign:"url" op="notifyCopyeditor" articleId=$submission->getId()}
					{if $initialCopyeditSignoff->getDateUnderway()}
						{translate|escape:"javascript"|assign:"confirmText" key="sectionEditor.copyedit.confirmRenotify"}
						{icon name="mail" onclick="return confirm('$confirmText')" url=$url}
					{else}
						{icon name="mail" url=$url}
					{/if}
				{else}
					{icon name="mail" disabled="disable"}
				{/if}
			{else}
				{if !$initialCopyeditSignoff->getDateNotified() && $initialCopyeditFile}
					<a href="{url op="initiateCopyedit" articleId=$submission->getId()}" class="action btn btn-default btn-xs">{translate key="common.initiate"}</a>
				{/if}
			{/if}
			{$initialCopyeditSignoff->getDateNotified()|date_format:$dateFormatShort|default:""}
		</div>
	</div>
	<div class="col-md-2">
		<div class="col-md-12 label">{translate key="submission.underway"}</div>
		<div class="col-md-12">
			{if $useCopyeditors}
				{$initialCopyeditSignoff->getDateUnderway()|date_format:$dateFormatShort|default:"&mdash;"}
			{else}
				{translate key="common.notApplicableShort"}
			{/if}
		</div>
	</div>
	<div class="col-md-2">
		<div class="col-md-12 label">{translate key="submission.complete"}</div>
		<div class="col-md-12">
			{if $initialCopyeditSignoff->getDateCompleted()}
				{$initialCopyeditSignoff->getDateCompleted()|date_format:$dateFormatShort}
			{elseif !$useCopyeditors}
				<a href="{url op="completeCopyedit" articleId=$submission->getId()}" class="action btn btn-success btn-xs">{translate key="common.complete"}</a>
			{else}
				&mdash;
			{/if}
		</div>
	</div>
	<div class="col-md-2">
		<div class="col-md-12 label">{translate key="submission.acknowledge"}</div>
		<div class="col-md-12">
			{if $useCopyeditors}
				{if $submission->getUserIdBySignoffType('SIGNOFF_COPYEDITING_INITIAL') &&  $initialCopyeditSignoff->getDateNotified() && !$initialCopyeditSignoff->getDateAcknowledged()}
					{url|assign:"url" op="thankCopyeditor" articleId=$submission->getId()}
					{icon name="mail" url=$url}
				{else}
					{icon name="mail" disabled="disable"}
				{/if}
				{$initialCopyeditSignoff->getDateAcknowledged()|date_format:$dateFormatShort|default:""}
			{else}
				{translate key="common.notApplicableShort"}
			{/if}
		</div>
	</div>
	<div class="col-md-9">
		{translate key="common.file"}:
		{if $initialCopyeditFile}
			<a href="{url op="downloadFile" path=$submission->getId()|to_array:$initialCopyeditFile->getFileId():$initialCopyeditFile->getRevision()}" class="file">{$initialCopyeditFile->getFileName()|escape}</a>&nbsp;&nbsp;{$initialCopyeditFile->getDateModified()|date_format:$dateFormatShort}
		{else}
			{translate key="submission.copyedit.mustUploadFileForInitialCopyedit"}
		{/if}
	</div>
</div>

<div class="col-md-12 well">
	<div class="col-md-1 step-copyediting-number">2</div>
		{assign var="authorCopyeditSignoff" value=$submission->getSignoff('SIGNOFF_COPYEDITING_AUTHOR')}
	<div class="col-md-3"><h4>{translate key="submission.copyedit.editorAuthorReview"}</h4></div>
	<div class="col-md-2">
		<div class="col-md-12 label">{translate key="submission.request"}</div>
		<div class="col-md-12">
			{if ($submission->getUserIdBySignoffType('SIGNOFF_COPYEDITING_INITIAL') || !$useCopyeditors) && $initialCopyeditSignoff->getDateCompleted()}
				{url|assign:"url" op="notifyAuthorCopyedit articleId=$submission->getId()}
				{if $authorCopyeditSignoff->getDateUnderway()}
					{translate|escape:"javascript"|assign:"confirmText" key="sectionEditor.author.confirmRenotify"}
					{icon name="mail" onclick="return confirm('$confirmText')" url=$url}
				{else}
					{icon name="mail" url=$url}
				{/if}
			{else}
				{icon name="mail" disabled="disable"}
			{/if}
			{$authorCopyeditSignoff->getDateNotified()|date_format:$dateFormatShort|default:""}
		</div>
	</div>
	<div class="col-md-2">
		<div class="col-md-12 label">{translate key="submission.underway"}</div>
		<div class="col-md-12">
			{$authorCopyeditSignoff->getDateUnderway()|date_format:$dateFormatShort|default:"&mdash;"}
		</div>
	</div>
	<div class="col-md-2">
		<div class="col-md-12 label">{translate key="submission.complete"}</div>
		<div class="col-md-12">
			{$authorCopyeditSignoff->getDateCompleted()|date_format:$dateFormatShort|default:"&mdash;"}
		</div>
	</div>
	<div class="col-md-2">
		<div class="col-md-12 label">{translate key="submission.acknowledge"}</div>
		<div class="col-md-12">
			{if ($submission->getUserIdBySignoffType('SIGNOFF_COPYEDITING_INITIAL') || !$useCopyeditors) && $authorCopyeditSignoff->getDateNotified() && !$authorCopyeditSignoff->getDateAcknowledged()}
				{url|assign:"url" op="thankAuthorCopyedit articleId=$submission->getId()}
				{icon name="mail" url=$url}
			{else}
				{icon name="mail" disabled="disable"}
			{/if}
			{$authorCopyeditSignoff->getDateAcknowledged()|date_format:$dateFormatShort|default:""}
		</div>
	</div>
	<div class="col-md-9">
			{translate key="common.file"}:
			{if $editorAuthorCopyeditFile}
				<a href="{url op="downloadFile" path=$submission->getId()|to_array:$editorAuthorCopyeditFile->getFileId():$editorAuthorCopyeditFile->getRevision()}" class="file">{$editorAuthorCopyeditFile->getFileName()|escape}</a>&nbsp;&nbsp;{$editorAuthorCopyeditFile->getDateModified()|date_format:$dateFormatShort}
			{/if}
	</div>
</div>
<div class="col-md-12 well">
	<div class="col-md-1 step-copyediting-number">3</div>
		{assign var="finalCopyeditSignoff" value=$submission->getSignoff('SIGNOFF_COPYEDITING_FINAL')}
	<div class="col-md-3"><h4>{translate key="submission.copyedit.finalCopyedit"}</h4></div>
	<div class="col-md-2">
		<div class="col-md-12 label">{translate key="submission.request"}</div>
		<div class="col-md-12">
			{if $useCopyeditors}
				{if $submission->getUserIdBySignoffType('SIGNOFF_COPYEDITING_INITIAL') && $authorCopyeditSignoff->getDateCompleted()}
					{url|assign:"url" op="notifyFinalCopyedit articleId=$submission->getId()}
					{if $finalCopyeditSignoff->getDateUnderway()}
						{translate|escape:"javascript"|assign:"confirmText" key="sectionEditor.copyedit.confirmRenotify"}
						{icon name="mail" onclick="return confirm('$confirmText')" url=$url}
					{else}
						{icon name="mail" url=$url}
					{/if}
				{else}
					{icon name="mail" disabled="disable"}
				{/if}
			{/if}
			{$finalCopyeditSignoff->getDateNotified()|date_format:$dateFormatShort|default:""}
		</div>
	</div>
	<div class="col-md-2">
		<div class="col-md-12 label">{translate key="submission.underway"}</div>
		<div class="col-md-12">
			{if $useCopyeditors}
				{$finalCopyeditSignoff->getDateUnderway()|date_format:$dateFormatShort|default:"&mdash;"}
			{else}
				{translate key="common.notApplicableShort"}
			{/if}
		</div>
	</div>
	<div class="col-md-2">
		<div class="col-md-12 label">{translate key="submission.complete"}</div>
		<div class="col-md-12">
			{if $finalCopyeditSignoff->getDateCompleted()}
				{$finalCopyeditSignoff->getDateCompleted()|date_format:$dateFormatShort}
			{elseif !$useCopyeditors}
				<a href="{url op="completeFinalCopyedit" articleId=$submission->getId()}" class="action btn btn-success btn-xs">{translate key="common.complete"}</a>
			{else}
				&mdash;
			{/if}
		</div>
	</div>
	<div class="col-md-2">
		<div class="col-md-12 label">{translate key="submission.acknowledge"}</div>
		<div class="col-md-12">
			{if $useCopyeditors}
				{if $submission->getUserIdBySignoffType('SIGNOFF_COPYEDITING_INITIAL') &&  $finalCopyeditSignoff->getDateNotified() && !$finalCopyeditSignoff->getDateAcknowledged()}
					{url|assign:"url" op="thankFinalCopyedit articleId=$submission->getId()}
					{icon name="mail" url=$url}
				{else}
					{icon name="mail" disabled="disable"}
				{/if}
				{$finalCopyeditSignoff->getDateAcknowledged()|date_format:$dateFormatShort|default:""}
			{else}
				{translate key="common.notApplicableShort"}
			{/if}
		</div>
	</div>
	<div class="col-md-9">
		{translate key="common.file"}:
		{if $finalCopyeditFile}
			<a href="{url op="downloadFile" path=$submission->getId()|to_array:$finalCopyeditFile->getFileId():$finalCopyeditFile->getRevision()}" class="file">{$finalCopyeditFile->getFileName()|escape}</a>&nbsp;&nbsp;{$finalCopyeditFile->getDateModified()|date_format:$dateFormatShort}
		{/if}
	</div>
</div>

{if $authorCopyeditSignoff->getDateCompleted()}
{assign var="canUploadCopyedit" value="3"}
{elseif $initialCopyeditSignoff->getDateCompleted() && !$authorCopyeditSignoff->getDateCompleted()}
{assign var="canUploadCopyedit" value="2"}
{elseif !$initialCopyeditSignoff->getDateCompleted()}
{assign var="canUploadCopyedit" value="1"}
{/if}

<div class="panel panel-default">
  	<div class="panel-body">
		<form method="post" action="{url op="uploadCopyeditVersion"}"  enctype="multipart/form-data">
			<input type="hidden" name="articleId" value="{$submission->getId()}" />
			<div class="col-md-12">
				<div class="col-md-2">{translate key="submission.uploadFileTo"}</div>
				<div class="col-md-10 radio-buttons-file-copyediting">
					<input type="radio" name="copyeditStage" id="copyeditStageInitial" value="initial" checked="checked" /><label for="copyeditStageInitial">{translate key="navigation.stepNumber" step=1}</label>,
					<input type="radio" name="copyeditStage" id="copyeditStageAuthor" value="author"{if $canUploadCopyedit == 1} disabled="disabled"{else} checked="checked"{/if} /><label for="copyeditStageAuthor"{if $canUploadCopyedit == 1} class="disabled"{/if}>{translate key="navigation.stepNumber" step=2}</label>, {translate key="common.or"}
					<input type="radio" name="copyeditStage" id="copyeditStageFinal" value="final"{if $canUploadCopyedit != 3} disabled="disabled"{else} checked="checked"{/if} /><label for="copyeditStageFinal"{if $canUploadCopyedit != 3} class="disabled"{/if}>{translate key="navigation.stepNumber" step=3}</label>
				</div>
			</div>
			<div class="col-md-12">
				<input type="file" name="upload" size="10" class="uploadField"{if !$canUploadCopyedit} disabled="disabled"{/if} />
				<input type="submit" value="{translate key="common.upload"}" class="button"{if !$canUploadCopyedit} disabled="disabled"{/if} />
			</div>
		</form>

		<div class="col-md-12 margin-top-10">
			{translate key="submission.copyedit.copyeditComments"}
			{if $submission->getMostRecentCopyeditComment()}
				{assign var="comment" value=$submission->getMostRecentCopyeditComment()}
				<a href="javascript:openComments('{url op="viewCopyeditComments" path=$submission->getId() anchor=$comment->getId()}');" class="btn btn-default btn-xs">{icon name="comment"} {$comment->getDatePosted()|date_format:$dateFormatShort}</a>
			{else}
				<a href="javascript:openComments('{url op="viewCopyeditComments" path=$submission->getId()}');" class="btn btn-default btn-xs">{icon name="comment"} {translate key="common.noComments"}</a>
			{/if}
		</div>
	</div>
</div>
</div>

