{**
 * templates/author/submissionEditing.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2003-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Author's submission editing.
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
	<li role="presentation"><a href="{url op="submissionReview" path=$submission->getId()}">{translate key="submission.review"}</a></li>
	<li role="presentation" class="active"><a href="{url op="submissionEditing" path=$submission->getId()}">{translate key="submission.editing"}</a></li>
</ul>


{include file="author/submission/summary.tpl"}

{include file="author/submission/copyedit.tpl"}

<div class="clearfix"></div>

{include file="author/submission/layout.tpl"}

{include file="author/submission/proofread.tpl"}

{include file="common/footer.tpl"}

