{**
 * templates/copyeditor/submission.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2003-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Copyeditor's submission view.
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

{include file="copyeditor/submission/summary.tpl"}

<div class="clearfix"></div>

{include file="copyeditor/submission/copyedit.tpl"}

<div class="clearfix"></div>

{include file="copyeditor/submission/layout.tpl"}

{include file="common/footer.tpl"}

