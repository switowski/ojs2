{**
 * templates/editor/issues/issueGalleys.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2003-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Form for uploading and editing issue galleys
 *}
{strip}
{assign var="pageTitleTranslated" value=$issue->getIssueIdentification()}
{assign var="pageCrumbTitleTranslated" value=$issue->getIssueIdentification(false,true)}
{include file="common/header.tpl"}
{/strip}

{if !$isLayoutEditor}{* Layout Editors can also access this page. *}
	<ul class="nav nav-tabs nav-justified">
		<li role="presentation"><a href="{url op="createIssue"}">{translate key="editor.navigation.createIssue"}</a></li>
		<li role="presentation" {if $unpublished} class="active"{/if}><a href="{url op="futureIssues"}">{translate key="editor.navigation.futureIssues"}</a></li>
		<li role="presentation" {if !$unpublished} class="active"{/if}><a href="{url op="backIssues"}">{translate key="editor.navigation.issueArchive"}</a></li>
	</ul>
{/if}

<script>
	var alternativeTitle = '';
</script>

<form action="#">
<select name="issue" class="selectMenu" onchange="if(this.options[this.selectedIndex].value > 0) location.href='{url|escape:"javascript" op="issueToc" path="ISSUE_ID" escape=false}'.replace('ISSUE_ID', this.options[this.selectedIndex].value)" size="1">{html_options options=$issueOptions selected=$issueId}</select>
</form>

{if $unpublished}<div class="row col-md-12"><a href="{url page="issue" op="view" path=$issue->getBestIssueId()}" class="btn btn-default">{translate key="editor.issues.previewIssue"}</a></div>{/if}

<div class="clearfix"></div>

<ul class="nav nav-tabs nav-justified margin-top-20">
	<li role="presentation"><a href="{url op="issueToc" path=$issueId}">{translate key="issue.toc"}</a></li>
	<li role="presentation"><a href="{url op="issueData" path=$issueId}">{translate key="editor.issues.issueData"}</a></li>
	<li role="presentation" class="active"><a href="{url op="issueGalleys" path=$issueId}">{translate key="editor.issues.galleys"}</a></li>
</ul>

<form id="issueGalleys" method="post" action="{url op="uploadIssueGalley" path=$issueId}" enctype="multipart/form-data">
{include file="common/formErrors.tpl"}
<div id="issueId">
<h3>{translate key="editor.issues.galleys"}</h3>
<p>{translate key="editor.issues.issueGalleysDescription"}</p>
<table width="100%" class="data">
{if count($formLocales) > 1}
	<tr valign="top">
		<td width="20%" class="label">{fieldLabel name="formLocale" key="form.formLanguage"}</td>
		<td width="80%" class="value">
			{url|assign:"issueUrl" op="issueGalleys" path=$issueId escape=false}
			{form_language_chooser form="issue" url=$issueUrl}
			<span class="instruct">{translate key="form.formLanguage.description"}</span>
		</td>
	</tr>
{/if}
</table>
<table width="100%" class="table table-condensed table-striped">
<thead>
	<tr>
		<td colspan="2" class="heading">{translate key="submission.layout.galleyFormat"}</td>
		<td class="heading">{translate key="common.file"}</td>
		<td class="heading">{translate key="common.order"}</td>
		<td class="heading">{translate key="common.action"}</td>
		<td class="heading">{translate key="submission.views"}</td>
	</tr>
</thead>
<tbody>
	{foreach name=galleys from=$issueGalleys item=galley}
	<tr>
		<td width="2%">{$smarty.foreach.galleys.iteration}.</td>
		<td width="26%">{$galley->getGalleyLabel()|escape} &nbsp; <a href="{url op="proofIssueGalley" path=$issue->getId()|to_array:$galley->getId()}" class="action">{translate key="submission.layout.viewProof"}</a></td>
		<td><a href="{url op="downloadIssueFile" path=$issue->getId()|to_array:$galley->getFileId()}" class="file">{$galley->getFileName()|escape}</a>&nbsp;&nbsp;{$galley->getDateModified()|date_format:$dateFormatShort}</td>
		<td><a href="{url op="orderIssueGalley" d=u issueId=$issue->getId() galleyId=$galley->getId()}" class="plain">&uarr;</a> <a href="{url op="orderIssueGalley" d=d issueId=$issue->getId() galleyId=$galley->getId()}" class="plain">&darr;</a></td>
		<td>
			<a href="{url op="editIssueGalley" path=$issue->getId()|to_array:$galley->getId()}" class="action">{translate key="common.edit"}</a>&nbsp;|&nbsp;<a href="{url op="deleteIssueGalley" path=$issue->getId()|to_array:$galley->getId()}" onclick="return confirm('{translate|escape:"jsparam" key="editor.issues.confirmDeleteGalley"}')" class="action">{translate key="common.delete"}</a>
		</td>
		<td>{$galley->getViews()|escape}</td>
	</tr>
	{foreachelse}
	<tr>
		<td colspan="6" class="nodata">{translate key="editor.issues.noneIssueGalleys"}</td>
	</tr>
	{/foreach}
</tbody>
</table>
	<br />
	<input type="file" name="galleyFile" id="galleyFile" size="10" class="uploadField" />
	<input type="submit" value="{translate key="common.upload"}" class="button" />
</div>
</form>

{include file="common/footer.tpl"}
