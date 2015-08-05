{**
 * templates/editor/submissions.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2003-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Editor submissions page(s).
 *
 *}
{strip}
{strip}
{assign var="pageTitle" value="common.queue.long.$pageToDisplay"}
{assign var="noTitle" value="true"}
{url|assign:"currentUrl" page="editor"}
{include file="common/header.tpl"}
{/strip}
{/strip}

<script>
	var alternativeTitle = '<h3>{translate key="article.submissions"}...</h3>';
</script>

<div class="btn-group add-justified" role"group">
	<a class="btn-group" role="group" href="{url op="submissions" path="submissionsUnassigned"}"><button class="btn btn-primary btn-lg {if $pageToDisplay == "submissionsUnassigned"}active{/if}">{translate key="common.queue.short.submissionsUnassigned"}</button></a>
	<a class="btn-group" role="group" href="{url op="submissions" path="submissionsInReview"}"><button class="btn btn-primary btn-lg {if $pageToDisplay == "submissionsInReview"}active{/if}">{translate key="common.queue.short.submissionsInReview"}</button></a>
	<a class="btn-group" role="group" href="{url op="submissions" path="submissionsInEditing"}"><button class="btn btn-primary btn-lg {if $pageToDisplay == "submissionsInEditing"}active{/if}">{translate key="common.queue.short.submissionsInEditing"}</button></a>
	<a class="btn-group" role="group" href="{url op="submissions" path="submissionsArchives"}"><button class="btn btn-primary btn-lg {if $pageToDisplay == "submissionsUnassigned"}active{/if}">{translate key="common.queue.short.submissionsArchives"}</button></a>
	{call_hook name="Templates::Editor::Index::Submissions"}
</div>

<div class="separator">&nbsp;</div>

&nbsp;<br />

{if !$dateFrom}
{assign var="dateFrom" value="--"}
{/if}

{if !$dateTo}
{assign var="dateTo" value="--"}
{/if}

<script type="text/javascript">
{literal}
<!--
function sortSearch(heading, direction) {
	var submitForm = document.getElementById('submit');
	submitForm.sort.value = heading;
	submitForm.sortDirection.value = direction;
	submitForm.submit();
}
// -->
{/literal}
</script>

<form method="post" id="submit" action="{url op="submissions" path=$pageToDisplay}">
	<div class="col-md-12">
		<div class="col-md-2" style="padding-top: 5px;font-weight: bold;">{translate key="editor.submissions.assignedTo"}</div>
		<div class="col-md-3">
			<select name="filterEditor" size="1" class="selectMenu">
				{html_options options=$editorOptions selected=$filterEditor}
			</select>
		</div>
		<div class="col-md-2" style="padding-top: 5px;font-weight: bold;">{translate key="editor.submissions.inSection"}</div>
		<div class="col-md-5"><select name="filterSection" size="1" class="selectMenu">{html_options options=$sectionOptions selected=$filterSection}</select></div>
	</div>
	<div class="row col-md-12" style="margin-top: -10px;margin-bottom: -10px;"><hr></div>
	{if $section}<input type="hidden" name="section" value="{$section|escape:"quotes"}"/>{/if}
	<input type="hidden" name="sort" value="id"/>
	<input type="hidden" name="sortDirection" value="ASC"/>
	<div class="col-md-12">
		<div class="col-md-3">
			<select name="searchField" size="1">
				{html_options_translate options=$fieldOptions selected=$searchField}
			</select>
		</div>
		<div class="col-md-1 remove-on-mobile"><i class="material-icons">forward</i></div>
		<div class="col-md-3">
			<select name="searchMatch" size="1">
				<option value="contains"{if $searchMatch == 'contains'} selected="selected"{/if}>{translate key="form.contains"}</option>
				<option value="is"{if $searchMatch == 'is'} selected="selected"{/if}>{translate key="form.is"}</option>
				<option value="startsWith"{if $searchMatch == 'startsWith'} selected="selected"{/if}>{translate key="form.startsWith"}</option>
			</select>
		</div>
		<div class="col-md-1 remove-on-mobile"><i class="material-icons">forward</i></div>
		<div class="col-md-4" >
			<input type="text" size="15" name="search" value="{$search|escape}" />
		</div>
	</div>
	<div class="row col-md-12" style="margin-top: -10px;margin-bottom: -10px;"><hr></div>
	<div class="col-md-12">
		<div class="col-md-3">
			<select name="dateSearchField" size="1">
				{html_options_translate options=$dateFieldOptions selected=$dateSearchField}
			</select>
		</div>
		<div class="col-md-2">{translate key="common.between"}</div>
		<div class="col-md-3">
			<div class="change-input-date">
				{html_select_date prefix="dateFrom" time=$dateFrom all_extra="class=\"selectMenu\"" year_empty="" month_empty="" day_empty="" start_year="-5" end_year="+1"}
			</div>
			<input type="date" name="date" id="date" value="" style="display:none"/>
		</div>
		<div class="col-md-1">{translate key="common.and"}</div>
		<div class="col-md-3">
			<div class="change-input-date">
				{html_select_date prefix="dateTo" time=$dateTo all_extra="class=\"selectMenu\"" year_empty="" month_empty="" day_empty="" start_year="-5" end_year="+1"}
			</div>
			<input type="date" name="date" id="date" value="" style="display:none"/>
		</div>
		<input type="hidden" name="dateToHour" value="23" />
		<input type="hidden" name="dateToMinute" value="59" />
		<input type="hidden" name="dateToSecond" value="59" />
	</div>
	<div class="col-md-12" style="height:60px">
		<input type="submit" value="{translate key="common.search"}" class="btn btn-success btn-lg" style="float:right; margin-right:15%; margin-top:10px;" />
	</div>
</form>
&nbsp;

{include file="editor/$pageToDisplay.tpl"}

{if ($pageToDisplay == "submissionsInReview")}
<br />
<div id="notes">
<h4>{translate key="common.notes"}</h4>
{translate key="editor.submissionReview.notes"}
</div>
{elseif ($pageToDisplay == "submissionsInEditing")}
<br />
<div id="notes">
<h4>{translate key="common.notes"}</h4>
{translate key="editor.submissionEditing.notes"}
</div>
{/if}

{include file="common/footer.tpl"}

