{**
 * templates/submission/metadata/metadata.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2003-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Subtemplate defining the submission metadata table. Non-form implementation.
 *}
<div id="metadata">
<div class="page-header"><h3>{translate key="submission.metadata"}</h3></div>

{if $canEditMetadata}
	<p><a href="{url op="viewMetadata" path=$submission->getId()}" class="action btn btn-default btn-sm"><i class="material-icons icon-inside-button">subject</i> {translate key="submission.editMetadata"}</a></p>
	{call_hook name="Templates::Submission::Metadata::Metadata::AdditionalEditItems"}
{/if}

<div id="authors">
<h4>{translate key="article.authors"}</h4>
	
{foreach name=authors from=$submission->getAuthors() item=author}
<div class="row well">
	<div class="col-md-12">
		<div class="label col-md-2">{translate key="user.name"}</div>
		<div class="col-md-10">
			{assign var=emailString value=$author->getFullName()|concat:" <":$author->getEmail():">"}
			{url|assign:"url" page="user" op="email" redirectUrl=$currentUrl to=$emailString|to_array subject=$submission->getLocalizedTitle()|strip_tags articleId=$submission->getId()}
			{$author->getFullName()|escape} {icon name="mail" url=$url}
		</div>
	</div>
	{if $author->getData('orcid')}
		<div class="col-md-12">
			<div class="label col-md-2">{translate key="user.orcid"}</div>
			<div class="col-md-10"><a href="{$author->getData('orcid')|escape}" target="_blank">{$author->getData('orcid')|escape}</a></div>
		</div>
	{/if}
	{if $author->getUrl()}
		<div class="col-md-12">
			<div class="label col-md-2">{translate key="user.url"}</div>
			<div class="col-md-10"><a href="{$author->getUrl()|escape:"quotes"}">{$author->getUrl()|escape}</a></div>
		</div>
	{/if}
	<div class="col-md-12">
		<div class="label col-md-2">{translate key="user.affiliation"}</div>
		<div class="col-md-10">{$author->getLocalizedAffiliation()|escape|nl2br|default:"&mdash;"}</div>
	</div>
	<div class="col-md-12">
		<div class="label col-md-2">{translate key="common.country"}</div>
		<div class="col-md-10">{$author->getCountryLocalized()|escape|default:"&mdash;"}</div>
	</div>
	{if $currentJournal->getSetting('requireAuthorCompetingInterests')}
		<div class="col-md-12">
			<div class="label col-md-2">
				{url|assign:"competingInterestGuidelinesUrl" page="information" op="competingInterestGuidelines"}
				{translate key="author.competingInterests" competingInterestGuidelinesUrl=$competingInterestGuidelinesUrl}
			</div>
			<div class="col-md-10">{$author->getLocalizedCompetingInterests()|strip_unsafe_html|nl2br|default:"&mdash;"}</div>
		</div>
	{/if}
	<div class="col-md-12">
		<div class="label col-md-2">{translate key="user.biography"}</div>
		<div class="col-md-10">{$author->getLocalizedBiography()|strip_unsafe_html|nl2br|default:"&mdash;"}</div>
	</div>
	{if $author->getPrimaryContact()}
		<div class="col-md-12">
			<div class="label col-md-12 info-text center">{translate key="author.submit.selectPrincipalContact"}</div>
		</div>
	{/if}
</div>
{/foreach}
</div>

<div id="titleAndAbstract">
<h4>{translate key="submission.titleAndAbstract"}</h4>

<div class="row">
	<div class="col-md-12">
		<div class="label col-md-2">{translate key="article.title"}</div>
		<div class="col-md-10">{$submission->getLocalizedTitle()|strip_unsafe_html|default:"&mdash;"}</div>
	</div>

	<div class="col-md-12">
		<div class="label col-md-2">{translate key="article.abstract"}</div>
		<div class="col-md-10">{$submission->getLocalizedAbstract()|strip_unsafe_html|nl2br|default:"&mdash;"}</div>
	</div>
</div>
</div>

<div id="indexing">
<h4>{translate key="submission.indexing"}</h4>
	
<div class="row">
	{if $currentJournal->getSetting('metaDiscipline')}
	<div class="col-md-12">
		<div class="label col-md-2">{translate key="article.discipline"}</div>
		<div class="col-md-10">{$submission->getLocalizedDiscipline()|escape|default:"&mdash;"}</div>
	</div>
	{/if}
	{if $currentJournal->getSetting('metaSubjectClass')}
	<div class="col-md-12">
		<div class="label col-md-2">{translate key="article.subjectClassification"}</div>
		<div class="col-md-10">{$submission->getLocalizedSubjectClass()|escape|default:"&mdash;"}</div>
	</div>
	{/if}
	{if $currentJournal->getSetting('metaSubject')}
		<div class="col-md-12">
			<div class="label col-md-2">{translate key="article.subject"}</div>
			<div class="col-md-10">{$submission->getLocalizedSubject()|escape|default:"&mdash;"}</div>
		</div>
	{/if}
	{if $currentJournal->getSetting('metaCoverage')}
		<div class="col-md-12">
			<div class="label col-md-2">{translate key="article.coverageGeo"}</div>
			<div class="col-md-10">{$submission->getLocalizedCoverageGeo()|escape|default:"&mdash;"}</div>
		</div>
		<div class="col-md-12">
			<div class="label col-md-2">{translate key="article.coverageChron"}</div>
			<div class="col-md-10">{$submission->getLocalizedCoverageChron()|escape|default:"&mdash;"}</div>
		</div>
		<div class="col-md-12">
			<div class="label col-md-2">{translate key="article.coverageSample"}</div>
			<div class="col-md-10">{$submission->getLocalizedCoverageSample()|escape|default:"&mdash;"}</div>
		</div>
	{/if}
	{if $currentJournal->getSetting('metaType')}
		<div class="col-md-12">
			<div class="label col-md-2">{translate key="article.type"}</div>
			<div class="col-md-10">{$submission->getLocalizedType()|escape|default:"&mdash;"}</div>
		</div>
	{/if}
	<div class="col-md-12">
		<div class="label col-md-2">{translate key="article.language"}</div>
		<div class="col-md-10">{$submission->getLanguage()|escape|default:"&mdash;"}</div>
	</div>
</div>
</div>

<div id="supportingAgencies">
<h4>{translate key="submission.supportingAgencies"}</h4>
	
<div class="row">
	<div class="col-md-12">
		<div class="label col-md-2">{translate key="submission.agencies"}</div>
		<div class="col-md-10">{$submission->getLocalizedSponsor()|escape|default:"&mdash;"}</div>
	</div>
</div>
</div>

{call_hook name="Templates::Submission::Metadata::Metadata::AdditionalMetadata"}

{if $currentJournal->getSetting('metaCitations')}
	<div id="citations">
	<h4>{translate key="submission.citations"}</h4>

	<div class="row">
		<div class="col-md-12">
			<div class="label col-md-2">{translate key="submission.citations"}</div>
			<div class="col-md-10">{$submission->getCitations()|strip_unsafe_html|nl2br|default:"&mdash;"}</div>
		</div>
	</div>
	</div>
{/if}

</div><!-- metadata -->

