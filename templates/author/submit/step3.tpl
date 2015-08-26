{**
 * templates/author/submit/step3.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2003-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Step 3 of author article submission.
 *
 *}
{assign var="pageTitle" value="author.submit.step3"}
{include file="author/submit/submitHeader.tpl"}

{url|assign:"competingInterestGuidelinesUrl" page="information" op="competingInterestGuidelines"}

<div class="separator"></div>

<form id="submit" method="post" action="{url op="saveSubmit" path=$submitStep}">
<input type="hidden" name="articleId" value="{$articleId|escape}" />
{include file="common/formErrors.tpl"}

{literal}
<script type="text/javascript">
<!--
// Move author up/down
function moveAuthor(dir, authorIndex) {
	var form = document.getElementById('submit');
	form.moveAuthor.value = 1;
	form.moveAuthorDir.value = dir;
	form.moveAuthorIndex.value = authorIndex;
	form.submit();
}
// -->
</script>
{/literal}

{if count($formLocales) > 1}
<div id="locales">
<div class="row">
	<div class="col-md-12">
		<div class="label col-md-2">{fieldLabel name="formLocale" key="form.formLanguage"}</div>
		<div class="col-md-10">
			{url|assign:"submitFormUrl" op="submit" path="3" articleId=$articleId escape=false}
			{* Maintain localized author info across requests *}
			{foreach from=$authors key=authorIndex item=author}
				{if $currentJournal->getSetting('requireAuthorCompetingInterests')}
					{foreach from=$author.competingInterests key="thisLocale" item="thisCompetingInterests"}
						{if $thisLocale != $formLocale}<input type="hidden" name="authors[{$authorIndex|escape}][competingInterests][{$thisLocale|escape}]" value="{$thisCompetingInterests|escape}" />{/if}
					{/foreach}
				{/if}
				{foreach from=$author.biography key="thisLocale" item="thisBiography"}
					{if $thisLocale != $formLocale}<input type="hidden" name="authors[{$authorIndex|escape}][biography][{$thisLocale|escape}]" value="{$thisBiography|escape}" />{/if}
				{/foreach}
				{foreach from=$author.affiliation key="thisLocale" item="thisAffiliation"}
					{if $thisLocale != $formLocale}<input type="hidden" name="authors[{$authorIndex|escape}][affiliation][{$thisLocale|escape}]" value="{$thisAffiliation|escape}" />{/if}
				{/foreach}
			{/foreach}
			{form_language_chooser form="submit" url=$submitFormUrl}
			<span class="instruct">{translate key="form.formLanguage.description"}</span>
		</div>
	</div>
</div>
</div>
{/if}

<div id="authors">
<div class="page-header"><h3>{translate key="article.authors"}</h3></div>
<input type="hidden" name="deletedAuthors" value="{$deletedAuthors|escape}" />
<input type="hidden" name="moveAuthor" value="0" />
<input type="hidden" name="moveAuthorDir" value="" />
<input type="hidden" name="moveAuthorIndex" value="" />

{foreach name=authors from=$authors key=authorIndex item=author}
<input type="hidden" name="authors[{$authorIndex|escape}][authorId]" value="{$author.authorId|escape}" />
<input type="hidden" name="authors[{$authorIndex|escape}][seq]" value="{$authorIndex+1}" />
{if $smarty.foreach.authors.total <= 1}
<input type="hidden" name="primaryContact" value="{$authorIndex|escape}" />
{/if}

