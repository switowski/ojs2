{**
 * templates/user/index.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2003-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * User index.
 *
 *}
{strip}
{assign var="pageTitle" value="user.userHome"}
{include file="common/header.tpl"}
{/strip}

{if $isSiteAdmin}
	{assign var="hasRole" value=1}
	<a href="{url journal="index" page=$isSiteAdmin->getRolePath()}" class="btn btn-sm btn-default">{translate key=$isSiteAdmin->getRoleName()}</a>
	{call_hook name="Templates::User::Index::Site"}
{/if}

<div id="myJournals">

{foreach from=$userJournals item=journal}
	<div id="journal-{$journal->getPath()|escape}" class="col-md-10">
	{assign var="hasRole" value=1}
	{if !$currentJournal}<h3><a href="{url journal=$journal->getPath() page="user"}">{$journal->getLocalizedTitle()|escape}</a></h3>
	{else}<h3>{$journal->getLocalizedTitle()|escape}</h3>{/if}
	{assign var="journalId" value=$journal->getId()}
	{assign var="journalPath" value=$journal->getPath()}
	
		{if $isValid.JournalManager.$journalId}
			<div class="col-md-10">
				<a href="{url journal=$journalPath page="manager"}" class="btn btn-sm btn-default">{translate key="user.role.manager"}</a>
				{if $setupIncomplete.$journalId}<a href="{url journal=$journalPath page="manager" op="setup" path="1"}" class="btn btn-sm btn-default">{translate key="manager.setup"}</a>{/if}
			</div>
		{/if}
		{if $isValid.SubscriptionManager.$journalId}
			<div class="col-md-10"> 
				<a href="{url journal=$journalPath page="subscriptionManager"}" class="btn btn-sm btn-default">{translate key="user.role.subscriptionManager"}</a>
			</div>
		{/if}
		
		{* AUTHORS *}
		{if $isValid.Author.$journalId}
			{assign var="authorSubmissionsCount" value=$submissionsCount.Author.$journalId}
			<div class="col-md-4 equilibrium ">
				<h4><a href="{url journal=$journalPath page="author"}">{translate key="user.role.author"}</a></h4>
				<div class="list-group">
					{if $authorSubmissionsCount[0]}
						<a href="{url journal=$journalPath page="author"}" class="list-group-item">{translate key="common.queue.short.active"}<span class="badge">{$authorSubmissionsCount[0]}</span></a>
					{else}<span class="disabled list-group-item">{translate key="common.queue.short.active"}<span class="badge">0</span></span>{/if}
					
					{* This is for all non-pending items*}
					{if $authorSubmissionsCount[1]}
						<a href="{url journal=$journalPath path="completed" page="author"}" class="list-group-item">{translate key="common.queue.short.completed"} <span class="badge">{$authorSubmissionsCount[1]}</span></a>
					{else}<span class="disabled list-group-item">{translate key="common.queue.short.completed"}<span class="badge">0</span></span>{/if}
				</div>
				<div class="list-group">
					<a href="{url journal=$journalPath page="author" op="submit"}" class="btn btn-default btn-block">{translate key="author.submit"}</a>
				</div>
			</div>
		{/if}
		
		{* REVIEWERS *}
		{if $isValid.Reviewer.$journalId}
			{assign var="reviewerSubmissionsCount" value=$submissionsCount.Reviewer.$journalId}
			<div class="col-md-4 equilibrium ">
				<h4><a href="{url journal=$journalPath page="reviewer"}">{translate key="user.role.reviewer"}</a></h4>
				<div class="list-group">
					{if $reviewerSubmissionsCount[0]}
						<a href="{url journal=$journalPath page="reviewer"}" class="list-group-item">{translate key="common.queue.short.active"} <span class="badge">{$reviewerSubmissionsCount[0]}</span></a>
					{else}<span class="disabled list-group-item">{translate key="common.queue.short.active"} <span class="badge">{$reviewerSubmissionsCount[0]}</span></span>{/if}
					{if $reviewerSubmissionsCount[1]}
						<a href="{url journal=$journalPath page="reviewer" path="completed"}" class="list-group-item">{translate key="common.queue.short.completed"} <span class="badge">{$reviewerSubmissionsCount[1]}</span></a>
					{else}<span class="disabled list-group-item">{translate key="common.queue.short.completed"} <span class="badge">{$reviewerSubmissionsCount[1]}</span></span>{/if}
				</div>
			</div>
		{/if}
		
		{* EDITORS *}
		{if $isValid.Editor.$journalId}
			<div class="col-md-4 equilibrium ">
				{assign var="editorSubmissionsCount" value=$submissionsCount.Editor.$journalId}
				<h4><a href="{url journal=$journalPath page="editor"}">{translate key="user.role.editor"}</a></h4>
				<div class="list-group">
					{if $editorSubmissionsCount[0]}
							<a href="{url journal=$journalPath page="editor" op="submissions" path="submissionsUnassigned"}" class="list-group-item">{translate key="common.queue.short.submissionsUnassigned"}<span class="badge">{$editorSubmissionsCount[0]}</span></a>
					{else}<span class="disabled list-group-item">{translate key="common.queue.short.submissionsUnassigned"} <span class="badge">0</span></span>{/if}
					{if $editorSubmissionsCount[1]}
							<a href="{url journal=$journalPath page="editor" op="submissions" path="submissionsInReview"}" class="list-group-item">{translate key="common.queue.short.submissionsInReview"}<span class="badge">{$editorSubmissionsCount[1]}</span></a>
					{else}<span class="disabled list-group-item">{translate key="common.queue.short.submissionsInReview"} <span class="badge">0</span></span>{/if}
					{if $editorSubmissionsCount[2]}
							<a href="{url journal=$journalPath page="editor" op="submissions" path="submissionsInEditing"}" class="list-group-item">{translate key="common.queue.short.submissionsInEditing"}<span class="badge">{$editorSubmissionsCount[2]}</span></a>
					{else}<span class="disabled list-group-item">{translate key="common.queue.short.submissionsInEditing"} <span class="badge">0</span></span>{/if}
					<a href="{url journal=$journalPath page="editor" op="submissions" path="submissionsArchives"}" class="list-group-item">{translate key="common.queue.short.submissionsArchives"}</a>
				</div>
				<div class="list-group">
					<a href="{url journal=$journalPath page="editor" op="createIssue"}" class="btn btn-default btn-block">{translate key="editor.issues.createIssue"}</a> 
					<a href="{url journal=$journalPath page="editor" op="notifyUsers"}" class="btn btn-default btn-block">{translate key="editor.notifyUsers"}</a>
				</div>
			</div>
		{/if}
		
		{* SECTION EDITORS *}
		{if $isValid.SectionEditor.$journalId}
			{assign var="sectionEditorSubmissionsCount" value=$submissionsCount.SectionEditor.$journalId}
			<div class="col-md-4 equilibrium ">
				<h4><a href="{url journal=$journalPath page="sectionEditor"}">{translate key="user.role.sectionEditor"}</a></h4>
				<div class="list-group">
					{if $sectionEditorSubmissionsCount[0]}
						<a href="{url journal=$journalPath page="sectionEditor" op="index" path="submissionsInReview"}" class="list-group-item">{translate key="common.queue.short.submissionsInReview"} <span class="badge">{$sectionEditorSubmissionsCount[0]}</span></a>
					{else}<span class="disabled list-group-item">{translate key="common.queue.short.submissionsInReview"} <span class="badge">0</span></span>{/if}
					{if $sectionEditorSubmissionsCount[1]}
						<a href="{url journal=$journalPath page="sectionEditor" op="index" path="submissionsInEditing"}" class="list-group-item">{translate key="common.queue.short.submissionsInEditing"} <span class="badge">{$sectionEditorSubmissionsCount[1]}</span></a>
					{else}<span class="disabled list-group-item">{translate key="common.queue.short.submissionsInEditing"} <span class="badge">0</span></span>{/if}
					<a href="{url journal=$journalPath page="sectionEditor" op="index" path="submissionsArchives"}" class="list-group-item">{translate key="common.queue.short.submissionsArchives"}</a>
				</div>
			</div>
		{/if}
		
		{* COPYEDITORS *}
		{if $isValid.Copyeditor.$journalId}
			{assign var="copyeditorSubmissionsCount" value=$submissionsCount.Copyeditor.$journalId}
			<div class="col-md-4 equilibrium ">
				<h4><a href="{url journal=$journalPath page="copyeditor"}">{translate key="user.role.copyeditor"}</a></h4>
				<div class="list-group">
					{if $copyeditorSubmissionsCount[0]}
						<a href="{url journal=$journalPath page="copyeditor"}" class="list-group-item">{translate key="common.queue.short.submissionsInEditing"} <span class="badge">{$copyeditorSubmissionsCount[0]}</span></a>
					{else}<span class="disabled list-group-item">{translate key="common.queue.short.submissionsInEditing"} <span class="badge">0</span></span>{/if}
					{if $copyeditorSubmissionsCount[0]}
						<a href="{url journal=$journalPath page="copyeditor" path="completed"}" class="list-group-item">{translate key="common.queue.short.submissionsArchives"} <span class="badge">{$copyeditorSubmissionsCount[1]}</span></a>
					{else}<span class="disabled list-group-item">{translate key="common.queue.short.submissionsArchives"} <span class="badge">0</span></span>{/if}
				</div>
			</div>
		{/if}
		
		{* LAYOUT EDITORS *}
		{if $isValid.LayoutEditor.$journalId}
			{assign var="layoutEditorSubmissionsCount" value=$submissionsCount.LayoutEditor.$journalId}
			<div class="col-md-4 equilibrium ">
				<h4><a href="{url journal=$journalPath page="layoutEditor"}">{translate key="user.role.layoutEditor"}</a></h4>
				<div class="list-group">
					{if $layoutEditorSubmissionsCount[0]}
						<a href="{url journal=$journalPath page="layoutEditor" op="submissions"}" class="list-group-item">{translate key="common.queue.short.submissionsInEditing"} <span class="badge">{$layoutEditorSubmissionsCount[0]}</span></a>
					{else}<span class="disabled list-group-item">{translate key="common.queue.short.submissionsInEditing"} <span class="badge">0</span></span>{/if}
					{if $layoutEditorSubmissionsCount[1]}
						<a href="{url journal=$journalPath page="layoutEditor" op="submissions" path="completed"}" class="list-group-item">{translate key="common.queue.short.submissionsArchives"} <span class="badge">{$layoutEditorSubmissionsCount[1]}</span></a>
					{else}<span class="disabled list-group-item">{translate key="common.queue.short.submissionsArchives"} <span class="badge">0</span></span>{/if}
				</div>
			</div>
		{/if}
		
		{* PROOFREADERS *}
		{if $isValid.Proofreader.$journalId}
			{assign var="proofreaderSubmissionsCount" value=$submissionsCount.Proofreader.$journalId}
			<div class="col-md-4 equilibrium ">
				<h4><a href="{url journal=$journalPath page="proofreader"}">{translate key="user.role.proofreader"}</a></h4>
				<div class="list-group">
					{if $proofreaderSubmissionsCount[0]}
						<a href="{url journal=$journalPath page="proofreader"}" class="list-group-item">{translate key="common.queue.short.submissionsInEditing"} <span class="badge">{$proofreaderSubmissionsCount[0]}</span></a>
					{else}<span class="disabled list-group-item">{translate key="common.queue.short.submissionsInEditing"} <span class="badge">0</span></span>{/if}
					{if $proofreaderSubmissionsCount[1]}
						<a href="{url journal=$journalPath page="proofreader" path="completed"}" class="list-group-item">{translate key="common.queue.short.submissionsArchives"} <span class="badge">{$proofreaderSubmissionsCount[1]}</span></a>
					{else}<span class="disabled list-group-item">{translate key="common.queue.short.submissionsArchives"} <span class="badge">0</span></span>{/if}
				</div>
			</div>
		{/if}

	{call_hook name="Templates::User::Index::Journal" journal=$journal}
	</div>
{/foreach}
</div>

