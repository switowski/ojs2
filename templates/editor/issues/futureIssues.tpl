{**
 * templates/editor/issues/futureIssues.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2003-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Listings of future (unpublished) issues.
 *
 *}
{strip}
{assign var="pageTitle" value="editor.issues.futureIssues"}
{url|assign:"currentUrl" page="editor" op="futureIssues"}
{include file="common/header.tpl"}
{/strip}

<script>
	var alternativeTitle = '';
</script>

<ul class="nav nav-tabs nav-justified">
    <li role="presentation"><a href="{url op="createIssue"}">{translate key="editor.navigation.createIssue"}</a></li>
    <li role="presentation" class="active"><a href="{url op="futureIssues"}">{translate key="editor.navigation.futureIssues"}</a></li>
    <li role="presentation"><a href="{url op="backIssues"}">{translate key="editor.navigation.issueArchive"}</a></li>
</ul>

<div id="issues">
<table width="100%" class="table table-condensed table-hover">
<thead>
	<tr class="heading" valign="bottom">
		<td>{translate key="issue.issue"}</td>
		<td>{translate key="editor.issues.numArticles"}</td>
		<td align="right">{translate key="common.action"}</td>
	</tr>
</thead>
<tbody>
	{iterate from=issues item=issue}
	<tr onclick="window.location = '{url op="issueToc" path=$issue->getId()}'" valign="top">
		<td><a href="{url op="issueToc" path=$issue->getId()}" class="action">{$issue->getIssueIdentification()|strip_unsafe_html|nl2br}</a></td>
		<td>{$issue->getNumArticles()|escape}</td>
		<td align="right"><a onclick="return cernConfirm('{translate|escape:"jsparam" key="editor.issues.confirmDelete"}','window.location.href = \'{url op="removeIssue" path=$issue->getId()}\'', true, event)" class="btn btn-xs btn-danger">{translate key="common.delete"}</a></td>
		
	</tr>
{/iterate}
{if $issues->wasEmpty()}
	<tr>
		<td colspan="3" class="nodata">{translate key="issue.noIssues"}</td>
	</tr>
{else}
	<tr>
		<td align="left" class="number-results-table">{page_info iterator=$issues}</td>
		<td colspan="2" align="right" class="footer-table-numbers">{page_links anchor="issues" name="issues" iterator=$issues}</td>
	</tr>
{/if}
</tbody>
</table>
</div>
{include file="common/footer.tpl"}

