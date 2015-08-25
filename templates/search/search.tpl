{**
 * templates/search/search.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2003-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * A unified search interface.
 *}
{strip}
{assign var="pageTitle" value="navigation.search"}
{include file="common/header.tpl"}
{/strip}

<script>
	var alternativeTitle = '';
</script>

<div id="search">
	<script type="text/javascript">
		$(function() {ldelim}
			// Attach the form handler.
			$('#searchForm').pkpHandler('$.pkp.pages.search.SearchFormHandler');
		{rdelim});
	</script>
	<form method="post" id="searchForm" action="{url op="search"}">
		<div class="row">
			<div class="col-md-12">
				<div class="input-group">
					{capture assign="queryFilter"}{call_hook name="Templates::Search::SearchResults::FilterInput" filterName="query" filterValue=$query}{/capture}
					{if empty($queryFilter)}
						<input type="text" id="query" name="query" size="40" maxlength="255" value="{$query|escape}" class="textField" />
					{else}
						{$queryFilter}
					{/if}
					<span class="input-group-btn">
						<input type="submit" value="search" class="btn btn-default material-icons search-button-search-window " />
					</span>
				</div>
			</div>
		</div>
		<div class="row margin-top-10">
			<div class="col-md-12"><select name="searchJournal" id="searchJournal" class="selectMenu">{html_options options=$journalOptions selected=$searchJournal}</select></div>
		</div>
		{if $hasActiveFilters}
			<div class="row">
				<div class="col-md-12"><h4>{translate key="search.activeFilters"}</h4></div>
			</div>
			{include file="search/searchFilter.tpl" displayIf="activeFilter" filterName="authors" filterValue=$authors key="search.author"}
			{include file="search/searchFilter.tpl" displayIf="activeFilter" filterName="title" filterValue=$title key="article.title"}
			{include file="search/searchFilter.tpl" displayIf="activeFilter" filterName="abstract" filterValue=$abstract key="search.abstract"}
			{include file="search/searchFilter.tpl" displayIf="activeFilter" filterName="galleyFullText" filterValue=$galleyFullText key="search.fullText"}
			{include file="search/searchFilter.tpl" displayIf="activeFilter" filterName="suppFiles" filterValue=$suppFiles key="article.suppFiles"}
			{include file="search/searchFilter.tpl" displayIf="activeFilter" filterType="date" filterName="dateFrom" filterValue=$dateFrom startYear=$startYear endYear=$endYear key="search.dateFrom"}
			{include file="search/searchFilter.tpl" displayIf="activeFilter" filterType="date" filterName="dateTo" filterValue=$dateTo startYear=$startYear endYear=$endYear key="search.dateTo"}
			{include file="search/searchFilter.tpl" displayIf="activeFilter" filterName="discipline" filterValue=$discipline key="search.discipline"}
			{include file="search/searchFilter.tpl" displayIf="activeFilter" filterName="subject" filterValue=$subject key="search.subject"}
			{include file="search/searchFilter.tpl" displayIf="activeFilter" filterName="type" filterValue=$type key="search.typeMethodApproach"}
			{include file="search/searchFilter.tpl" displayIf="activeFilter" filterName="coverage" filterValue=$coverage key="search.coverage"}
			{include file="search/searchFilter.tpl" displayIf="activeFilter" filterName="indexTerms" filterValue=$indexTerms key="search.indexTermsLong"}
		{/if}
		
		<div class="row"><div class="col-md-12"><hr/></div></div>
		
		<div class="row">
			<div class="col-md-3 on-PC">
				<a class="btn btn-default btn-block" onclick="toogleFilters()"><i class="material-icons icon-advanced-search">expand_more</i> Advanced search</a>
			</div>
			{if $currentJournal}
			<div class="col-md-3">
				<a class="btn btn-default btn-block" href="{url page="search"}/authors"><i class="material-icons icons-search-page">group</i> Index of authors</a>
			</div>
			<div class="col-md-3 margin-top-on-mobile">
				<a class="btn btn-default btn-block" href="{url page="search"}/titles"><i class="material-icons icons-search-page">format_size</i> Index of titles</a>
			</div>
			{/if}
			<div class="col-md-3 margin-top-on-mobile">
				<div id="searchTips" class="modal fade">
				  <div class="modal-dialog">
				  	<div class="modal-content">
					  <div class="modal-header">
			        	<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					    <h3 class="modal-title">Search tips: </h3>
					  </div>
				      <div class="modal-body">
						{capture assign="syntaxInstructions"}{call_hook name="Templates::Search::SearchResults::SyntaxInstructions"}{/capture}
						{if empty($syntaxInstructions)}
							{translate key="search.syntaxInstructions"}
						{else}
							{* Must be properly escaped in the controller as we potentially get HTML here! *}
							{$syntaxInstructions}
						{/if}
					  </div>
				    </div>
				  </div>
				</div>
				<a class="btn btn-default btn-block" data-toggle="modal" data-target="#searchTips"><i class="material-icons icons-search-page">help_outline</i> Search tips</a>
			</div>
			<div class="col-md-3 on-Mobile margin-top-on-mobile">
				<a class="btn btn-default btn-block" onclick="toogleFilters()"><i class="material-icons icon-advanced-search">expand_more</i> Advanced search</a>
			</div>
		</div>
		
		<div id="filtersAdvanceSearch" class="panel panel-default">
		<div class="panel-body">
		{if $hasEmptyFilters}
			{if empty($authors) || empty($title) || empty($abstract) || empty($galleyFullText) || empty($suppFiles)}
				<div class="row">
					<div class="col-md-12">
						<div class="page-header page-header-without-margin-top"><h4>{translate key="search.searchCategories"}</h4></div>
					</div>
				</div>
				{include file="search/searchFilter.tpl" displayIf="emptyFilter" filterName="authors" filterValue=$authors key="search.author"}
				{include file="search/searchFilter.tpl" displayIf="emptyFilter" filterName="title" filterValue=$title key="article.title"}
				{include file="search/searchFilter.tpl" displayIf="emptyFilter" filterName="abstract" filterValue=$abstract key="search.abstract"}
				{include file="search/searchFilter.tpl" displayIf="emptyFilter" filterName="galleyFullText" filterValue=$galleyFullText key="search.fullText"}
				{include file="search/searchFilter.tpl" displayIf="emptyFilter" filterName="suppFiles" filterValue=$suppFiles key="article.suppFiles"}
			{/if}
			{if $dateFrom == '--' || $dateTo == '--'}
				<div class="row">
					<div class="col-md-12">
						<div class="page-header"><h4>{translate key="search.date"}</h4></div>
					</div>
				</div>
				{include file="search/searchFilter.tpl" displayIf="emptyFilter" filterType="date" filterName="dateFrom" filterValue=$dateFrom startYear=$startYear endYear=$endYear key="search.dateFrom"}
				{include file="search/searchFilter.tpl" displayIf="emptyFilter" filterType="date" filterName="dateTo" filterValue=$dateTo startYear=$startYear endYear=$endYear key="search.dateTo"}
			{/if}
			{if empty($discipline) || empty($subject) || empty($type) || empty($coverage)}
				<div class="row">
					<div class="col-md-12">
						<div class="page-header"><h4>{translate key="search.indexTerms"}</h4></div>
					</div>
				</div>
				{include file="search/searchFilter.tpl" displayIf="emptyFilter" filterName="discipline" filterValue=$discipline key="search.discipline"}
				{include file="search/searchFilter.tpl" displayIf="emptyFilter" filterName="subject" filterValue=$subject key="search.subject"}
				{include file="search/searchFilter.tpl" displayIf="emptyFilter" filterName="type" filterValue=$type key="search.typeMethodApproach"}
				{include file="search/searchFilter.tpl" displayIf="emptyFilter" filterName="coverage" filterValue=$coverage key="search.coverage"}
				{include file="search/searchFilter.tpl" displayIf="emptyFilter" filterName="indexTerms" filterValue=$indexTerms key="search.indexTermsLong"}
			{/if}
		{/if}
		</div>
		</div>
		<script>
			var showFilters = false; //Hide them always if javascript enable
		</script>
	</form>
