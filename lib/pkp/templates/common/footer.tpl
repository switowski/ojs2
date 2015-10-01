{**
 * templates/common/footer.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2000-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Common site footer.
 *
 *}

		{if $displayCreativeCommons}
			{translate key="common.ccLicense"}
		{/if}
		{if $pageFooter}
			<div id="pageFooter">{$pageFooter}</div>
		{/if}
		{call_hook name="Templates::Common::Footer::PageFooter"}
 		<div>
			<a href="{url journal="index"}">CERN Publishing</a>
			{if $currentJournal}&nbsp;|&nbsp;&nbsp;<a href="{url page="about"}/contact">Contact</a>{/if}
		</div>
		<div>
			{translate key="article.language"}:
			<a href="{url|escape:"javascript" page="user" op="setLocale" path="en_US" source=$smarty.server.REQUEST_URI escape=false}">EN</a>&nbsp;&nbsp;|&nbsp;
			<a href="{url|escape:"javascript" page="user" op="setLocale" path="fr_FR" source=$smarty.server.REQUEST_URI escape=false}">FR</a>
		</div>
	</div>
	<div class="col-md-3 second-col-footer">
		<a href="http://cern.ch" class="btn"><img class="cern-logo" src="/public/cern-logo-blue.png" alt="CERN Logo"/></a>
	</div>
</div> <!-- row -->
<div class="row ojsFooterLink"><div class="col-md-12"><a href="http://pkp.sfu.ca/ojs/">CERN Publishing website is powered by Open Journal Systems</a></div></div>
</div><!-- text footer -->
</div><!-- footer -->


{get_debug_info}
{if $enableDebugStats}{include file=$pqpTemplate}{/if}

</body>
</html>
