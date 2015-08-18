{**
 * templates/author/submission/summary.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2003-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Subtemplate defining the author's submission summary table.
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
				<div class="row col-md-12">
					{assign var=emailString value=$editAssignment->getEditorFullName()|concat:" <":$editAssignment->getEditorEmail():">"}
					{url|assign:"url" page="user" op="email" redirectUrl=$currentUrl to=$emailString|to_array subject=$submission->getLocalizedTitle()|strip_tags articleId=$submission->getId()}
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
</div>
</div>

