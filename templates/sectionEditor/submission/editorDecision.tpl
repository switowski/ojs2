{**
 * templates/sectionEditor/submission/editorDecision.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2003-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Subtemplate defining the editor decision table.
 *
 *}
<div id="editorDecision">
<div class="page-header"><h3>{translate key="submission.editorDecision"}</h3></div>

<div class="well col-md-12">
	<div class="col-md-12">
		<div class="label col-md-2">{translate key="editor.article.selectDecision"}</div>
		<div class="row col-md-10">
			<form method="post" action="{url op="recordDecision"}">
				<input type="hidden" name="articleId" value="{$submission->getId()}" />
				<div class="col-md-9">
					<select name="decision" size="1" class="selectMenu"{if not $allowRecommendation} disabled="disabled"{/if}>
						{html_options_translate options=$editorDecisionOptions selected=$lastDecision}
					</select>
				</div>
				<div class="col-md-2">
					<input type="submit" onclick="return confirm('{translate|escape:"jsparam" key="editor.submissionReview.confirmDecision"}')" name="submit" value="{translate key="editor.article.recordDecision"}" {if not $allowRecommendation}disabled="disabled"{/if} class="button" />
				</div>
			</form>
		</div>
		{if not $allowRecommendation}
			<div class="col-md-10 col-md-offset-2 info-text">{translate key="editor.article.cannotRecord"}</div>
		{/if}
	</div>
	<div class="col-md-12">
		<div class="label col-md-2">{translate key="editor.article.decision"}</div>
		<div class="col-md-10">
			{foreach from=$submission->getDecisions($round) item=editorDecision key=decisionKey}
				<div class="row col-md-12">
					{assign var="decision" value=$editorDecision.decision}
					{translate key=$editorDecisionOptions.$decision}&nbsp;&nbsp;{if $editorDecision.dateDecided != 0}{$editorDecision.dateDecided|date_format:$dateFormatShort}{/if}
				</div>
			{foreachelse}
				{translate key="common.none"}
			{/foreach}
		</div>
	</div>
</div>

<div class="well col-md-12">
	<div class="col-md-12">
		<div class="label col-md-2">{translate key="submission.notifyAuthor"}</div>
		<div class="col-md-10">
			{url|assign:"notifyAuthorUrl" op="emailEditorDecisionComment" articleId=$submission->getId()}
	
			{if $decision == SUBMISSION_EDITOR_DECISION_DECLINE}
				{* The last decision was a decline; notify the user that sending this message will archive the submission. *}
				{translate|escape:"quotes"|assign:"confirmString" key="editor.submissionReview.emailWillArchive"}
				{icon name="mail" url=$notifyAuthorUrl onclick="return confirm('$confirmString')"}
			{else}
				{icon name="mail" url=$notifyAuthorUrl}
			{/if}
		</div>
	</div>

	<div class="col-md-12">
		<div class="label col-md-2">{translate key="submission.editorAuthorRecord"}</div>
		<div class="col-md-10">
			{if $submission->getMostRecentEditorDecisionComment()}
				{assign var="comment" value=$submission->getMostRecentEditorDecisionComment()}
				<a href="javascript:openComments('{url op="viewEditorDecisionComments" path=$submission->getId() anchor=$comment->getId()}');" class="btn btn-default btn-xs">{icon name="comment"} {$comment->getDatePosted()|date_format:$dateFormatShort}</a>
			{else}
				<a href="javascript:openComments('{url op="viewEditorDecisionComments" path=$submission->getId()}');" class="btn btn-default btn-xs">{icon name="comment"} {translate key="common.noComments"}</a>
			{/if}
		</div>
	</div>
</div>

<form method="post" action="{url op="editorReview"}" enctype="multipart/form-data">
<input type="hidden" name="articleId" value="{$submission->getId()}" />
{assign var=authorFiles value=$submission->getAuthorFileRevisions($round)}
{assign var=editorFiles value=$submission->getEditorFileRevisions($round)}

{assign var="authorRevisionExists" value=false}
{foreach from=$authorFiles item=authorFile}
	{assign var="authorRevisionExists" value=true}
{/foreach}

{assign var="editorRevisionExists" value=false}
{foreach from=$editorFiles item=editorFile}
	{assign var="editorRevisionExists" value=true}
{/foreach}
{if $reviewFile}
	{assign var="reviewVersionExists" value=1}
{/if}