<div class="row">
	<div class="col-md-12">
		<div class="label col-md-2">{fieldLabel name="authors-$authorIndex-firstName" required="true" key="user.firstName"}</div>
		<div class="col-md-10"><input type="text" class="textField" name="authors[{$authorIndex|escape}][firstName]" id="authors-{$authorIndex|escape}-firstName" value="{$author.firstName|escape}" size="20" maxlength="40" /></div>
	</div>
	<div class="col-md-12">
		<div class="label col-md-2">{fieldLabel name="authors-$authorIndex-middleName" key="user.middleName"}</div>
		<div class="col-md-10"><input type="text" class="textField" name="authors[{$authorIndex|escape}][middleName]" id="authors-{$authorIndex|escape}-middleName" value="{$author.middleName|escape}" size="20" maxlength="40" /></div>
	</div>
	<div class="col-md-12">
		<div class="label col-md-2">{fieldLabel name="authors-$authorIndex-lastName" required="true" key="user.lastName"}</div>
		<div class="col-md-10"><input type="text" class="textField" name="authors[{$authorIndex|escape}][lastName]" id="authors-{$authorIndex|escape}-lastName" value="{$author.lastName|escape}" size="20" maxlength="90" /></div>
	</div>
	<div class="col-md-12">
		<div class="label col-md-2">{fieldLabel name="authors-$authorIndex-email" required="true" key="user.email"}</div>
		<div class="col-md-10"><input type="text" class="textField" name="authors[{$authorIndex|escape}][email]" id="authors-{$authorIndex|escape}-email" value="{$author.email|escape}" size="30" maxlength="90" /></div>
	</div>
	<div class="col-md-12">
		<div class="label col-md-2">{fieldLabel name="authors-$authorIndex-orcid" key="user.orcid"}</div>
		<div class="col-md-10"><input type="text" class="textField" name="authors[{$authorIndex|escape}][orcid]" id="authors-{$authorIndex|escape}-orcid" value="{$author.orcid|escape}" size="30" maxlength="90" /><br />{translate key="user.orcid.description"}</div>
	</div>
	<div class="col-md-12">
		<div class="label col-md-2">{fieldLabel name="authors-$authorIndex-url" key="user.url"}</div>
		<div class="col-md-10"><input type="text" name="authors[{$authorIndex|escape}][url]" id="authors-{$authorIndex|escape}-url" value="{$author.url|escape}" size="30" maxlength="255" class="textField" /></div>
	</div>
	<div class="col-md-12">
		<div class="label col-md-2">{fieldLabel name="authors-$authorIndex-affiliation" key="user.affiliation"}</div>
		<div class="col-md-10">
			<textarea name="authors[{$authorIndex|escape}][affiliation][{$formLocale|escape}]" class="textArea" id="authors-{$authorIndex|escape}-affiliation" rows="5" cols="40">{$author.affiliation[$formLocale]|escape}</textarea><br/>
			<span class="instruct">{translate key="user.affiliation.description"}</span>
		</div>
	</div>
	<div class="col-md-12">
		<div class="label col-md-2">{fieldLabel name="authors-$authorIndex-country" key="common.country"}</div>
		<div class="col-md-10">
			<select name="authors[{$authorIndex|escape}][country]" id="authors-{$authorIndex|escape}-country" class="selectMenu">
				<option value=""></option>
				{html_options options=$countries selected=$author.country}
			</select>
		</div>
	</div>
	{if $currentJournal->getSetting('requireAuthorCompetingInterests')}
		<div class="col-md-12">
			<div class="label col-md-2">{fieldLabel name="authors-$authorIndex-competingInterests" key="author.competingInterests" competingInterestGuidelinesUrl=$competingInterestGuidelinesUrl}</div>
			<div class="col-md-10"><textarea name="authors[{$authorIndex|escape}][competingInterests][{$formLocale|escape}]" class="textArea" id="authors-{$authorIndex|escape}-competingInterests" rows="5" cols="40">{$author.competingInterests[$formLocale]|escape}</textarea></div>
		</div>
	{/if}{* requireAuthorCompetingInterests *}
	<div class="col-md-12">
		<div class="label col-md-2">{fieldLabel name="authors-$authorIndex-biography" key="user.biography"}<br />{translate key="user.biography.description"}</div>
		<div class="col-md-10"><textarea name="authors[{$authorIndex|escape}][biography][{$formLocale|escape}]" class="textArea" id="authors-{$authorIndex|escape}-biography" rows="5" cols="40">{$author.biography[$formLocale]|escape}</textarea></div>
	</div>
	
	{call_hook name="Templates::Author::Submit::Authors"}
	
	{if $smarty.foreach.authors.total > 1}
	<div class="col-md-12">
		<div class="col-md-12">
			<a href="javascript:moveAuthor('u', '{$authorIndex|escape}')" class="action">&uarr;</a> <a href="javascript:moveAuthor('d', '{$authorIndex|escape}')" class="action">&darr;</a>
			{translate key="author.submit.reorderInstructions"}
		</div>
	</div>
	{/if}
	<div class="col-md-12" class="margin-bottom-20 margin-top-20">
		<div class="row col-md-6">
			<div class="col-xs-1"><input type="radio" name="primaryContact" value="{$authorIndex|escape}"{if $primaryContact == $authorIndex} checked="checked"{/if} /></div>
			<div class="col-xs-11"><label for="primaryContact">{translate key="author.submit.selectPrincipalContact"}</label></div>
		</div>
		<div class="col-md-6">
			<input type="submit" name="delAuthor[{$authorIndex|escape}]" value="{translate key="author.submit.deleteAuthor"}" class="btn btn-danger btn-xs" />
		</div>
	</div>
