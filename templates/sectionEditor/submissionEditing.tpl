{**
 * templates/sectionEditor/submissionEditing.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2003-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Submission editing.
 *
 *}
{strip}
{translate|assign:"pageTitleTranslated" key="submission.page.editing" id=$submission->getId()}
{assign var="pageCrumbTitle" value="submission.editing"}
{include file="common/header.tpl"}
{/strip}

<script>
	var alternativeTitle = '<h2>{translate key="article.submission"} {$submission->getId()}</h2>';
</script>

<ul class="nav nav-tabs nav-justified">
	<li role="presentation"><a href="{url op="submission" path=$submission->getId()}">{translate key="submission.summary"}</a></li>
	{if $canReview}<li role="presentation"><a href="{url op="submissionReview" path=$submission->getId()}">{translate key="submission.review"}</a></li>{/if}
	<li role="presentation" class="active"><a href="{url op="submissionEditing" path=$submission->getId()}">{translate key="submission.editing"}</a></li>
	<li role="presentation"><a href="{url op="submissionHistory" path=$submission->getId()}">{translate key="submission.history"}</a></li>
	<li role="presentation"><a href="{url op="submissionCitations" path=$submission->getId()}">{translate key="submission.citations"}</a></li>
</ul>

{include file="sectionEditor/submission/summary.tpl"}

<div class="separator"></div>

{include file="sectionEditor/submission/copyedit.tpl"}

<div class="separator"></div>

{include file="sectionEditor/submission/scheduling.tpl"}

<div class="separator"></div>

{assign var="finalCopyeditSignoff" value=$submission->getSignoff('SIGNOFF_COPYEDITING_FINAL')}
{if $finalCopyeditSignoff->getDateCompleted() or $submission->getGalleys()|@count gt 0 }
{* If the last step of copyediting is completed (it is signed) or if it was send 
directly to the last step of the process (It will have at least one galley) *}

{include file="sectionEditor/submission/layout.tpl"}

<div class="separator"></div>

{include file="sectionEditor/submission/proofread.tpl"}
{/if}

{include file="common/footer.tpl"}

