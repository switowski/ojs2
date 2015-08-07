{**
 * templates/sectionEditor/submission/peerReview.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2003-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Subtemplate defining the peer review table.
 *
 *}
<div id="submission">


<div class="panel panel-default">
  	<div class="panel-heading">
    	<h3 style="margin:0">{translate key="article.submission"}</h3>
  	</div>
  	<div class="panel-body">
		<table width="100%" class="data">
			<tr>
				<td width="20%" class="label">{translate key="article.authors"}</td>
				<td width="80%">
					{url|assign:"url" page="user" op="email" redirectUrl=$currentUrl to=$submission->getAuthorEmails() subject=$submission->getLocalizedTitle() articleId=$submission->getId()}
					{$submission->getAuthorString()|escape} {icon name="mail" url=$url}
				</td>
			</tr>
			<tr>
				<td class="label">{translate key="article.title"}</td>
				<td>{$submission->getLocalizedTitle()|strip_unsafe_html}</td>
			</tr>
			<tr>
				<td class="label">{translate key="section.section"}</td>
				<td>{$submission->getSectionTitle()|escape}</td>
			</tr>
			<tr>
				<td class="label">{translate key="user.role.editor"}</td>
				<td>
					{assign var=editAssignments value=$submission->getEditAssignments()}
					{foreach from=$editAssignments item=editAssignment}
						{assign var=emailString value=$editAssignment->getEditorFullName()|concat:" <":$editAssignment->getEditorEmail():">"}
						{url|assign:"url" page="user" op="email" redirectUrl=$currentUrl to=$emailString|to_array subject=$submission->getLocalizedTitle|strip_tags articleId=$submission->getId()}
						{$editAssignment->getEditorFullName()|escape} {icon name="mail" url=$url}
						{if !$editAssignment->getCanEdit() || !$editAssignment->getCanReview()}
							{if $editAssignment->getCanEdit()}
								({translate key="submission.editing"})
							{else}
								({translate key="submission.review"})
							{/if}
						{/if}
						<br/>
					{foreachelse}
						{translate key="common.noneAssigned"}
					{/foreach}
				</td>
			</tr>
			<tr valign="top">
				<td class="label" width="20%">{translate key="submission.reviewVersion"}</td>
				{if $reviewFile}
					<td width="80%" class="value">
						<a href="{url op="downloadFile" path=$submission->getId()|to_array:$reviewFile->getFileId():$reviewFile->getRevision()}" class="file">{$reviewFile->getFileName()|escape}</a>&nbsp;&nbsp;
						{$reviewFile->getDateModified()|date_format:$dateFormatShort}{if $currentJournal->getSetting('showEnsuringLink')}&nbsp;&nbsp;&nbsp;&nbsp;<a class="action" href="javascript:openHelp('{get_help_id key="editorial.sectionEditorsRole.review.blindPeerReview" url="true"}')">{translate key="reviewer.article.ensuringBlindReview"}</a>{/if}
					</td>
				{else}
					<td width="80%" class="nodata">{translate key="common.none"}</td>
				{/if}
			</tr>
			<tr valign="top">
				<td>&nbsp;</td>
				<td>
					<form method="post" action="{url op="uploadReviewVersion"}" enctype="multipart/form-data">
						{translate key="editor.article.uploadReviewVersion"}
						<input type="hidden" name="articleId" value="{$submission->getId()}" />
						<input type="file" name="upload" class="uploadField" />
						<input type="submit" name="submit" value="{translate key="common.upload"}" class="button" />
					</form>
				</td>
			</tr>
			{foreach from=$suppFiles item=suppFile}
				<tr valign="top">
					{if !$notFirstSuppFile}
						<td class="label">{translate key="article.suppFilesAbbrev"}</td>
						{assign var=notFirstSuppFile value=1}
					{else}
						<td></td>
					{/if}
					<td width="80%" class="value nowrap">
						<form method="post" action="{url op="setSuppFileVisibility"}">
						<input type="hidden" name="articleId" value="{$submission->getId()}" />
						<input type="hidden" name="fileId" value="{$suppFile->getId()}" />
		
						{if $suppFile->getFileId() > 0}<a href="{url op="downloadFile" path=$submission->getId()|to_array:$suppFile->getFileId():$suppFile->getRevision()}" class="file">{$suppFile->getFileName()|escape}</a>&nbsp;&nbsp;
						{$suppFile->getDateModified()|date_format:$dateFormatShort}
						{elseif $suppFile->getRemoteURL() != ''}<a href="{$suppFile->getRemoteURL()|escape}" target="_blank">{$suppFile->getRemoteURL()|truncate:20:"..."|escape}</a>{/if}
						&nbsp;&nbsp;
						<label for="show">{translate key="editor.article.showSuppFile"}</label>
						<input type="checkbox" name="show" id="show" value="1"{if $suppFile->getShowReviewers()==1} checked="checked"{/if}/>
						<input type="submit" name="submit" value="{translate key="common.record"}" class="button" />
						</form>
					</td>
				</tr>
			{foreachelse}
			<tr valign="top">
				<td class="label">{translate key="article.suppFilesAbbrev"}</td>
				<td class="nodata">{translate key="common.none"}</td>
			</tr>
		{/foreach}
		</table>
  	</div>