</div>
{foreachelse}
<input type="hidden" name="authors[0][authorId]" value="0" />
<input type="hidden" name="primaryContact" value="0" />
<input type="hidden" name="authors[0][seq]" value="1" />
<div class="row">
	<div class="col-md-12">
		<div class="label col-md-2">{fieldLabel name="authors-0-firstName" required="true" key="user.firstName"}</div>
		<div class="col-md-10"><input type="text" class="textField" name="authors[0][firstName]" id="authors-0-firstName" size="20" maxlength="40" /></div>
	</div>
	<div class="col-md-12">
		<div class="label col-md-2">{fieldLabel name="authors-0-middleName" key="user.middleName"}</div>
		<div class="col-md-10"><input type="text" class="textField" name="authors[0][middleName]" id="authors-0-middleName" size="20" maxlength="40" /></div>
	</div>
	<div class="col-md-12">
		<div class="label col-md-2">{fieldLabel name="authors-0-lastName" required="true" key="user.lastName"}</div>
		<div class="col-md-10"><input type="text" class="textField" name="authors[0][lastName]" id="authors-0-lastName" size="20" maxlength="90" /></div>
	</div>
	<div class="col-md-12">
		<div class="label col-md-2">{fieldLabel name="authors-0-email" required="true" key="user.email"}</div>
		<div class="col-md-10"><input type="text" class="textField" name="authors[0][email]" id="authors-0-email" size="30" maxlength="90" /></div>
	</div>
	<div class="col-md-12">
		<div class="label col-md-2">{fieldLabel name="authors-0-orcid" key="user.orcid"}</div>
		<div class="col-md-10"><input type="text" class="textField" name="authors[0][orcid]" id="authors-0-orcid" size="30" maxlength="90" /><br />{translate key="user.orcid.description"}</div>
	</div>
	<div class="col-md-12">
		<div class="label col-md-2">{fieldLabel name="authors-0-url" key="user.url"}</div>
		<div class="col-md-10"><input type="text" class="textField" name="authors[0][url]" id="authors-0-url" size="30" maxlength="255" /></div>
	</div>
	<div class="col-md-12">
		<div class="label col-md-2">{fieldLabel name="authors-0-affiliation" key="user.affiliation"}</div>
		<div class="col-md-10">
			<textarea name="authors[0][affiliation][{$formLocale|escape}]" class="textArea" id="authors-0-affiliation" rows="5" cols="40"></textarea><br/>
			<span class="instruct">{translate key="user.affiliation.description"}</span>
		</div>
	</div>
	<div class="col-md-12">
		<div class="label col-md-2">{fieldLabel name="authors-0-country" key="common.country"}</tdiv>
		<div class="col-md-10">
			<select name="authors[0][country]" id="authors-0-country" class="selectMenu">
				<option value=""></option>
				{html_options options=$countries}
			</select>
		</div>
	</div>
	{if $currentJournal->getSetting('requireAuthorCompetingInterests')}
	<div class="col-md-12">
		<div class="label col-md-2">{fieldLabel name="authors-0-competingInterests" key="author.competingInterests" competingInterestGuidelinesUrl=$competingInterestGuidelinesUrl}</div>
		<div class="col-md-10"><textarea name="authors[0][competingInterests][{$formLocale|escape}]" class="textArea" id="authors-0-competingInterests" rows="5" cols="40"></textarea></div>
	</div>
	{/if}
	<div class="col-md-12">
		<div class="label col-md-2">{fieldLabel name="authors-0-biography" key="user.biography"}<br />{translate key="user.biography.description"}</div>
		<div class="col-md-10"><textarea name="authors[0][biography][{$formLocale|escape}]" class="textArea" id="authors-0-biography" rows="5" cols="40"></textarea></div>
	</div>