</div>
<br />

{call_hook name="Templates::Search::SearchResults::PreResults"}

{if $currentJournal}
	{assign var=numCols value=3}
{else}
	{assign var=numCols value=4}
{/if}


{iterate from=results item=result}
	<div class="row margin-top-5">
		{assign var=publishedArticle value=$result.publishedArticle}
		{assign var=article value=$result.article}
		{assign var=issue value=$result.issue}
		{assign var=issueAvailable value=$result.issueAvailable}
		{assign var=journal value=$result.journal}
		{assign var=section value=$result.section}
		
		<div class="col-md-12">
			<a href="{url journal=$journal->getPath() page="article" op="view" path=$publishedArticle->getBestArticleId($journal)}" class="file">
				<h4 class="panel-header-without-margin">{$article->getLocalizedTitle()|strip_unsafe_html}</h4>
			</a>
		</div>
	</div>
	
	<div class="row">
		<div class="col-md-12">
			{foreach from=$article->getAuthors() item=authorItem name=authorList}
				{$authorItem->getFullName()|escape}{if !$smarty.foreach.authorList.last},{/if}
			{/foreach}
		</div>
	</div>	
	
	<div class="row">
		<div class="col-md-12">
		{call_hook name="Templates::Search::SearchResults::AdditionalArticleInfo" articleId=$publishedArticle->getId() numCols=$numCols|escape}
		</div>
	</div>
	
	<div class="row">
		<div class="col-xs-6">
			{if $publishedArticle->getAccessStatus() == $smarty.const.ARTICLE_ACCESS_OPEN|| $issueAvailable}
				{assign var=hasAccess value=1}
			{else}
				{assign var=hasAccess value=0}
			{/if}
			{if $hasAccess}
				{foreach from=$publishedArticle->getLocalizedGalleys() item=galley name=galleyList}
					<a class="btn btn-default btn-xs" href="{url journal=$journal->getPath() page="article" op="view" path=$publishedArticle->getBestArticleId($journal)|to_array:$galley->getBestGalleyId($journal)}" class="file">{$galley->getGalleyLabel()|escape}</a>
				{/foreach}
			{/if}
		</div>
		<div class="col-xs-6 align-right">
			{if !$currentJournal}<a class="btn btn-default btn-xs" href="{url journal=$journal->getPath()}">{$journal->getLocalizedTitle()|escape}</a>{/if}
			<a class="hoverize-text btn btn-default btn-xs" href="{url journal=$journal->getPath() page="issue" op="view" path=$issue->getBestIssueId($journal)}">{$issue->getIssueIdentification()|escape}</a>
			{call_hook name="Templates::Search::SearchResults::AdditionalArticleLinks" articleId=$publishedArticle->getId()}
		</div>
	</div>
	<div class="row"><div class="col-md-12"><hr/></div></div>
{/iterate}
{if $results->wasEmpty()}
	<div class="row">
		<div class="col-md-12">
			{if $error}
				{$error|escape}
			{else}
				{translate key="search.noResults"}
			{/if}
		</div>
	</div>
{else}
	<div class="row margin-top-20">
		<div class="col-xs-6 number-results-table">{page_info iterator=$results}</div>
		<div class="col-xs-6 footer-table-numbers align-right">{page_links anchor="results" iterator=$results name="search" query=$query searchJournal=$searchJournal authors=$authors title=$title abstract=$abstract galleyFullText=$galleyFullText suppFiles=$suppFiles discipline=$discipline subject=$subject type=$type coverage=$coverage indexTerms=$indexTerms dateFromMonth=$dateFromMonth dateFromDay=$dateFromDay dateFromYear=$dateFromYear dateToMonth=$dateToMonth dateToDay=$dateToDay dateToYear=$dateToYear orderBy=$orderBy orderDir=$orderDir}</div>
	</div>
{/if}

</div>

{include file="common/footer.tpl"}

