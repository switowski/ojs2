{**
 * templates/author/submission/management.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2003-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Subtemplate defining the author's submission management table.
 *
 *}
<div id="submission">
<div class="panel panel-default">
  	<div class="panel-heading">
    	<h3 class="panel-header-without-margin">{translate key="article.submission"}</h3>
  	</div>
  	<div class="panel-body">
		<div class="col-md-12">
			<div class="label col-md-2">{translate key="article.authors"}</div>
			<div class="col-md-10">{$submission->getAuthorString(false)|escape}</div>
		</div>
		<div class="col-md-12">
			<div class="label col-md-2">{translate key="article.title"}</div>
			<div class="col-md-10">{$submission->getLocalizedTitle()|strip_unsafe_html}</div>
		</div>
		<div class="col-md-12">
			<div class="label col-md-2">{translate key="submission.originalFile"}</div>
			<div class="col-md-10">
			{if $submissionFile}
				<a href="{url op="downloadFile" path=$submission->getId()|to_array:$submissionFile->getFileId():$submissionFile->getRevision()}" class="file">{$submissionFile->getFileName()|escape}</a>&nbsp;&nbsp;{$submissionFile->getDateModified()|date_format:$dateFormatShort}
			{else}
				{translate key="common.none"}
			{/if}
			</div>
		</div>
		<div class="col-md-12">
			<div class="label col-md-2">{translate key="article.suppFilesAbbrev"}</div>
			<div class="col-md-5">
				{foreach name="suppFiles" from=$suppFiles item=suppFile}
					<a href="{if $submission->getStatus() != STATUS_PUBLISHED && $submission->getStatus() != STATUS_ARCHIVED}{url op="editSuppFile" path=$submission->getId()|to_array:$suppFile->getId()}{else}{url op="downloadFile" path=$submission->getId()|to_array:$suppFile->getFileId()}{/if}" class="file">{$suppFile->getFileName()|escape}</a>&nbsp;&nbsp;{$suppFile->getDateModified()|date_format:$dateFormatShort}<br />
				{foreachelse}
					{translate key="common.none"}
				{/foreach}
			</div>
			{if $submission->getStatus() != STATUS_PUBLISHED && $submission->getStatus() != STATUS_ARCHIVED}
				<div class="col-md-5"><a href="{url op="addSuppFile" path=$submission->getId()}" class="btn btn-xs btn-default"><i class="material-icons icon-inside-button">add</i> {translate key="submission.addSuppFile"}</a></div>
			{/if}
		</div>
		<div class="col-md-12">
			<div class="label col-md-2">{translate key="submission.submitter"}</div>
			<div class="col-md-10">
				{assign var="submitter" value=$submission->getUser()}
				{assign var=emailString value=$submitter->getFullName()|concat:" <":$submitter->getEmail():">"}
				{url|assign:"url" page="user" op="email" to=$emailString|to_array redirectUrl=$currentUrl subject=$submission->getLocalizedTitle()|strip_tags articleId=$submission->getId()}
				{$submitter->getFullName()|escape} {icon name="mail" url=$url}
			</div>
		</div>
		<div class="col-md-12">
			<div class="label col-md-2">{translate key="common.dateSubmitted"}</div>
			<div class="col-md-10">{$submission->getDateSubmitted()|date_format:$datetimeFormatLong}</div>
		</div>
		<div class="col-md-12">
			<div class="label col-md-2">{translate key="section.section"}</div>
			<div class="col-md-10">{$submission->getSectionTitle()|escape}</div>
		</div>
		<div class="col-md-12">
			<div class="label col-md-2">{translate key="user.role.editor"}</div>
		{assign var="editAssignments" value=$submission->getEditAssignments()}
			<div class="col-md-10">
				{foreach from=$editAssignments item=editAssignment}
					<div class="row col-md-12">
						{assign var=emailString value=$editAssignment->getEditorFullName()|concat:" <":$editAssignment->getEditorEmail():">"}
						{url|assign:"url" page="user" op="email" to=$emailString|to_array redirectUrl=$currentUrl subject=$submission->getLocalizedTitle()|strip_tags articleId=$submission->getId()}
						{$editAssignment->getEditorFullName()|escape} {icon name="mail" url=$url}
						{if !$editAssignment->getCanEdit() || !$editAssignment->getCanReview()}
							{if $editAssignment->getCanEdit()}
								({translate key="submission.editing"})
							{else}
								({translate key="submission.review"})
							{/if}
						{/if}
					</div>
                {foreachelse}
                        {translate key="common.noneAssigned"}
                {/foreach}
			</div>
		</div>
	{if $submission->getCommentsToEditor()}
		<div class="col-md-12">
			<div class="label col-md-2">{translate key="article.commentsToEditor"}</div>
			<div class="col-md-10">{$submission->getCommentsToEditor()|strip_unsafe_html|nl2br}</div>
		</div>
	{/if}
	{if $publishedArticle}
		<div class="col-md-12">
			<div class="label col-md-2">{translate key="submission.abstractViews"}</div>
			<div class="col-md-10">{$publishedArticle->getViews()}</div>
		</div>
	{/if}
	
	</div>
</div>
</div>