</div>
{/foreach}

<div class="margin-top-10"><input type="submit" class="button" name="addAuthor" value="{translate key="author.submit.addAuthor"}" /></div>
</div>
<div class="separator"></div>

<div id="titleAndAbstract">
<div class="page-header"><h3>{translate key="submission.titleAndAbstract"}</h3></div>

<div class="row">
	<div class="col-md-12">
		<div class="label col-md-2">{fieldLabel name="title" required="true" key="article.title"}</div>
		<div class="col-md-10"><input type="text" class="textField" name="title[{$formLocale|escape}]" id="title" value="{$title[$formLocale]|escape}" size="60" maxlength="255" /></div>
	</div>
	
	<div class="col-md-12">
		<div class="label col-md-2">{if $section->getAbstractsNotRequired()==0}{fieldLabel name="abstract" key="article.abstract" required="true"}{else}{fieldLabel name="abstract" key="article.abstract"}{/if}</div>
		<div class="col-md-10"><textarea name="abstract[{$formLocale|escape}]" id="abstract" class="textArea" rows="15" cols="60">{$abstract[$formLocale]|escape}</textarea></div>
	</div>
</div>
</div>

<div class="separator"></div>

{if $section->getMetaIndexed()==1}
	<div id="indexing">
		<div class="page-header"><h3>{translate key="submission.indexing"}</h3></div>
		{if $currentJournal->getSetting('metaDiscipline') || $currentJournal->getSetting('metaSubjectClass') || $currentJournal->getSetting('metaSubject') || $currentJournal->getSetting('metaCoverage') || $currentJournal->getSetting('metaType')}<p>{translate key="author.submit.submissionIndexingDescription"}</p>{/if}
		<div class="row">
			{if $currentJournal->getSetting('metaDiscipline')}
			<div class="col-md-12">
				<div class="label col-md-2">{fieldLabel name="discipline" key="article.discipline"}</div>
				<div class="col-md-10">
					<input type="text" class="textField" name="discipline[{$formLocale|escape}]" id="discipline" value="{$discipline[$formLocale]|escape}" size="40" maxlength="255" />
					{if $currentJournal->getLocalizedSetting('metaDisciplineExamples')}<span class="instruct">{$currentJournal->getLocalizedSetting('metaDisciplineExamples')|escape}</span>{/if}
				</div>
			</div>
			{/if}
	
			{if $currentJournal->getSetting('metaSubjectClass')}
			<div class="col-md-12">
				<div class="label col-md-2">{fieldLabel name="subjectClass" key="article.subjectClassification"}</div>
				<div class="col-md-10">
					<input type="text" class="textField" name="subjectClass[{$formLocale|escape}]" id="subjectClass" value="{$subjectClass[$formLocale]|escape}" size="40" maxlength="255" />
					<a href="{$currentJournal->getLocalizedSetting('metaSubjectClassUrl')|escape}" target="_blank">{$currentJournal->getLocalizedSetting('metaSubjectClassTitle')|escape}</a>
				</div>
			</div>
			{/if}
	
			{if $currentJournal->getSetting('metaSubject')}
			<div class="col-md-12">
				<div class="label col-md-2">{fieldLabel name="subject" required="true" key="article.subject"}</div>
				<div class="col-md-10">
					<input type="text" class="textField" name="subject[{$formLocale|escape}]" id="subject" value="{$subject[$formLocale]|escape}" size="40" maxlength="255" />
					{if $currentJournal->getLocalizedSetting('metaSubjectExamples') != ''}<span class="instruct">{$currentJournal->getLocalizedSetting('metaSubjectExamples')|escape}</span>{/if}
				</div>
			</div>
			{/if}
	
			{if $currentJournal->getSetting('metaCoverage')}
			<div class="col-md-12">
				<div class="label col-md-2">{fieldLabel name="coverageGeo" key="article.coverageGeo"}</div>
				<div class="col-md-10">
					<input type="text" class="textField" name="coverageGeo[{$formLocale|escape}]" id="coverageGeo" value="{$coverageGeo[$formLocale]|escape}" size="40" maxlength="255" />
					{if $currentJournal->getLocalizedSetting('metaCoverageGeoExamples')}<span class="instruct">{$currentJournal->getLocalizedSetting('metaCoverageGeoExamples')|escape}</span>{/if}
				</div>
			</div>
			
			<div class="col-md-12">
				<div class="label col-md-2">{fieldLabel name="coverageChron" key="article.coverageChron"}</div>
				<div class="col-md-10">
					<input type="text" class="textField" name="coverageChron[{$formLocale|escape}]" id="coverageChron" value="{$coverageChron[$formLocale]|escape}" size="40" maxlength="255" />
					{if $currentJournal->getLocalizedSetting('metaCoverageChronExamples') != ''}<span class="instruct">{$currentJournal->getLocalizedSetting('metaCoverageChronExamples')|escape}</span>{/if}
				</div>
			</div>

			<div class="col-md-12">
				<div class="label col-md-2">{fieldLabel name="coverageSample" key="article.coverageSample"}</div>
				<div class="col-md-10">
					<input type="text" class="textField" name="coverageSample[{$formLocale|escape}]" id="coverageSample" value="{$coverageSample[$formLocale]|escape}" size="40" maxlength="255" />
					{if $currentJournal->getLocalizedSetting('metaCoverageResearchSampleExamples') != ''}<span class="instruct">{$currentJournal->getLocalizedSetting('metaCoverageResearchSampleExamples')|escape}</span>{/if}
					
				</div>
			</div>
			{/if}
	
			{if $currentJournal->getSetting('metaType')}
			<div class="col-md-12">
				<div class="label col-md-2">{fieldLabel name="type" key="article.type"}</div>
				<div class="col-md-10">
					<input type="text" class="textField" name="type[{$formLocale|escape}]" id="type" value="{$type[$formLocale]|escape}" size="40" maxlength="255" />
					{if $currentJournal->getLocalizedSetting('metaTypeExamples') != ''}<span class="instruct">{$currentJournal->getLocalizedSetting('metaTypeExamples')|escape}</span>{/if}
				</div>
			</div>
			{/if}
	
			<div class="col-md-12">
				<div class="label col-md-2">{fieldLabel name="language" key="article.language"}</div>
				<div class="col-md-10">
					<input type="text" class="textField" name="language" id="language" value="{$language|escape}" size="5" maxlength="10" />
					<span class="instruct">{translate key="author.submit.languageInstructions"}</span>
				</div>
			</div>
		</div>
	</div>
{/if}

