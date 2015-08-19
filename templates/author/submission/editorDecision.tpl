{**
 * templates/author/submission/editorDecision.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2003-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Subtemplate defining the author's editor decision table.
 *
 *}
<div id="editorDecision">
<div class="page-header"><h3>{translate key="submission.editorDecision"}</h3></div>

{assign var=authorFiles value=$submission->getAuthorFileRevisions($submission->getCurrentRound())}
{assign var=editorFiles value=$submission->getEditorFileRevisions($submission->getCurrentRound())}

<div class="row well">
	<div class="col-md-12">
		<div class="label col-md-2">{translate key="editor.article.decision"}</div>
		<div class="col-md-10">
			{if $lastEditorDecision}
				{assign var="decision" value=$lastEditorDecision.decision}
				{translate key=$editorDecisionOptions.$decision}{if $lastEditorDecision.dateDecided != 0} {$lastEditorDecision.dateDecided|date_format:$dateFormatShort}{/if}
			{else}
				&mdash;
			{/if}
		</div>
	</div>
	<div class="col-md-12">
		<div class="label col-md-2">
			{translate key="submission.notifyEditor"}
		</div>
		<div class="col-md-10">
			{url|assign:"notifyAuthorUrl" op="emailEditorDecisionComment" articleId=$submission->getId()}
			{icon name="mail" url=$notifyAuthorUrl}
		</div>
	</div>
	<div class="col-md-12">
		<div class="label col-md-2">
			{translate key="submission.editorAuthorRecord"}
		</div>
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
<div class="row well">
	<div class="col-md-12">
		<div class="label col-md-2">
			{translate key="submission.editorVersion"}
		</div>
		<div class="col-md-10">
			{foreach from=$editorFiles item=editorFile key=key}
				<a href="{url op="downloadFile" path=$submission->getId()|to_array:$editorFile->getFileId():$editorFile->getRevision()}" class="file">{$editorFile->getFileName()|escape}</a>&nbsp;&nbsp;{$editorFile->getDateModified()|date_format:$dateFormatShort}<br />
			{foreachelse}
				{translate key="common.none"}
			{/foreach}
		</div>
	</div>
	<div class="col-md-12">
		<div class="label col-md-2">
			Your reviewed version
		</div>
		<div class="col-md-10">
			{foreach from=$authorFiles item=authorFile key=key}
				<a href="{url op="downloadFile" path=$submission->getId()|to_array:$authorFile->getFileId():$authorFile->getRevision()}" class="file">{$authorFile->getFileName()|escape}</a>&nbsp;&nbsp;{$authorFile->getDateModified()|date_format:$dateFormatShort}&nbsp;&nbsp;&nbsp;&nbsp;
				<a href="{url op="deleteArticleFile" path=$submission->getId()|to_array:$authorFile->getFileId():$authorFile->getRevision()}" class="action">{translate key="common.delete"}</a><br />
			{foreachelse}
				{translate key="common.none"}
			{/foreach}
		</div>
	</div>
	<div class="col-md-12">
		<div class="label col-md-2">
			{translate key="author.article.uploadAuthorVersion"}
		</div>
		<div class="col-md-10">
			<form method="post" action="{url op="uploadRevisedVersion"}" enctype="multipart/form-data">
				<input type="hidden" name="articleId" value="{$submission->getId()}" />
				<input type="file" name="upload" class="uploadField" />
				<input type="submit" name="submit" value="{translate key="common.upload"}" class="button" />
			</form>

		</div>
	</div>
</div>
</div>