<div class="well col-md-12">
	<div class="col-md-12"><div class="col-md-2 label">Author versions</div></div>
	{if $reviewFile}
		<div class="col-md-12">
			<div class="col-md-2 info-text">Original submission</div>
			<div class="col-md-10">
				{if $lastDecision == SUBMISSION_EDITOR_DECISION_ACCEPT || $lastDecision == SUBMISSION_EDITOR_DECISION_RESUBMIT}
					<input type="radio" name="editorDecisionFile" value="{$reviewFile->getFileId()},{$reviewFile->getRevision()}" />
				{/if}
				<a href="{url op="downloadFile" path=$submission->getId()|to_array:$reviewFile->getFileId():$reviewFile->getRevision()}" class="file">{$reviewFile->getFileName()|escape}</a>&nbsp;&nbsp;
				{$reviewFile->getDateModified()|date_format:$dateFormatShort}
				{if $copyeditFile && $copyeditFile->getSourceFileId() == $reviewFile->getFileId()}
					&nbsp;&nbsp;&nbsp;&nbsp;{translate key="submission.sent"}&nbsp;&nbsp;{$copyeditFile->getDateUploaded()|date_format:$dateFormatShort}
				{/if}
			</div>
		</div>
	{/if}
	{assign var="firstItem" value=true}
	{foreach from=$authorFiles item=authorFile key=key}
		<div class="col-md-12">
			{if $firstItem}
				{assign var="firstItem" value=false}
				<div class="col-md-2 info-text">Reviewed version</div>
			{else}
				<div class="label col-md-10">&nbsp;</div>
			{/if}
			<div class="col-md-9">
				{if $lastDecision == SUBMISSION_EDITOR_DECISION_ACCEPT || $lastDecision == SUBMISSION_EDITOR_DECISION_RESUBMIT}<input type="radio" name="editorDecisionFile" value="{$authorFile->getFileId()},{$authorFile->getRevision()}" /> {/if}<a href="{url op="downloadFile" path=$submission->getId()|to_array:$authorFile->getFileId():$authorFile->getRevision()}" class="file">{$authorFile->getFileName()|escape}</a>&nbsp;&nbsp;
				{$authorFile->getDateModified()|date_format:$dateFormatShort}
				{if $copyeditFile && ($copyeditFile->getSourceFileId() == $authorFile->getFileId() && $copyeditFile->getSourceRevision() == $authorFile->getRevision())}
					&nbsp;&nbsp;&nbsp;&nbsp;{translate key="submission.sent"}&nbsp;&nbsp;{$copyeditFile->getDateUploaded()|date_format:$dateFormatShort}
				{/if}
			</div>
		</div>
	{foreachelse}
		<div class="col-md-12">
			<div class="col-md-2 info-text">Reviewed version</div>
			<div class="col-md-10">{translate key="common.none"}</div>
		</div>
	{/foreach}
	{assign var="firstItem" value=true}
	{foreach from=$editorFiles item=editorFile key=key}
		<div class="col-md-12">
			{if $firstItem}
				{assign var="firstItem" value=false}
				<div class="label col-md-2">{translate key="submission.editorVersion"}</div>
			{else}
				<div class="label col-md-2">&nbsp;</div>
			{/if}
			<div class="col-md-10">
				{if $lastDecision == SUBMISSION_EDITOR_DECISION_ACCEPT || $lastDecision == SUBMISSION_EDITOR_DECISION_RESUBMIT}<input type="radio" name="editorDecisionFile" value="{$editorFile->getFileId()},{$editorFile->getRevision()}" /> {/if}<a href="{url op="downloadFile" path=$submission->getId()|to_array:$editorFile->getFileId():$editorFile->getRevision()}" class="file">{$editorFile->getFileName()|escape}</a>&nbsp;&nbsp;
				{$editorFile->getDateModified()|date_format:$dateFormatShort}&nbsp;&nbsp;&nbsp;&nbsp;
				{if $copyeditFile && ($copyeditFile->getSourceFileId() == $editorFile->getFileId() && $copyeditFile->getSourceRevision() == $editorFile->getRevision())}
					{translate key="submission.sent"}&nbsp;&nbsp;{$copyeditFile->getDateUploaded()|date_format:$dateFormatShort}&nbsp;&nbsp;&nbsp;&nbsp;
				{/if}
				<a href="{url op="deleteArticleFile" path=$submission->getId()|to_array:$editorFile->getFileId():$editorFile->getRevision()}" class="btn btn-danger btn-xs">{translate key="common.delete"}</a>
			</div>
		</div>
	{foreachelse}
		<div class="col-md-12">
			<div class="label col-md-2">{translate key="submission.editorVersion"}</div>
			<div class="col-md-10">{translate key="common.none"}</div>
		</div>
	{/foreach}
	<div class="col-md-12 margin-top-10">
		<div class="col-md-10 col-md-offset-2">
			<input type="file" name="upload" class="uploadField" />
			<input type="submit" name="submit" value="{translate key="common.upload"}" class="button" />
		</div>
	</div>
	
	{if $lastDecision == SUBMISSION_EDITOR_DECISION_RESUBMIT}
		<div>&nbsp;</div>
		<div class="col-md-12">
			<div class="col-md-10 col-md-offset-2">
				{translate key="editor.article.resubmitFileForPeerReview"}
				<input type="submit" name="resubmit" {if !($editorRevisionExists or $authorRevisionExists or $reviewVersionExists)}disabled="disabled" {/if}value="{translate key="form.resubmit"}" class="button btn btn-default" />
			</div>
		</div>
	{elseif $lastDecision == SUBMISSION_EDITOR_DECISION_ACCEPT}
		<div>&nbsp;</div>
		<div class="col-md-12">
			<div class="col-md-10 col-md-offset-2">
				{if !($editorRevisionExists or $authorRevisionExists or $reviewVersionExists) or !$submission->getMostRecentEditorDecisionComment()}{assign var=copyeditingUnavailable value=1}{else}{assign var=copyeditingUnavailable value=0}{/if}
				<input type="submit" {if $copyeditingUnavailable}disabled="disabled" {/if}name="setCopyeditFile" value="{translate key="editor.submissionReview.sendToCopyediting"}" class="button btn btn-default" />
				{if $copyeditingUnavailable}
					<br/>
					<span class="instruct">{translate key="editor.submissionReview.cannotSendToCopyediting"}</span>
				{/if}
			</div>
		</div>
	{/if}

</div>

</form>
</div>

