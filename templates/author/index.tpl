{**
 * templates/author/index.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2003-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Journal author index.
 *
 *}
{strip}
{assign var="pageTitle" value="common.queue.long.$pageToDisplay"}
{include file="common/header.tpl"}
{/strip}

<script>
	var alternativeTitle = '<h2>{translate key="article.submissions"}</h2>';
</script>

<ul class="nav nav-tabs nav-justified">
	<li role="presentation" {if ($pageToDisplay == "active")} class="active"{/if}><a href="{url op="index" path="active"}">{translate key="common.queue.short.active"}</a></li>
	<li role="presentation" {if ($pageToDisplay == "completed")} class="active"{/if}><a href="{url op="index" path="completed"}">{translate key="common.queue.short.completed"}</a></li>
</ul>

{include file="author/$pageToDisplay.tpl"}
<div id="submitStart">
<div class="page-header"><h3>{translate key="author.submit.startHereTitle"}</h3></div>
{url|assign:"submitUrl" op="submit"}
<a href="{$submitUrl}" class="btn btn-primary btn-lg">New submission</a>
</div>

{call_hook name="Templates::Author::Index::AdditionalItems"}

{include file="common/footer.tpl"}