{if !$hasRole}
	{if $currentJournal}
		<div id="noRolesForJournal">
		<p>{translate key="user.noRoles.noRolesForJournal"}</p>
		<ul>
			<li>
				{if $allowRegAuthor}
					{url|assign:"submitUrl" page="author" op="submit"}
					<a href="{url op="become" path="author" source=$submitUrl}">{translate key="user.noRoles.submitArticle"}</a>
				{else}{* $allowRegAuthor *}
					{translate key="user.noRoles.submitArticleRegClosed"}
				{/if}{* $allowRegAuthor *}
			</li>
			<li>
				{if $allowRegReviewer}
					{url|assign:"userHomeUrl" page="user" op="index"}
					<a href="{url op="become" path="reviewer" source=$userHomeUrl}">{translate key="user.noRoles.regReviewer"}</a>
				{else}{* $allowRegReviewer *}
					{translate key="user.noRoles.regReviewerClosed"}
				{/if}{* $allowRegReviewer *}
			</li>
		</ul>
		</div>
	{else}{* $currentJournal *}
		<div id="currentJournal">
		<p>{translate key="user.noRoles.chooseJournal"}</p>
		<ul>
			{foreach from=$allJournals item=thisJournal}
				<li><a href="{url journal=$thisJournal->getPath() page="user" op="index"}">{$thisJournal->getLocalizedTitle()|escape}</a></li>
			{/foreach}
		</ul>
		</div>
	{/if}{* $currentJournal *}
{/if}{* !$hasRole *}

