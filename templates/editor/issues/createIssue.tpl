{**
 * templates/editor/issues/createIssue.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2003-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Form for creation of an issue
 *
 *}
{strip}
{assign var="pageTitle" value="editor.issues.createIssue"}
{url|assign:"currentUrl" page="editor" op="createIssue"}
{include file="common/header.tpl"}
{/strip}

{include file="common/formErrors.tpl"}

<script>
	var alternativeTitle = '';
</script>

<ul class="nav nav-tabs nav-justified">
	<li role="presentation" class="active"><a href="{url op="createIssue"}">{translate key="editor.navigation.createIssue"}</a></li>
	<li role="presentation"><a href="{url op="futureIssues"}">{translate key="editor.navigation.futureIssues"}</a></li>
	<li role="presentation"><a href="{url op="backIssues"}">{translate key="editor.navigation.issueArchive"}</a></li>
</ul>

<form id="issue" method="post" action="{url op="saveIssue"}" enctype="multipart/form-data">

<div class="separator"></div>
<div id="identification">
<div class="page-header page-header-without-margin-top"><h3>{translate key="editor.issues.identification"}</h3></div>

<div class="row">
{if count($formLocales) > 1}
	<div class="col-md-12">
		<div class="label col-md-2">{fieldLabel name="formLocale" key="form.formLanguage"}</div>
		<div class="col-md-10">
				{url|assign:"issueUrl" op="createIssue" escape=false}
				{form_language_chooser form="issue" url=$issueUrl}
				<span class="instruct info-text">{translate key="form.formLanguage.description"}</span>
		</div>
	</div>
{/if}
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
		<div class="col-md-10">
			<div class="row">
			<div class="col-xs-1"><input class="checkbox-float-right" type="checkbox" name="showVolume" id="showVolume" value="1"{if $showVolume} checked="checked"{/if} /></div>
			<div class="col-xs-11"><label for="showVolume"> {translate key="issue.volume"}</label></div>
			</div>
			<div class="row">
			<div class="col-xs-1"><input class="checkbox-float-right" type="checkbox" name="showNumber" id="showNumber" value="1"{if $showNumber} checked="checked"{/if} /></div>
			<div class="col-xs-11"><label for="showNumber"> {translate key="issue.number"}</label></div>
			</div>
			<div class="row">
			<div class="col-xs-1"><input class="checkbox-float-right" type="checkbox" name="showYear" id="showYear" value="1"{if $showYear} checked="checked"{/if} /></div>
			<div class="col-xs-11"><label for="showYear"> {translate key="issue.year"}</label></div>
			</div>
			<div class="row">
			<div class="col-xs-1"><input class="checkbox-float-right" type="checkbox" name="showTitle" id="showTitle" value="1"{if $showTitle} checked="checked"{/if} /></div>
			<div class="col-xs-11"><label for="showTitle"> {translate key="issue.title"}</label></div>
			</div>
		</div>
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
<div id="access">
<div class="page-header"><h3>{translate key="editor.issues.access"}</h3></div>
<div class="row">
	<div class="col-md-12">
		<div class="label col-md-2">{fieldLabel name="accessStatus" key="editor.issues.accessStatus"}</div>
		<div class="col-md-10"><select name="accessStatus" id="accessStatus" class="selectMenu">{html_options options=$accessOptions selected=$accessStatus}</select></div>
	</div>
	<div class="col-md-12">
		<div class="label col-md-2">{fieldLabel name="openAccessDate" key="editor.issues.accessDate"}</div>
		<div class="col-md-10">
			<input type="checkbox" id="enableOpenAccessDate" name="enableOpenAccessDate" {if $openAccessDate}checked="checked" {/if}onchange="document.getElementById('issue').openAccessDateMonth.disabled=this.checked?false:true;document.getElementById('issue').openAccessDateDay.disabled=this.checked?false:true;document.getElementById('issue').openAccessDateYear.disabled=this.checked?false:true;" />&nbsp;{fieldLabel name="enableOpenAccessDate" key="editor.issues.enableOpenAccessDate"}<br/>
			{if $openAccessDate}
				{html_select_date prefix=openAccessDate time=$openAccessDate end_year="+20" all_extra="class=\"selectMenu\""}
			{else}
				{html_select_date prefix=openAccessDate time=$openAccessDate end_year="+20" all_extra="class=\"selectMenu\" disabled=\"disabled\""}
			{/if}
		</div>
	</div>
</div>
</div>
{/if}

<div class="separator"></div>
<div id="cover">
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
<p class="center margin-top-20"><input type="submit" value="{translate key="common.save"}" class="btn btn-success btn-lg" /> <input type="button" value="{translate key="common.cancel"}" onclick="document.location.href='{url op="index" escape=false}'" class="btn btn-danger btn-lg" /></p>

</form>

{include file="common/footer.tpl"}

