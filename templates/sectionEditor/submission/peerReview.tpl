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
    	<h3 class="panel-header-without-margin">{translate key="article.submission"}</h3>
  	</div>
  	<div class="panel-body">
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
			<div class="label col-md-2">{translate key="section.section"}</div>
			<div class="col-md-10">{$submission->getSectionTitle()|escape}</div>
		</div>
		<div class="col-md-12">
			<div class="label col-md-2">{translate key="user.role.editor"}</div>
			<div class="col-md-10">
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
			</div>
		</div>
		<div class="col-md-12">
			<div class="label col-md-2">{translate key="submission.reviewVersion"}</div>
				{if $reviewFile}
					<div class="col-md-10">
						<a href="{url op="downloadFile" path=$submission->getId()|to_array:$reviewFile->getFileId():$reviewFile->getRevision()}" class="file">{$reviewFile->getFileName()|escape}</a>&nbsp;&nbsp;
						{$reviewFile->getDateModified()|date_format:$dateFormatShort}{if $currentJournal->getSetting('showEnsuringLink')}&nbsp;&nbsp;&nbsp;&nbsp;<a class="action" href="javascript:openHelp('{get_help_id key="editorial.sectionEditorsRole.review.blindPeerReview" url="true"}')">{translate key="reviewer.article.ensuringBlindReview"}</a>{/if}
					</div>
				{else}
					<div class="col-md-10">{translate key="common.none"}</div>
				{/if}
			</tr>
		</div>
		<div class="col-md-10 col-sm-offset-2">
				<form method="post" action="{url op="uploadReviewVersion"}" enctype="multipart/form-data">
					{translate key="editor.article.uploadReviewVersion"}
					<input type="hidden" name="articleId" value="{$submission->getId()}" />
					<input type="file" name="upload" class="uploadField" />
					<input type="submit" name="submit" value="{translate key="common.upload"}" class="button" />
				</form>
		</div>
		{foreach from=$suppFiles item=suppFile}
			<div class="col-md-12">
				{if !$notFirstSuppFile}
					<div class="label col-md-2">{translate key="article.suppFilesAbbrev"}</div>
					{assign var=notFirstSuppFile value=1}
				{else}
					<div class="label col-md-2">&nbsp;</div>
				{/if}
				<div class="col-md-10">
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
				</div>
			</div>
		{foreachelse}
			<div class="col-md-12">
				<div class="label col-md-2">{translate key="article.suppFilesAbbrev"}</div>
				<div class="col-md-10">{translate key="common.none"}</div>
			</div>
		{/foreach}
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
  		<div class="panel-heading col-md-12">
			<div class="col-md-2"><h4>{translate key="user.role.reviewer"} {$reviewIndex+$start|chr}</h4></div>
			<div class="col-md-8"><h4 class="info-text">{$reviewAssignment->getReviewerFullName()|escape}</h4></div>
			<div class="col-md-2">
				{if not $reviewAssignment->getDateNotified()}
					<a href="{url op="clearReview" path=$submission->getId()|to_array:$reviewAssignment->getId()}" class="btn btn-danger btn-xs margin-top-10">{translate key="editor.article.clearReview"}</a>
				{elseif $reviewAssignment->getDeclined() or not $reviewAssignment->getDateCompleted()}
					<a href="{url op="cancelReview" articleId=$submission->getId() reviewId=$reviewAssignment->getId()}" class="btn btn-danger btn-xs margin-top-10">{translate key="editor.article.cancelReview"}</a>
				{/if}
			</div>
		</div>
		<div class="panel-body">
			<div class="col-md-12">
				<div class="label col-md-2">{translate key="submission.reviewForm"}</div>
				<div class="col-md-5">
				{if $reviewAssignment->getReviewFormId()}
					{assign var="reviewFormId" value=$reviewAssignment->getReviewFormId()}
					{$reviewFormTitles[$reviewFormId]}
				{else}
					{translate key="manager.reviewForms.noneChosen"}
				{/if}
				</div>
				<div class="col-md-5">
				{if !$reviewAssignment->getDateCompleted()}
					<a class="btn btn-success btn-xs" href="{url op="selectReviewForm" path=$submission->getId()|to_array:$reviewAssignment->getId()}"{if $reviewFormResponses[$reviewId]} onclick="return confirm('{translate|escape:"jsparam" key="editor.article.confirmChangeReviewForm"}')"{/if}>{translate key="editor.article.selectReviewForm"}</a>
					{if $reviewAssignment->getReviewFormId()}<a class="btn btn-danger btn-xs" href="{url op="clearReviewForm" path=$submission->getId()|to_array:$reviewAssignment->getId()}"{if $reviewFormResponses[$reviewId]} onclick="return confirm('{translate|escape:"jsparam" key="editor.article.confirmChangeReviewForm"}')"{/if}>{translate key="editor.article.clearReviewForm"}</a>{/if}
				{/if}
				</div>
			</div>
			<div class="col-md-12">
				<div class="label col-md-2">&nbsp;</div>
				<div class="col-md-10">
					<div class="col-md-12">
						<div class="col-md-3">
							<div class="col-md-12 label">{translate key="submission.request"}</div>
							<div class="col-md-12">
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
							</div>
						</div>
						<div class="col-md-3">
							<div class="col-md-12 label">{translate key="submission.underway"}</div>
							<div class="col-md-12">
								{$reviewAssignment->getDateConfirmed()|date_format:$dateFormatShort|default:"&mdash;"}
							</div>
						</div>
						<div class="col-md-3">
							<div class="col-md-12 label">{translate key="submission.due"}</div>
							<div class="col-md-12">
								{if $reviewAssignment->getDeclined()}
									{translate key="sectionEditor.regrets"}
								{else}
									<a href="{url op="setDueDate" path=$reviewAssignment->getSubmissionId()|to_array:$reviewAssignment->getId()}">{if $reviewAssignment->getDateDue()}{$reviewAssignment->getDateDue()|date_format:$dateFormatShort}{else}&mdash;{/if}</a>
								{/if}
							</div>
						</div>
						<div class="col-md-3">
							<div class="col-md-12 label">{translate key="submission.acknowledge"}</div>
							<div class="col-md-12">
								{url|assign:"thankUrl" op="thankReviewer" reviewId=$reviewAssignment->getId() articleId=$submission->getId()}
								{if $reviewAssignment->getDateAcknowledged()}
									{$reviewAssignment->getDateAcknowledged()|date_format:$dateFormatShort}
								{elseif $reviewAssignment->getDateCompleted()}
									{icon name="mail" url=$thankUrl}
								{else}
									{icon name="mail" disabled="disabled" url=$thankUrl}
								{/if}
							</div>
						</div>
					</div>
				</div>
			</div>
		
			{if $reviewAssignment->getDateConfirmed() && !$reviewAssignment->getDeclined()}
				<div class="col-md-12">
					<div class="label col-md-2">{translate key="reviewer.article.recommendation"}</div>
					<div class="col-md-10">
						{if $reviewAssignment->getRecommendation() !== null && $reviewAssignment->getRecommendation() !== ''}
							{assign var="recommendation" value=$reviewAssignment->getRecommendation()}
							<span class="review-recommendation">
								{translate key=$reviewerRecommendationOptions.$recommendation}
							</span>
							&nbsp;&nbsp;
							<span class="info-text">
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
					</div>
				</div>
				{if $currentJournal->getSetting('requireReviewerCompetingInterests')}
				<div class="col-md-12">
					<div class="label col-md-2"> class="label">{translate key="reviewer.competingInterests"}</div>
					<div class="col-md-10">{$reviewAssignment->getCompetingInterests()|strip_unsafe_html|nl2br|default:"&mdash;"}</div>
				</div>
				{/if}{* requireReviewerCompetingInterests *}
				{if $reviewFormResponses[$reviewId]}
					<div class="col-md-12">
						<div class="label col-md-2">{translate key="submission.reviewFormResponse"}</div>
						<div class="col-md-10">
							<a href="javascript:openComments('{url op="viewReviewFormResponse" path=$submission->getId()|to_array:$reviewAssignment->getId()}');" class="icon">{icon name="comment"}</a>
						</div>
					</div>
				{/if}
				{if !$reviewAssignment->getReviewFormId() || $reviewAssignment->getMostRecentPeerReviewComment()}{* Only display comments link if a comment is entered or this is a non-review form review *}
					<div class="col-md-12">
						<div class="label col-md-2">{translate key="submission.review"}</div>
						<div class="col-md-10">
							{if $reviewAssignment->getMostRecentPeerReviewComment()}
								{assign var="comment" value=$reviewAssignment->getMostRecentPeerReviewComment()}
								<a href="javascript:openComments('{url op="viewPeerReviewComments" path=$submission->getId()|to_array:$reviewAssignment->getId() anchor=$comment->getId()}');" class="btn btn-default btn-sm">REVIEW</a>&nbsp;&nbsp;<span class="date-review">{$comment->getDatePosted()|date_format:$dateFormatShort}</span>
							{else}
								<a href="javascript:openComments('{url op="viewPeerReviewComments" path=$submission->getId()|to_array:$reviewAssignment->getId()}');" class="btn btn-default btn-sm">REVIEW</a>&nbsp;&nbsp;<span class="date-review">{translate key="submission.comments.noComments"}</span>
							{/if}
						</div>
					</div>
				{/if}
					<div class="col-md-12">
						<div class="label col-md-2">{translate key="reviewer.article.uploadedFile"}</div>
						<div class="col-md-10">
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
						</div>
					</div>
			{/if}
		
			{if (($reviewAssignment->getRecommendation() === null || $reviewAssignment->getRecommendation() === '') || !$reviewAssignment->getDateConfirmed()) && $reviewAssignment->getDateNotified() && !$reviewAssignment->getDeclined()}
				<div class="col-md-12">
					<div class="label col-md-2">{translate key="reviewer.article.editorToEnter"}</div>
					<div class="col-md-10">
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
							<a class="btn btn-success recomendation-button" href="{url op="enterReviewerRecommendation" articleId=$submission->getId() reviewId=$reviewAssignment->getId()}">{translate key="editor.article.recommendation"}</a>
						{/if}
					</div>
				</div>
			{/if}
		
			{if $reviewAssignment->getDateNotified() && !$reviewAssignment->getDeclined() && $rateReviewerOnQuality}
				<div class="col-md-12">
					<div class="label col-md-2">{translate key="editor.article.rateReviewer"}</div>
					<div class="col-md-10">
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
					</div>
				</div>
			{/if}
			{if $needsReviewFileNote}
				<div class="col-md-offset-2 col-md-10">
						{translate key="submission.review.mustUploadFileForReview"}
				</div>
			{/if}
		</div>
	</div>
{/if}
</div>
{/foreach}
</div>
</div>

