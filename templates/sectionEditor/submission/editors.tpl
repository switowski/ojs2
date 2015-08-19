{**
 * templates/sectionEditor/submission/editors.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2003-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Subtemplate defining the submission editors table.
 *
 *}
<div id="editors">
<div class="page-header"><h3>{translate key="user.role.editors"}</h3></Div>
<form action="{url page="editor" op="setEditorFlags"}" method="post">
<input type="hidden" name="articleId" value="{$submission->getId()}"/>
<table width="100%" class="listing table table-striped table-condensed">
<thead>
	<tr class="heading" valign="bottom">
		<td width="{if $isEditor}20%{else}25%{/if}">&nbsp;</td>
		<td width="30%">&nbsp;</td>
		<td width="10%">{translate key="submission.review"}</td>
		<td width="10%">{translate key="submission.editing"}</td>
		<td width="{if $isEditor}20%{else}25%{/if}">{translate key="submission.request"}</td>
		{if $isEditor}<td width="10%">{translate key="common.action"}</td>{/if}
	</tr>
</thead>
<tbody>
	{assign var=editAssignments value=$submission->getEditAssignments()}
	{foreach from=$editAssignments item=editAssignment name=editAssignments}
	{if $editAssignment->getEditorId() == $userId}
		{assign var=selfAssigned value=1}
	{/if}
		<tr valign="top">
			<td>{if $editAssignment->getIsEditor()}{translate key="user.role.editor"}{else}{translate key="user.role.sectionEditor"}{/if}</td>
			<td>
				{assign var=emailString value=$editAssignment->getEditorFullName()|concat:" <":$editAssignment->getEditorEmail():">"}
				{url|assign:"url" page="user" op="email" redirectUrl=$currentUrl to=$emailString|to_array subject=$submission->getLocalizedTitle|strip_tags articleId=$submission->getId()}
				{$editAssignment->getEditorFullName()|escape} {icon name="mail" url=$url}
			</td>
			<td>
				&nbsp;&nbsp;<input
					type="checkbox"
					name="canReview-{$editAssignment->getEditId()}"
					{if $editAssignment->getIsEditor()}
						checked="checked"
						disabled="disabled"
					{else}
						{if $editAssignment->getCanReview()} checked="checked"{/if}
						{if !$isEditor}disabled="disabled"{/if}
					{/if}
				/>
			</td>
			<td>
				&nbsp;&nbsp;<input
					type="checkbox"
					name="canEdit-{$editAssignment->getEditId()}"
					{if $editAssignment->getIsEditor()}
						checked="checked"
						disabled="disabled"
					{else}
						{if $editAssignment->getCanEdit()} checked="checked"{/if}
						{if !$isEditor}disabled="disabled"{/if}
					{/if}
				/>
			</td>
			<td>{if $editAssignment->getDateNotified()}{$editAssignment->getDateNotified()|date_format:$dateFormatShort}{else}&mdash;{/if}</td>
			{if $isEditor}
				<td><a onclick="return confirm('Do you really want to remove it?')" href="{url page="editor" op="deleteEditAssignment" path=$editAssignment->getEditId()}" class="action btn btn-xs btn-default" style="min-width:70px"><i class="material-icons icon-inside-button">delete</i> {translate key="common.delete"}</a></td>
			{/if}
		</tr>
	{foreachelse}
		<tr><td colspan="{if $isEditor}6{else}5{/if}" class="nodata">{translate key="common.noneAssigned"}</td></tr>
	{/foreach}
</tbody>
</table>

<div class="row">
{if $isEditor}
	<div class="col-md-2">
		<input type="submit" class="button defaultButton" value="{translate key="common.record"}"/>
	</div>
	<div class="col-md-8">
		<a href="{url page="editor" op="assignEditor" path="sectionEditor" articleId=$submission->getId()}" class="action btn btn-default btn-sm">{translate key="editor.article.assignSectionEditor"}</a>
		<a href="{url page="editor" op="assignEditor" path="editor" articleId=$submission->getId()}" class="action btn btn-default btn-sm">{translate key="editor.article.assignEditor"}</a>
		{if !$selfAssigned}<a href="{url page="editor" op="assignEditor" path="editor" editorId=$userId articleId=$submission->getId()}" class="action btn btn-default btn-sm">{translate key="common.addSelf"}</a>{/if}
	</div>
{/if}
</div>
</form>
</div>

