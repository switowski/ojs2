{**
 * templates/editor/issues/backIssues.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2003-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Listings of back issues
 *
 *}
{strip}
{assign var="pageTitle" value="editor.issues.backIssues"}
{assign var="page" value=$rangeInfo->getPage()}
{url|assign:"currentUrl" page="editor" op="backIssues"}
{include file="common/header.tpl"}
{/strip}

<script type="text/javascript">
{literal}
$(document).ready(function() { setupTableDND("#dragTable", "moveIssue"); });
{/literal}
</script>

<script>
	var alternativeTitle = '';
</script>

<ul class="nav nav-tabs nav-justified">
    <li role="presentation"><a href="{url op="createIssue"}">{translate key="editor.navigation.createIssue"}</a></li>
    <li role="presentation"><a href="{url op="futureIssues"}">{translate key="editor.navigation.futureIssues"}</a></li>
    <li role="presentation" class="active"><a href="{url op="backIssues"}">{translate key="editor.navigation.issueArchive"}</a></li>
</ul>

<br/>

{if $usesCustomOrdering}
	{url|assign:"resetUrl" op="resetIssueOrder"}
	<p>{translate key="editor.issues.resetIssueOrder" url=$resetUrl}</p>
{/if}

<div id="issues">
<table width="100%" class="table table-condensed table-hover" id="dragTable">
<thead>
	<tr class="heading" valign="bottom">
		<td>{translate key="issue.issue"}</td>
		<td>{translate key="editor.issues.published"}</td>
		<td>{translate key="editor.issues.numArticles"}</td>
		<td>{translate key="common.order"}</td>
		<td align="right">{translate key="common.action"}</td>
	</tr>
</thead>
<tbody>

{iterate from=issues item=issue}
	<tr onclick="window.location = '{url op="issueToc" path=$issue->getId()}'" valign="top" class="data" id="issue-{$issue->getId()}">
		<td class="drag"><a href="{url op="issueToc" path=$issue->getId()}" class="action">{$issue->getIssueIdentification()|strip_unsafe_html|nl2br}</a></td>
		<td class="drag">{$issue->getDatePublished()|date_format:"$dateFormatShort"|default:"&mdash;"}</td>
		<td class="drag">{$issue->getNumArticles()|escape}</td>
		<td width="8%">
			<a class="btn btn-default btn-xs" href="{url op="moveIssue" d=u id=$issue->getId() issuesPage=$page }">&uarr;</a>
			<a class="btn btn-default btn-xs" href="{url op="moveIssue" d=d id=$issue->getId() issuesPage=$page }">&darr;</a>
		</td>
		<td align="right"><a onclick="return cernConfirm('{translate|escape:"jsparam" key="editor.issues.confirmDelete"}','window.location.href = \'{url op="removeIssue" path=$issue->getId() issuesPage=$page }\'', true, event)" class="btn btn-danger btn-xs">{translate key="common.delete"}</a></td>
	</tr>
{/iterate}
{if $issues->wasEmpty()}
	<tr>
		<td colspan="5" class="nodata">{translate key="issue.noIssues"}</td>
	</tr>
{else}
	<tr>
		<td colspan="2" align="left" class="number-results-table">{page_info iterator=$issues}</td>
		<td colspan="3" align="right" class="footer-table-numbers">{page_links anchor="issues" name="issues" iterator=$issues}</td>
	</tr>
{/if}
</tbody>
</table>


<div class="page-header"><h3>{translate key="journal.currentIssue"}</h3></div>
<div class="row col-md-12">
<form action="{url op="setCurrentIssue"}" method="post">
	<div class="col-md-10">
		<select name="issueId" class="selectMenu">
			<option value="">{translate key="common.none"}</option>
			{html_options options=$allIssues|truncate:40:"..." selected=$currentIssueId}
		</select>
	</div>
	<div class="col-md-2">
		<input type="submit" value="{translate key="common.record"}" class="button defaultButton" />
	</div>
</form>
</div>
</div>
{include file="common/footer.tpl"}

