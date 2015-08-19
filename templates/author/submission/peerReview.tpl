{**
 * templates/author/submission/peerReview.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2003-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Subtemplate defining the author's peer review table.
 *
 *}
<div id="peerReview">

<div class="page-header"><h3>{translate key="submission.peerReview"}</h3></div>

{assign var=start value="A"|ord}
{section name="round" loop=$submission->getCurrentRound()}
{assign var="round" value=$smarty.section.round.index+1}
{assign var=authorFiles value=$submission->getAuthorFileRevisions($round)}
{assign var=editorFiles value=$submission->getEditorFileRevisions($round)}
{assign var="viewableFiles" value=$authorViewableFilesByRound[$round]}



<div class="panel panel-default">
	<div class="panel-heading">
		<h4 class="panel-header-without-margin">{translate key="submission.round" round=$round}</h4>
	</div>
	<div class="panel-body">
		<div class="col-md-12">
			<div class="label col-md-2">
				{translate key="submission.reviewVersion"}
			</div>
			<div class="col-md-10">
				{assign var="reviewFile" value=$reviewFilesByRound[$round]}
				{if $reviewFile}
					<a href="{url op="downloadFile" path=$submission->getId()|to_array:$reviewFile->getFileId():$reviewFile->getRevision()}" class="file">{$reviewFile->getFileName()|escape}</a>&nbsp;&nbsp;{$reviewFile->getDateModified()|date_format:$dateFormatShort}
				{else}
					{translate key="common.none"}
				{/if}
			</div>
		</div>
		<div class="col-md-12">
			<div class="label col-md-2">
				{translate key="submission.initiated"}
			</div>
			<div class="col-md-10">
				{if $reviewEarliestNotificationByRound[$round]}
					{$reviewEarliestNotificationByRound[$round]|date_format:$dateFormatShort}
				{else}
					&mdash;
				{/if}
			</div>
		</div>
		<div class="col-md-12">
			<div class="label col-md-2">
				{translate key="submission.lastModified"}
			</div>
			<div class="col-md-10">
				{if $reviewModifiedByRound[$round]}
					{$reviewModifiedByRound[$round]|date_format:$dateFormatShort}
				{else}
					&mdash;
				{/if}
			</div>
		</div>
		<div class="col-md-12">
			<div class="label col-md-2">
				{translate key="common.uploadedFile"}
			</div>
			<div class="col-md-10">
				{foreach from=$viewableFiles item=reviewerFiles key=reviewer}
					{foreach from=$reviewerFiles item=viewableFilesForReviewer key=reviewId}
						{assign var="roundIndex" value=$reviewIndexesByRound[$round][$reviewId]}
						{assign var=thisReviewer value=$start+$roundIndex|chr}
						{foreach from=$viewableFilesForReviewer item=viewableFile}
							{translate key="user.role.reviewer"} {$thisReviewer|escape}
							<a href="{url op="downloadFile" path=$submission->getId()|to_array:$viewableFile->getFileId():$viewableFile->getRevision()}" class="file">{$viewableFile->getFileName()|escape}</a>&nbsp;&nbsp;{$viewableFile->getDateModified()|date_format:$dateFormatShort}<br />
						{/foreach}
					{/foreach}
				{foreachelse}
					{translate key="common.none"}
				{/foreach}
			</div>
		</div>
		{if !$smarty.section.round.last}
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
					{translate key="submission.authorVersion"}
				</div>
				<div class="col-md-10">
					{foreach from=$authorFiles item=authorFile key=key}
						<a href="{url op="downloadFile" path=$submission->getId()|to_array:$authorFile->getFileId():$authorFile->getRevision()}" class="file">{$authorFile->getFileName()|escape}</a>&nbsp;&nbsp;{$authorFile->getDateModified()|date_format:$dateFormatShort}<br />
					{foreachelse}
						{translate key="common.none"}
					{/foreach}
				</div>
			</div>
		{/if}
	</div>
</div>


{/section}
</div>
