{**
 * templates/common/navbar.tpl
 *
 * Copyright (c) 2013-2014 Simon Fraser University Library
 * Copyright (c) 2003-2014 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Navigation Bar
 *
 *}
<div id="navbar">
	<ul class="main-menu">
		<li {if $requestedPage eq 'index' or $requestedPage eq '' or $requestedPage eq 'search' or $requestedPage eq 'issue'}class="active"{/if} id="read"><a href="{url page="index"}">Read</a>
			<ul>
				<li class="first{if preg_match("/search(\/index)*$/", $currentUrl)} active{/if}" id="search"><a href="{url page="search"}">{translate key="navigation.search"}</a></li>
				{if $currentJournal && $currentJournal->getSetting('publishingMode') != $smarty.const.PUBLISHING_MODE_NONE}
				<!-- Only display search by ... if we are inside a journal -->
					<li class="{if $currentUrl|strstr:"issue/archive"}active{/if}" id="by-volume"><a href="{url page="issue" op="archive"}">By Volume</a></li>
					<li class="{if $currentUrl|strstr:"search/authors"}active{/if}" id="by-author"><a href="{url page="search" op="authors"}">By Author</a></li>
					<li class="last {if $currentUrl|strstr:"search/titles"} active{/if}" id="by-title"><a href="{url page="search" op="titles"}">By Title</a></li>
				{/if}
			</ul>
		</li>
		<li id="contribute"><a href="#">Contribute</a>
			<ul>
				<li class="first" id="unknown"><a href="#">Dummy 1</a></li>
				<li class="last" id="unknown"><a href="#">Dummy 2</a></li>
			</ul>
		</li>
	</ul>
</div>
