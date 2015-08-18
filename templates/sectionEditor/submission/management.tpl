{**
 * templates/sectionEditor/submission/management.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2003-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Subtemplate defining the submission management table.
 *
 *}
<div id="submission">

<div class="panel panel-default">
  	<div class="panel-heading">
    	<h3 class="panel-header-without-margin">{translate key="article.submission"}</h3>
  	</div>
  	<div class="panel-body">

{assign var="submissionFile" value=$submission->getSubmissionFile()}
{assign var="suppFiles" value=$submission->getSuppFiles()}

		<div class="col-md-12">
			<div class="label col-md-2">{translate key="article.authors"}</div>
			<div class="col-md-10">
				{url|assign:"url" page="user" op="email" redirectUrl=$currentUrl to=$submission->getAuthorEmails() subject=$submission->getLocalizedTitle() articleId=$submission->getId()}
				{$submission->getAuthorString()|escape} {icon name="mail" url=$url}
			</div>
		</div>
		<div class="col-md-12">
			<div class="label col-md-2">{translate key="article.title"}</div>
			<div class="col-md-10">{$submission->getLocalizedTitle()|strip_unsafe_html}</div>
		</div>
		<div class="col-md-12">
			<div class="label col-md-2">{translate key="submission.originalFile"}</div>
			<div class="col-md-10">
				{if $submissionFile}
					<a href="{url op="downloadFile" path=$submission->getId()|to_array:$submissionFile->getFileId()}" class="file">{$submissionFile->getFileName()|escape}</a>&nbsp;&nbsp;{$submissionFile->getDateModified()|date_format:$dateFormatShort}
				{else}
					{translate key="common.none"}
				{/if}
			</div>
		</div>
		<div class="col-md-12">
			<div class="label col-md-2">{translate key="article.suppFilesAbbrev"}</div>
			<div class="col-md-10">
			{foreach name="suppFiles" from=$suppFiles item=suppFile}
				{if !$notFirst} {*First*}
				<div class="row col-md-6">
				{else} {*Rest*}
				<div class="row col-md-12">
				{/if}
					{if $suppFile->getFileId()}
						<a href="{url op="downloadFile" path=$submission->getId()|to_array:$suppFile->getFileId()}" class="file">{$suppFile->getFileName()|escape}</a>
						&nbsp;&nbsp;
					{elseif $suppFile->getRemoteURL() != ''}
						<a href="{$suppFile->getRemoteURL()|escape}" target="_blank">{$suppFile->getRemoteURL()|truncate:20:"..."|escape}</a>
						&nbsp;&nbsp;
					{/if}
					{if $suppFile->getDateModified()}
						{$suppFile->getDateModified()|date_format:$dateFormatShort}&nbsp;&nbsp;
					{else}
						{$suppFile->getDateSubmitted()|date_format:$dateFormatShort}&nbsp;&nbsp;
					{/if}
					<a href="{url op="editSuppFile" from="submission" path=$submission->getId()|to_array:$suppFile->getId()}" class="action btn btn-xs btn-default"><i class="material-icons icon-inside-button">mode_edit</i> {translate key="common.edit"}</a>
					<a href="{url op="deleteSuppFile" from="submission" path=$submission->getId()|to_array:$suppFile->getId()}" onclick="return confirm('{translate|escape:"jsparam" key="author.submit.confirmDeleteSuppFile"}')" class="action btn btn-xs btn-default"><i class="material-icons icon-inside-button">delete</i> {translate key="common.delete"}</a>
				{if !$notFirst} {*First*}
				</div>
				<div class="col-md-6">
					<a href="{url op="addSuppFile" from="submission" path=$submission->getId()}" class="action btn btn-xs btn-default"><i class="material-icons icon-inside-button">add</i> {translate key="submission.addSuppFile"}</a>
				</div>
				{else} {*Rest*}
				</div>
				{/if}
				{assign var=notFirst value=1}
			{foreachelse}
				{translate key="common.none"}&nbsp;&nbsp;&nbsp;&nbsp;<a href="{url op="addSuppFile" from="submission" path=$submission->getId()}" class="action btn btn-xs btn-default"><i class="material-icons icon-inside-button">add</i> {translate key="submission.addSuppFile"}</a>
			{/foreach}
			</div>
		</div>
		<div class="col-md-12">
			<div class="label col-md-2">{translate key="submission.submitter"}</div>
			<div class="col-md-10">
				{assign var="submitter" value=$submission->getUser()}
				{assign var=emailString value=$submitter->getFullName()|concat:" <":$submitter->getEmail():">"}
				{url|assign:"url" page="user" op="email" redirectUrl=$currentUrl to=$emailString|to_array subject=$submission->getLocalizedTitle|strip_tags articleId=$submission->getId()}
				{$submitter->getFullName()|escape} {icon name="mail" url=$url}
			</div>
		</div>
		<div class="col-md-12">
			<div class="label col-md-2">{translate key="common.dateSubmitted"}</div>
			<div class="col-md-10">{$submission->getDateSubmitted()|date_format:$dateFormatShort}</div>
		</div>
		<div class="col-md-12">
			<div class="label col-md-2">{translate key="section.section"}</div>
			<div class="col-md-3">{$submission->getSectionTitle()|escape}</div>
			<div class="col-md-7">
				<form action="{url op="updateSection" path=$submission->getId()}" method="post">
					<div class="col-md-2">
						{translate key="submission.changeSection"}
					</div> 
					<div class="col-md-7">
						<select name="section" size="1" class="selectMenu">{html_options options=$sections selected=$submission->getSectionId()}</select>
					</div>
					<div class="col-md-3">
						<input type="submit" value="{translate key="common.record"}" class="button" />
					</div>
				</form>
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

