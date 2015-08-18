{**
 * templates/sectionEditor/submissionRegrets.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2003-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Show submission regrets/cancels/earlier rounds
 *
 *
 *}
{strip}
{translate|assign:"pageTitleTranslated" key="sectionEditor.regrets.title" articleId=$submission->getId()}
{assign var=pageTitleTranslated value=$pageTitleTranslated|escape}
{assign var="pageCrumbTitle" value="sectionEditor.regrets.breadcrumb"}
{include file="common/header.tpl"}
{/strip}

{include file="sectionEditor/submission/summary.tpl"}

<div class="separator"></div>

{include file="sectionEditor/submission/rounds.tpl"}

{include file="common/footer.tpl"}

