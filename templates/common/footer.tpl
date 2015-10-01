{**
 * templates/common/footer.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2003-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Common site footer.
 *
 *}
<div class="clearfix"></div>
</div>
</div><!-- content -->
</div><!-- main -->
</div><!-- body -->
</div><!-- container -->
<div class="footer jumbotron">
	<div class="text-footer">
		<div class="row">
			<div class="col-md-9 first-col-footer">
			{strip}
			{if $pageFooter=='' && $currentJournal}
				{if $currentJournal && $currentJournal->getSetting('onlineIssn')}
					{assign var=issn value=$currentJournal->getSetting('onlineIssn')}
				{elseif $currentJournal && $currentJournal->getSetting('printIssn')}
					{assign var=issn value=$currentJournal->getSetting('printIssn')}
				{/if}
				{if $issn}
					{translate|assign:"issnText" key="journal.issn"}
					{assign var=pageFooter value="$issnText: $issn"}
				{/if}
			{/if}
			{include file="core:common/footer.tpl"}
			{/strip}