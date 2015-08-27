{**
 * templates/manager/files/index.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2003-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Files browser.
 *
 *}
{strip}
{assign var="pageTitle" value="manager.filesBrowser"}
{include file="common/header.tpl"}
{/strip}

{assign var=displayDir value="/$currentDir"}
<h3>{translate key="manager.files.indexOfDir" dir=$displayDir|escape}</h3>

{if $currentDir}
<p><a href="{url op="files" path=$parentDir|explode:"/"}" class="btn btn-default"><i class="material-icons icon-inside-button back-icon-file-browser">keyboard_arrow_left</i> {translate key="manager.files.parentDir"}</a></p>
{/if}

<table width="100%" class="listing">
	<tr>
		<td class="headseparator" colspan="6">&nbsp;</td>
	</tr>
	<tr class="heading" valign="bottom">
		<td></td>
		<td width="25%">{translate key="common.fileName"}</td>
		<td width="25%">{translate key="common.type"}</td>
		<td width="25%">{translate key="common.dateModified"}</td>
		<td width="5%">{translate key="common.size"}</td>
		<td width="20%" align="right">{translate key="common.action"}</td>
	</tr>
	<tr>
		<td class="headseparator" colspan="6">&nbsp;</td>
	</tr>
	{foreach from=$files item=file name=files}
	{if $currentDir}
		{assign var=filePath value=$currentDir|concat:"/":$file.name}
	{else}
		{assign var=filePath value=$file.name}
	{/if}
	{assign var=filePath value=$filePath|escape}
	<tr valign="top">
		<td>{if $file.isDir}<i class="material-icons folder-icon">folder</i>{else}<i class="material-icons file-icon">insert_drive_file</i>{/if}</td>
		<td><a href="{url op="files" path=$filePath|explode:"/"}">{$file.name}</a></td>
		<td>{$file.mimetype|escape|default:"&mdash;"}</td>
		<td>{$file.mtime|escape|date_format:$datetimeFormatShort}</td>
		<td>{$file.size|escape|default:"&mdash;"}</td>
		<td align="right" class="nowrap">
			{if !$file.isDir}
				<a href="{url op="files" path=$filePath|explode:"/" download=1}" class="btn btn-default btn-xs"><i class="material-icons icon-inside-button">get_app</i> {translate key="common.download"}</a>
			{/if}
			<a href="{url op="fileDelete" path=$filePath|explode:"/"}" onclick="return confirm('{translate|escape:"jsparam" key="manager.files.confirmDelete"}')" class="btn btn-danger btn-xs"><i class="material-icons icon-inside-button">delete</i> {translate key="common.delete"}</a>
		</td>
	</tr>
	<tr>
		<td colspan="6" class="{if $smarty.foreach.files.last}end{/if}separator">&nbsp;</td>
	</tr>
{foreachelse}
	<tr>
		<td colspan="6" class="nodata">{translate key="manager.files.emptyDir"}</td>
	</tr>
	<tr>
		<td colspan="6" class="endseparator">&nbsp;</td>
	</tr>
{/foreach}
</table>


<form method="post" action="{url op="fileUpload" path=$currentDir|explode:"/"}" enctype="multipart/form-data">
	<input type="file" size="20" name="file" class="uploadField" />
	<input type="submit" value="{translate key="manager.files.uploadFile"}" class="button" />
</form>


<div class="row margin-top-10">
<form method="post" action="{url op="fileMakeDir" path=$currentDir|explode:"/"}" enctype="multipart/form-data">
	<div class="col-xs-12 col-sm-10 col-md-8 col-lg-6">
		<div class="input-group">
			<input type="text" size="20" maxlength="255" name="dirName" class="textField" />
			<span class="input-group-btn"><input type="submit" value="{translate key="manager.files.createDir"}" class="btn btn-default" /></span>
		</div>
	</div>
</form>
</div>

<p class="margin-top-10">{translate key="manager.files.note"}</p>

{include file="common/footer.tpl"}