<div class="row col-md-12">
	<div id="myAccount" class="pull-right">
		{if $hasOtherJournals}
			{if !$showAllJournals}
				<a href="{url journal="index" page="user"}" class="btn btn-sm btn-primary">{translate key="user.showAllJournals"}</a>
			{/if}
		{/if}
		{if $currentJournal}
			{if $subscriptionsEnabled}
				<a href="{url page="user" op="subscriptions"}" class="btn btn-sm btn-info">{translate key="user.manageMySubscriptions"}</a>
			{/if}
		{/if}
		{if $currentJournal}
			{if $acceptGiftPayments}
				<a href="{url page="user" op="gifts"}" class="btn btn-sm btn-info">{translate key="gifts.manageMyGifts"}</a>
			{/if}
		{/if}
		<a href="{url page="user" op="profile"}" class="btn btn-sm btn-info">{translate key="user.editMyProfile"}</a>
	
		{if !$implicitAuth}
			<a href="{url page="user" op="changePassword"}" class="btn btn-sm btn-info">{translate key="user.changeMyPassword"}</a>
		{/if}
	
		{if $currentJournal}
			{if $journalPaymentsEnabled && $membershipEnabled}
				{if $dateEndMembership}
					<a href="{url page="user" op="payMembership"}" class="btn btn-sm btn-info">{translate key="payment.membership.renewMembership"}</a> ({translate key="payment.membership.ends"}: {$dateEndMembership|date_format:$dateFormatShort})
				{else}
					<a href="{url page="user" op="payMembership"}" class="btn btn-sm btn-info">{translate key="payment.membership.buyMembership"}</a>
				{/if}
			{/if}{* $journalPaymentsEnabled && $membershipEnabled *}
		{/if}{* $userJournal *}
	
		<a href="{url page="login" op="signOut"}" class="btn btn-sm btn-danger">{translate key="user.logOut"}</a>
		{call_hook name="Templates::User::Index::MyAccount"}
	</div>
</div>

{include file="common/footer.tpl"}