<div id="submissionSupportingAgencies">
<div class="page-header"><h3>{translate key="author.submit.submissionSupportingAgencies"}</h3></div>
<p>{translate key="author.submit.submissionSupportingAgenciesDescription"}</p>

<div class="row">
	<div class="col-md-12">
		<div class="label col-md-2">{fieldLabel name="sponsor" key="submission.agencies"}</div>
		<div class="col-md-10"><input type="text" class="textField" name="sponsor[{$formLocale|escape}]" id="sponsor" value="{$sponsor[$formLocale]|escape}" size="60" maxlength="255" /></div>
	</div>
</div>
</div>
<div class="separator"></div>

{call_hook name="Templates::Author::Submit::AdditionalMetadata"}

{if $currentJournal->getSetting('metaCitations')}
<div id="metaCitations">
<div class="page-header"><h3>{translate key="submission.citations"}</h3></div>

<p>{translate key="author.submit.submissionCitations"}</p>

<div class="row">
	<div class="col-md-12">
		<div class="label col-md-2">{fieldLabel name="citations" key="submission.citations"}</div>
		<div class="col-md-10"><textarea name="citations" id="citations" class="textArea" rows="15" cols="60">{$citations|escape}</textarea></div>
	</div>
</div>

<div class="separator"></div>
</div>
{/if}

<div class="row div-buttons-submission"><input type="submit" value="NEXT STEP" class="btn btn-success btn-lg" /> <input type="button" value="{translate key="common.cancel"}" class="btn btn-default" onclick="confirmAction('{url page="author"}', '{translate|escape:"jsparam" key="author.submit.cancelSubmission"}')" /></div>

<p><span class="formRequired">{translate key="common.requiredField"}</span></p>

</form>

{if $scrollToAuthor}
	{literal}
	<script type="text/javascript">
		var authors = document.getElementById('authors');
		authors.scrollIntoView(false);
	</script>
	{/literal}
{/if}

{include file="common/footer.tpl"}