</div>

<div id="peerReview">
<div class="row">
	<div class="page-header"><h3>{translate key="submission.peerReview"}  <small>{translate key="submission.round" round=$round}</small></h3></div>
</div>

<div class="row">
<div class="col-md-12">
<a href="{url op="selectReviewer" path=$submission->getId()}" class="btn btn-success btn-sm">{translate key="editor.article.selectReviewer"}</a>
<a href="{url op="submissionRegrets" path=$submission->getId()}" class="btn btn-default btn-sm">{translate|escape key="sectionEditor.regrets.link"}</a>
</div>
{assign var="start" value="A"|ord}
{foreach from=$reviewAssignments item=reviewAssignment key=reviewKey}
<div class="col-md-12">
{assign var="reviewId" value=$reviewAssignment->getId()}

{if not $reviewAssignment->getCancelled() and not $reviewAssignment->getDeclined()}
	{assign var="reviewIndex" value=$reviewIndexes[$reviewId]}

	<div class="panel panel-default">
  		<div class="panel-heading">
			<table class="data" style="width:100%">
			<tr class="reviewer">
				<td class="r1" style="min-width:115px; width:20%"><h4>{translate key="user.role.reviewer"} {$reviewIndex+$start|chr}</h4></td>
				<td class="r2" style="min-width:150px"><h4>{$reviewAssignment->getReviewerFullName()|escape}</h4></td>
				<td class="r3" style="padding-right:5%" align="right">
						{if not $reviewAssignment->getDateNotified()}
							<a href="{url op="clearReview" path=$submission->getId()|to_array:$reviewAssignment->getId()}" class="btn btn-danger btn-xs">{translate key="editor.article.clearReview"}</a>
						{elseif $reviewAssignment->getDeclined() or not $reviewAssignment->getDateCompleted()}
							<a href="{url op="cancelReview" articleId=$submission->getId() reviewId=$reviewAssignment->getId()}" class="btn btn-danger btn-xs">{translate key="editor.article.cancelReview"}</a>
						{/if}
				</td>
			</tr>
			</table>
		</div>
		<div class="panel-body">
			<table width="100%" class="data table-condensed" style="margin-top:-1px">
			<tr valign="top">
				<td class="label">{translate key="submission.reviewForm"}</td>
				<td>
				{if $reviewAssignment->getReviewFormId()}
					{assign var="reviewFormId" value=$reviewAssignment->getReviewFormId()}
					{$reviewFormTitles[$reviewFormId]}
				{else}
					{translate key="manager.reviewForms.noneChosen"}
				{/if}
				{if !$reviewAssignment->getDateCompleted()}
					<a class="btn btn-success btn-xs" href="{url op="selectReviewForm" path=$submission->getId()|to_array:$reviewAssignment->getId()}"{if $reviewFormResponses[$reviewId]} onclick="return confirm('{translate|escape:"jsparam" key="editor.article.confirmChangeReviewForm"}')"{/if}>{translate key="editor.article.selectReviewForm"}</a>
					{if $reviewAssignment->getReviewFormId()}<a class="btn btn-danger btn-xs" href="{url op="clearReviewForm" path=$submission->getId()|to_array:$reviewAssignment->getId()}"{if $reviewFormResponses[$reviewId]} onclick="return confirm('{translate|escape:"jsparam" key="editor.article.confirmChangeReviewForm"}')"{/if}>{translate key="editor.article.clearReviewForm"}</a>{/if}
				{/if}
				</td>
			</tr>
			<tr valign="top">
				<td class="label" width="20%">&nbsp;</td>
				<td width="80%">
					<table width="100%" class="info">
						<tr>
							<td class="heading" width="25%">{translate key="submission.request"}</td>
							<td class="heading" width="25%">{translate key="submission.underway"}</td>
							<td class="heading" width="25%">{translate key="submission.due"}</td>
							<td class="heading" width="25%">{translate key="submission.acknowledge"}</td>
						</tr>
						<tr valign="top">
							<td>
								{url|assign:"reviewUrl" op="notifyReviewer" reviewId=$reviewAssignment->getId() articleId=$submission->getId()}
								{if $reviewAssignment->getDateNotified()}
									{$reviewAssignment->getDateNotified()|date_format:$dateFormatShort}
									{if !$reviewAssignment->getDateCompleted()}
										{icon name="mail" url=$reviewUrl}
									{/if}
								{elseif $reviewAssignment->getReviewFileId()}
									{icon name="mail" url=$reviewUrl}
								{else}
									{icon name="mail" disabled="disabled" url=$reviewUrl}
									{assign var=needsReviewFileNote value=1}
								{/if}
							</td>
							<td>
								{$reviewAssignment->getDateConfirmed()|date_format:$dateFormatShort|default:"&mdash;"}
							</td>
							<td>
								{if $reviewAssignment->getDeclined()}
									{translate key="sectionEditor.regrets"}
								{else}
									<a href="{url op="setDueDate" path=$reviewAssignment->getSubmissionId()|to_array:$reviewAssignment->getId()}">{if $reviewAssignment->getDateDue()}{$reviewAssignment->getDateDue()|date_format:$dateFormatShort}{else}&mdash;{/if}</a>
								{/if}
							</td>
							<td>
								{url|assign:"thankUrl" op="thankReviewer" reviewId=$reviewAssignment->getId() articleId=$submission->getId()}
								{if $reviewAssignment->getDateAcknowledged()}
									{$reviewAssignment->getDateAcknowledged()|date_format:$dateFormatShort}
								{elseif $reviewAssignment->getDateCompleted()}
									{icon name="mail" url=$thankUrl}
								{else}
									{icon name="mail" disabled="disabled" url=$thankUrl}
								{/if}
							</td>
						</tr>
					</table>
				</td>
			</tr>
		
			{if $reviewAssignment->getDateConfirmed() && !$reviewAssignment->getDeclined()}
				<tr valign="top">
					<td class="label">{translate key="reviewer.article.recommendation"}</td>
					<td>
						{if $reviewAssignment->getRecommendation() !== null && $reviewAssignment->getRecommendation() !== ''}
							{assign var="recommendation" value=$reviewAssignment->getRecommendation()}
							<span style="font-style: italic;font-weight: bold;">
								{translate key=$reviewerRecommendationOptions.$recommendation}
							</span>
							&nbsp;&nbsp;
							<span style="font-style: italic;">
								{$reviewAssignment->getDateCompleted()|date_format:$dateFormatShort}
							</span>
						{else}
							{translate key="common.none"}&nbsp;&nbsp;&nbsp;&nbsp;
							<a href="{url op="remindReviewer" articleId=$submission->getId() reviewId=$reviewAssignment->getId()}" class="btn btn-default btn-xs">{translate key="reviewer.article.sendReminder"}</a>
							{if $reviewAssignment->getDateReminded()}
								&nbsp;&nbsp;{$reviewAssignment->getDateReminded()|date_format:$dateFormatShort}
								{if $reviewAssignment->getReminderWasAutomatic()}
									&nbsp;&nbsp;{translate key="reviewer.article.automatic"}
								{/if}
							{/if}
						{/if}
					</td>
				</tr>
				{if $currentJournal->getSetting('requireReviewerCompetingInterests')}
					<tr valign="top">
						<td class="label">{translate key="reviewer.competingInterests"}</td>
						<td>{$reviewAssignment->getCompetingInterests()|strip_unsafe_html|nl2br|default:"&mdash;"}</td>
					</tr>
				{/if}{* requireReviewerCompetingInterests *}
				{if $reviewFormResponses[$reviewId]}
					<tr valign="top">
						<td class="label">{translate key="submission.reviewFormResponse"}</td>
						<td>
							<a href="javascript:openComments('{url op="viewReviewFormResponse" path=$submission->getId()|to_array:$reviewAssignment->getId()}');" class="icon">{icon name="comment"}</a>
						</td>
					</tr>
				{/if}
				{if !$reviewAssignment->getReviewFormId() || $reviewAssignment->getMostRecentPeerReviewComment()}{* Only display comments link if a comment is entered or this is a non-review form review *}
					<tr valign="top">
						<td class="label">{translate key="submission.review"}</td>
						<td>
							{if $reviewAssignment->getMostRecentPeerReviewComment()}
								{assign var="comment" value=$reviewAssignment->getMostRecentPeerReviewComment()}
								<a href="javascript:openComments('{url op="viewPeerReviewComments" path=$submission->getId()|to_array:$reviewAssignment->getId() anchor=$comment->getId()}');" class="btn btn-default btn-sm">REVIEW</a>&nbsp;&nbsp;<span style="font-style:italic;padding-top:2px">{$comment->getDatePosted()|date_format:$dateFormatShort}</span>
							{else}
								<a href="javascript:openComments('{url op="viewPeerReviewComments" path=$submission->getId()|to_array:$reviewAssignment->getId()}');" class="btn btn-default btn-sm">REVIEW</a>&nbsp;&nbsp;<span style="font-style:italic;padding-top:2px">{translate key="submission.comments.noComments"}</span>
							{/if}
						</td>
					</tr>
				{/if}
				<tr valign="top">
					<td class="label">{translate key="reviewer.article.uploadedFile"}</td>
					<td>
						<table width="100%" class="data">
							{foreach from=$reviewAssignment->getReviewerFileRevisions() item=reviewerFile key=key}
							<tr valign="top">
								<td valign="middle">
									<form id="authorView{$reviewAssignment->getId()}" method="post" action="{url op="makeReviewerFileViewable"}">
										<a href="{url op="downloadFile" path=$submission->getId()|to_array:$reviewerFile->getFileId():$reviewerFile->getRevision()}" class="file">{$reviewerFile->getFileName()|escape}</a>&nbsp;&nbsp;{$reviewerFile->getDateModified()|date_format:$dateFormatShort}
										<input type="hidden" name="reviewId" value="{$reviewAssignment->getId()}" />
										<input type="hidden" name="articleId" value="{$submission->getId()}" />
										<input type="hidden" name="fileId" value="{$reviewerFile->getFileId()}" />
										<input type="hidden" name="revision" value="{$reviewerFile->getRevision()}" />
										{translate key="editor.article.showAuthor"} <input type="checkbox" name="viewable" value="1"{if $reviewerFile->getViewable()} checked="checked"{/if} />
										<input type="submit" value="{translate key="common.record"}" class="button" />
									</form>
								</td>
							</tr>
							{foreachelse}
							<tr valign="top">
								<td>{translate key="common.none"}</td>
							</tr>
							{/foreach}
						</table>
					</td>
				</tr>
			{/if}
		
			{if (($reviewAssignment->getRecommendation() === null || $reviewAssignment->getRecommendation() === '') || !$reviewAssignment->getDateConfirmed()) && $reviewAssignment->getDateNotified() && !$reviewAssignment->getDeclined()}
				<tr valign="top">
					<td class="label">{translate key="reviewer.article.editorToEnter"}</td>
					<td>
						{if !$reviewAssignment->getDateConfirmed()}
							<a href="{url op="confirmReviewForReviewer" path=$submission->getId()|to_array:$reviewAssignment->getId() accept=1}" class="btn btn-success btn-xs">{translate key="reviewer.article.canDoReview"}</a>
							<a href="{url op="confirmReviewForReviewer" path=$submission->getId()|to_array:$reviewAssignment->getId() accept=0}" class="btn btn-danger btn-xs">{translate key="reviewer.article.cannotDoReview"}</a><br />
						{/if}
						<form method="post" action="{url op="uploadReviewForReviewer"}" enctype="multipart/form-data">
							{translate key="editor.article.uploadReviewForReviewer"}
							<input type="hidden" name="articleId" value="{$submission->getId()}" />
							<input type="hidden" name="reviewId" value="{$reviewAssignment->getId()}"/>
							<input type="file" name="upload" class="uploadField" />
							<input type="submit" name="submit" value="{translate key="common.upload"}" class="button" />
						</form>
						{if $reviewAssignment->getDateConfirmed() && !$reviewAssignment->getDeclined()}
							<a class="btn btn-success" style="margin-top:5px" href="{url op="enterReviewerRecommendation" articleId=$submission->getId() reviewId=$reviewAssignment->getId()}">{translate key="editor.article.recommendation"}</a>
						{/if}
					</td>
				</tr>
			{/if}
		
			{if $reviewAssignment->getDateNotified() && !$reviewAssignment->getDeclined() && $rateReviewerOnQuality}
				<tr valign="top">
					<td class="label">{translate key="editor.article.rateReviewer"}</td>
					<td>
					<form method="post" action="{url op="rateReviewer"}">
						<input type="hidden" name="reviewId" value="{$reviewAssignment->getId()}" />
						<input type="hidden" name="articleId" value="{$submission->getId()}" />
						<select name="quality" size="1" class="selectMenu">
							{html_options_translate options=$reviewerRatingOptions selected=$reviewAssignment->getQuality()}
						</select>&nbsp;&nbsp;
						<input type="submit" value="{translate key="common.record"}" class="button" />
						{if $reviewAssignment->getDateRated()}
							&nbsp;&nbsp;{$reviewAssignment->getDateRated()|date_format:$dateFormatShort}
						{/if}
					</form>
					</td>
				</tr>
			{/if}
			{if $needsReviewFileNote}
				<tr valign="top">
					<td>&nbsp;</td>
					<td>
						{translate key="submission.review.mustUploadFileForReview"}
					</td>
				</tr>
			{/if}
			</table>
		</div>
	</div>
{/if}
</div>
{/foreach}
</div>
</div>

