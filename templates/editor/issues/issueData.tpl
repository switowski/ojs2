{**
 * templates/editor/issues/issueData.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2003-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Form for creation and modification of an issue
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
<select name="issue" class="selectMenu" onchange="if(this.options[this.selectedIndex].value > 0) location.href='{url|escape:"javascript" op="issueToc" path="ISSUE_ID" escape=false}'.replace('ISSUE_ID', this.options[this.selectedIndex].value)" size="1">{html_options options=$issueOptions|truncate:400:"..." selected=$issueId}</select>
</form>

{if $unpublished}<div class="row col-md-12"><a href="{url page="issue" op="view" path=$issue->getBestIssueId()}" class="btn btn-default">{translate key="editor.issues.previewIssue"}</a></div>{/if}

<div class="clearfix"></div>

<ul class="nav nav-tabs nav-justified margin-top-20">
	<li role="presentation"><a href="{url op="issueToc" path=$issueId}">{translate key="issue.toc"}</a></li>
	<li role="presentation" class="active"><a href="{url op="issueData" path=$issueId}">{translate key="editor.issues.issueData"}</a></li>
	<li role="presentation"><a href="{url op="issueGalleys" path=$issueId}">{translate key="editor.issues.galleys"}</a></li>
</ul>

<form id="issue" method="post" action="{url op="editIssue" path=$issueId}" enctype="multipart/form-data">
<input type="hidden" name="fileName[{$formLocale|escape}]" value="{$fileName[$formLocale]|escape}" />
<input type="hidden" name="originalFileName[{$formLocale|escape}]" value="{$originalFileName[$formLocale]|escape}" />
{if $styleFileName}
<input type="hidden" name="styleFileName" value="{$styleFileName|escape}" />
<input type="hidden" name="originalStyleFileName" value="{$originalStyleFileName|escape}" />
{/if}
{include file="common/formErrors.tpl"}
<div id="issueId">
<div class="page-header"><h3>{translate key="editor.issues.identification"}</h3></div>
<div class="row">
	<div class="col-md-12">
		<div class="label col-md-2">{fieldLabel name="formLocale" key="form.formLanguage"}</div>
		<div class="col-md-10">
				{url|assign:"issueUrl" op="createIssue" escape=false}
				{form_language_chooser form="issue" url=$issueUrl}
				<span class="instruct info-text">{translate key="form.formLanguage.description"}</span>
		</div>
	</div>
	<div class="col-md-12">
		<div class="label col-md-2">{fieldLabel name="volume" key="issue.volume"}</div>
		<div class="col-md-10"><input type="text" name="volume" id="volume" value="{$volume|escape}" size="5" maxlength="5" class="textField" /></div>
	</div>
	<div class="col-md-12">
		<div class="label col-md-2">{fieldLabel name="number" key="issue.number"}</div>
		<div class="col-md-10"><input type="text" name="number" id="number" value="{$number|escape}" size="5" maxlength="5" class="textField" /></div>
	</div>
	<div class="col-md-12">
		<div class="label col-md-2">{fieldLabel name="year" key="issue.year"}</div>
		<div class="col-md-10"><input type="text" name="year" id="year" value="{$year|escape}" size="5" maxlength="4" class="textField" /></div>
	</div>
	<div class="col-md-12">
		<div class="label col-md-2">{fieldLabel suppressId="true" name="labelFormat" key="editor.issues.issueIdentification"}</div>
		<div class="col-md-10"><input type="checkbox" name="showVolume" id="showVolume" value="1"{if $showVolume} checked="checked"{/if} /><label for="showVolume"> {translate key="issue.volume"}</label><br /><input type="checkbox" name="showNumber" id="showNumber" value="1"{if $showNumber} checked="checked"{/if} /><label for="showNumber"> {translate key="issue.number"}</label><br /><input type="checkbox" name="showYear" id="showYear" value="1"{if $showYear} checked="checked"{/if} /><label for="showYear"> {translate key="issue.year"}</label><br /><input type="checkbox" name="showTitle" id="showTitle" value="1"{if $showTitle} checked="checked"{/if} /><label for="showTitle"> {translate key="issue.title"}</label></div>
	</div>
	{if $enablePublicIssueId}
	<div class="col-md-12">
		<div class="label col-md-2">{fieldLabel name="publicIssueId" key="editor.issues.publicIssueIdentifier"}</div>
		<div class="col-md-10"><input type="text" name="publicIssueId" id="publicIssueId" value="{$publicIssueId|escape}" size="20" maxlength="255" class="textField" /></div>
	</div>
	{/if}
	<div class="col-md-12">
		<div class="label col-md-2">{fieldLabel name="title" key="issue.title"}</div>
		<div class="col-md-10"><input type="text" name="title[{$formLocale|escape}]" id="title" value="{$title[$formLocale]|escape}" size="40" maxlength="120" class="textField" /></div>
	</div>
	<div class="col-md-12">
		<div class="label col-md-2">{fieldLabel name="description" key="editor.issues.description"}</div>
		<div class="col-md-10"><textarea name="description[{$formLocale|escape}]" id="description" cols="40" rows="5" class="textArea">{$description[$formLocale]|escape}</textarea></div>
	</div>
</div>
</div>

{if $currentJournal->getSetting('publishingMode') == $smarty.const.PUBLISHING_MODE_SUBSCRIPTION}
<div class="separator"></div>
<div id="issueAccess">
<div class="page-header"><h3>{translate key="editor.issues.access"}</h3></div>
<table width="100%" class="data">
	<tr valign="top">
		<td width="20%" class="label">{fieldLabel name="accessStatus" key="editor.issues.accessStatus"}</td>
		<td width="80%" class="value"><select name="accessStatus" id="accessStatus" class="selectMenu">{html_options options=$accessOptions selected=$accessStatus}</select></td>
	</tr>
	<tr valign="top">
		<td class="label">{fieldLabel name="openAccessDate" key="editor.issues.accessDate"}</td>
		<td class="value">
			<input type="checkbox" id="enableOpenAccessDate" name="enableOpenAccessDate" {if $openAccessDate}checked="checked" {/if}onchange="document.getElementById('issue').openAccessDateMonth.disabled=this.checked?false:true;document.getElementById('issue').openAccessDateDay.disabled=this.checked?false:true;document.getElementById('issue').openAccessDateYear.disabled=this.checked?false:true;" />&nbsp;{fieldLabel name="enableOpenAccessDate" key="editor.issues.enableOpenAccessDate"}<br/>
			{if $openAccessDate}
				{html_select_date prefix=openAccessDate time=$openAccessDate end_year="+20" all_extra="class=\"selectMenu\""}
			{else}
				{html_select_date prefix=openAccessDate time=$openAccessDate end_year="+20" all_extra="class=\"selectMenu\" disabled=\"disabled\""}
			{/if}
		</td>
	</tr>
</table>
</div>
{/if}

<div class="separator"></div>

{foreach from=$pubIdPlugins item=pubIdPlugin}
	{assign var=pubIdMetadataFile value=$pubIdPlugin->getPubIdMetadataFile()}
	{include file="$pubIdMetadataFile" pubObject=$issue}
{/foreach}

{call_hook name="Templates::Editor::Issues::IssueData::AdditionalMetadata"}

<div id="issueCover">
<div class="page-header"><h3>{translate key="editor.issues.cover"}</h3></div>
<div class="row">
	<div class="col-md-12">
		<div class="label col-md-12">
			<input type="checkbox" name="showCoverPage[{$formLocale|escape}]" id="showCoverPage" value="1" {if $showCoverPage[$formLocale]} checked="checked"{/if} /> <label for="showCoverPage">{translate key="editor.issues.showCoverPage"}</label>
		</div>
	</div>
	<div class="col-md-12">
		<div class="label col-md-2">{fieldLabel name="coverPage" key="editor.issues.coverPage"}</div>
		<div class="col-md-10">
			<input type="file" name="coverPage" id="coverPage" class="uploadField" />&nbsp;&nbsp;{translate key="form.saveToUpload"}<br/>
			{translate key="editor.issues.coverPageInstructions"}
		</div>
	</div>
	<div class="col-md-12">
		<div class="label col-md-2">{fieldLabel name="coverPageAltText" key="common.altText"}</div>
		<div class="col-md-10"><input type="text" name="coverPageAltText[{$formLocale|escape}]" value="{$coverPageAltText[$formLocale]|escape}" size="40" maxlength="255" class="textField" /></div>
	</div>
	<div class="col-md-12">
		<div class="label col-md-2">{fieldLabel name="styleFile" key="editor.issues.styleFile"}</div>
		<div class="col-md-10"><input type="file" name="styleFile" id="styleFile" class="uploadField" />&nbsp;&nbsp;{translate key="form.saveToUpload"}<br />{translate key="editor.issues.uploaded"}:&nbsp;{if $styleFileName}<a href="javascript:openWindow('{$publicFilesDir}/{$styleFileName|escape}');" class="file">{$originalStyleFileName|escape}</a>&nbsp;<a href="{url op="removeStyleFile" path=$issueId}" onclick="return confirm('{translate|escape:"jsparam" key="editor.issues.removeStyleFile"}')">{translate key="editor.issues.remove"}</a>{else}&mdash;{/if}</div>
	</div>
	<div class="col-md-12">
		<div class="label col-md-2">{fieldLabel name="coverPageDescription" key="editor.issues.coverPageCaption"}</div>
		<div class="col-md-10"><textarea name="coverPageDescription[{$formLocale|escape}]" id="coverPageDescription" cols="40" rows="5" class="textArea">{$coverPageDescription[$formLocale]|escape}</textarea></div>
	</div>
	<div class="col-md-12">
		<div class="label col-md-2">{fieldLabel name="hideCoverPageArchives" key="editor.issues.coverPageDisplay"}</div>
		<div class="col-md-10">
			<div class="row col-md-12"><input type="checkbox" name="hideCoverPageArchives[{$formLocale|escape}]" id="hideCoverPageArchives" value="1" {if $hideCoverPageArchives[$formLocale]} checked="checked"{/if} /> <label for="hideCoverPageArchives">{translate key="editor.issues.hideCoverPageArchives"}</label></div>
			<div class="row col-md-12"><input type="checkbox" name="hideCoverPageCover[{$formLocale|escape}]" id="hideCoverPageCover" value="1" {if $hideCoverPageCover[$formLocale]} checked="checked"{/if} /> <label for="hideCoverPageCover">{translate key="editor.issues.hideCoverPageCover"}</label></div>
		</div>
	</div>
</div>
</div>
<p class="margin-top-20"><input type="submit" value="{translate key="common.save"}" class="btn btn-success btn-lg" /> <input type="button" value="{translate key="common.cancel"}" onclick="document.location.href='{url op="issueData" path=$issueId escape=false}'" class="btn btn-danger btn-lg" /></p>

<p><span class="formRequired">{translate key="common.requiredField"}</span></p>

</form>

{include file="common/footer.tpl"}

