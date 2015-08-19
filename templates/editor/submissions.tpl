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
{url|assign:"currentUrl" page="editor"}
{include file="common/header.tpl"}
{/strip}
{/strip}

<script>
	var alternativeTitle = '<h2>{translate key="article.submissions"}</h2>';
</script>

<ul class="nav nav-tabs nav-justified">
	<li role="presentation" {if $pageToDisplay == "submissionsUnassigned"}class="active"{/if}><a href="{url op="submissions" path="submissionsUnassigned"}">{translate key="common.queue.short.submissionsUnassigned"}</a></li>
	<li role="presentation" {if $pageToDisplay == "submissionsInReview"}class="active"{/if}><a href="{url op="submissions" path="submissionsInReview"}">{translate key="common.queue.short.submissionsInReview"}</a></li>
	<li role="presentation" {if $pageToDisplay == "submissionsInEditing"}class="active"{/if}><a href="{url op="submissions" path="submissionsInEditing"}">{translate key="common.queue.short.submissionsInEditing"}</a></li>
	<li role="presentation" {if $pageToDisplay == "submissionsArchives"}class="active"{/if}><a href="{url op="submissions" path="submissionsArchives"}">{translate key="common.queue.short.submissionsArchives"}</a></li>
	{call_hook name="Templates::Editor::Index::Submissions"}
</div>

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

<div class="col-md-12 well">
<form method="post" id="submit" action="{url op="submissions" path=$pageToDisplay}">
	<div class="row">
		<div class="col-md-2 label-search-editor">{translate key="editor.submissions.assignedTo"}</div>
		<div class="col-md-3">
			<select name="filterEditor" size="1" class="selectMenu">
				{html_options options=$editorOptions selected=$filterEditor}
			</select>
		</div>
		<div class="col-md-2 center label-search-editor">{translate key="editor.submissions.inSection"}</div>
		<div class="col-md-5"><select name="filterSection" size="1" class="selectMenu">{html_options options=$sectionOptions selected=$filterSection}</select></div>
	</div>
	<div class="row col-md-12 margin-minus-10-top-bottom"><hr></div>
	{if $section}<input type="hidden" name="section" value="{$section|escape:"quotes"}"/>{/if}
	<input type="hidden" name="sort" value="id"/>
	<input type="hidden" name="sortDirection" value="ASC"/>
	<div class="row">
		<div class="col-md-2">
			<select name="searchField" size="1">
				{html_options_translate options=$fieldOptions selected=$searchField}
			</select>
		</div>
		<div class="col-md-1 remove-on-mobile center"><i class="material-icons">forward</i></div>
		<div class="col-md-2">
			<select name="searchMatch" size="1">
				<option value="contains"{if $searchMatch == 'contains'} selected="selected"{/if}>{translate key="form.contains"}</option>
				<option value="is"{if $searchMatch == 'is'} selected="selected"{/if}>{translate key="form.is"}</option>
				<option value="startsWith"{if $searchMatch == 'startsWith'} selected="selected"{/if}>{translate key="form.startsWith"}</option>
			</select>
		</div>
		<div class="col-md-1 remove-on-mobile center"><i class="material-icons">forward</i></div>
		<div class="col-md-6" >
			<input type="text" size="15" name="search" value="{$search|escape}" />
		</div>
	</div>
	<div class="row col-md-12 margin-minus-10-top-bottom"><hr></div>
	<div class="row">
		<div class="col-md-3">
			<select name="dateSearchField" size="1">
				{html_options_translate options=$dateFieldOptions selected=$dateSearchField}
			</select>
		</div>
		<div class="col-md-2 text-search-editor">{translate key="common.between"}</div>
		<div class="col-md-3">
			<div class="change-input-date">
				{html_select_date prefix="dateFrom" time=$dateFrom all_extra="class=\"selectMenu\"" year_empty="" month_empty="" day_empty="" start_year="-5" end_year="+1"}
			</div>
			<input type="text" value="" class="display-none"/>
		</div>
		<div class="col-md-1 text-search-editor">{translate key="common.and"}</div>
		<div class="col-md-3">
			<div class="change-input-date">
				{html_select_date prefix="dateTo" time=$dateTo all_extra="class=\"selectMenu\"" year_empty="" month_empty="" day_empty="" start_year="-5" end_year="+1"}
			</div>
			<input type="text" value="" class="display-none"/>
		</div>
		<input type="hidden" name="dateToHour" value="23" />
		<input type="hidden" name="dateToMinute" value="59" />
		<input type="hidden" name="dateToSecond" value="59" />
	</div>
	<div class="col-md-3 col-md-offset-5" >
		<input type="submit" value="{translate key="common.search"}" class="btn btn-success btn-lg btn-block margin-top-10" />
	</div>
</form>
</div>

<div class="clearfix"></div>

{include file="editor/$pageToDisplay.tpl"}

{include file="common/footer.tpl"}

