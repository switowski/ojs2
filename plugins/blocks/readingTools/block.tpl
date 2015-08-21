{**
 * plugins/blocks/readingTools/block.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2003-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Keyword cloud block plugin
 *
 *}

{if $journalRt && $journalRt->getEnabled()}

<div class="block" id="sidebarRTArticleTools">

	{if $journalRt->getAbstract() && $galley && $article->getLocalizedAbstract()}
		<div>
			<a href="{url page="article" op="view" path=$articleId}" target="_parent" class="btn btn-default btn-block"><img class="icon-article-tools" src="{$baseUrl}/plugins/blocks/readingTools/icons/abstract.png" class="articleToolIcon" alt="" /> {translate key="article.abstract"}</a>
		</div>
	{/if}
	{if $journalRt->getPrinterFriendly()}
		<div>
			<a href="{if !$galley || $galley->isHtmlGalley()}javascript:openRTWindow('{url page="rt" op="printerFriendly" path=$articleId|to_array:$galleyId}');{else}{url page="article" op="download" path=$articleId|to_array:$galleyId}{/if}" class="btn btn-default btn-block"><img class="icon-article-tools" src="{$baseUrl}/plugins/blocks/readingTools/icons/printArticle.png" class="articleToolIcon" alt="" /> {translate key="plugins.block.readingTools.printThisArticle"}</a>
		</div>
	{/if}
	{if $journalRt->getViewMetadata()}
		<div>
			<a href="javascript:openRTWindow('{url page="rt" op="metadata" path=$articleId|to_array:$galleyId}');" class="btn btn-default btn-block"><img class="icon-article-tools" src="{$baseUrl}/plugins/blocks/readingTools/icons/metadata.png" class="articleToolIcon" alt=""/> {translate key="rt.viewMetadata"}</a>
		</div>
	{/if}
	{if $journalRt->getCaptureCite()}
		<div>
			<a href="javascript:openRTWindow('{url page="rt" op="captureCite" path=$articleId|to_array:$galleyId}');" class="btn btn-default btn-block">
				<img class="icon-article-tools" src="{$baseUrl}/plugins/blocks/readingTools/icons/citeArticle.png" class="articleToolIcon" alt=""/> 
				{translate key="rt.captureCite"}
			</a>
		</div>
	{/if}
	{if $journalRt->getSupplementaryFiles() && is_a($article, 'PublishedArticle') && $article->getSuppFiles()}
		<div>
			 <a href="javascript:openRTWindow('{url page="rt" op="suppFiles" path=$articleId|to_array:$galleyId}');" class="btn btn-default btn-block">
			 	<img class="icon-article-tools" src="{$baseUrl}/plugins/blocks/readingTools/icons/suppFiles.png" class="articleToolIcon" alt=""/>
		 		{translate key="rt.suppFiles"}
	 		</a>
		</div>
	{/if}
	{if $journalRt->getFindingReferences()}
		<div>
			<a href="javascript:openRTWindow('{url page="rt" op="findingReferences" path=$article->getId()|to_array:$galleyId}');" class="btn btn-default btn-block"><img class="icon-article-tools" src="{$baseUrl}/plugins/blocks/readingTools/icons/findingReferences.png" class="articleToolIcon" alt=""/> {translate key="rt.findingReferences"}</a>
		</div>
	{/if}
	{if $journalRt->getViewReviewPolicy()}
		<div>
			<a href="{url page="about" op="editorialPolicies" anchor="peerReviewProcess"}" target="_parent" class="btn btn-default btn-block"><img class="icon-article-tools" src="{$baseUrl}/plugins/blocks/readingTools/icons/editorialPolicies.png" class="articleToolIcon" alt=""/> {translate key="rt.reviewPolicy"}</a>
		</div>
	{/if}
	{if $journalRt->getEmailOthers()}
		<div>
			{if $isUserLoggedIn}
				<a href="javascript:openRTWindow('{url page="rt" op="emailColleague" path=$articleId|to_array:$galleyId}');" class="btn btn-default btn-block">
					<img class="icon-article-tools" src="{$baseUrl}/plugins/blocks/readingTools/icons/emailArticle.png" class="articleToolIcon" alt=""/>
					{translate key="plugins.block.readingTools.emailThisArticle"}
				</a>
			{/if}
		</div>
	{/if}
	{if $journalRt->getEmailAuthor()}
		<div>
			{if $isUserLoggedIn}
				<a href="javascript:openRTWindow('{url page="rt" op="emailAuthor" path=$articleId|to_array:$galleyId}');" class="btn btn-default btn-block">
					<img class="icon-article-tools" src="{$baseUrl}/plugins/blocks/readingTools/icons/emailArticle.png" class="articleToolIcon" alt=""/>
					{translate key="rt.emailAuthor"}
				</a>
			{/if}
		</div>
	{/if}
	{if $enableComments}
		<div>
			{if not $postingLoginRequired}
				<a href="{url page="comment" op="add" path=$article->getId()|to_array:$galleyId}" class="btn btn-default btn-block">
					<img class="icon-article-tools" src="{$baseUrl}/plugins/blocks/readingTools/icons/postComment.png" class="articleToolIcon" alt=""/>
					{translate key="plugins.block.readingTools.postComment"}
				</a>
			{/if}
		</div>
	{/if}
</div>
{/if}
