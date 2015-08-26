{**
 * templates/author/submit/submitHeader.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2003-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Header for the article submission pages.
 *
 *}
{strip}
{assign var="pageCrumbTitle" value="author.submit"}
{include file="common/header.tpl"}
{/strip}

<script>
	var alternativeTitle = '';
</script>

<div class="row bs-wizard">               
	<div class="col-md-offset-1 col-md-2 bs-wizard-step {if $submitStep > 1}complete{elseif $submitStep == 1}active{elseif $submissionProgress < 1}disabled{/if}">
      	<div class="text-center bs-wizard-stepnum">Step 1</div>
      	<div class="progress"><div class="progress-bar"></div></div>
      	<a href="{url op="submit" path="1" articleId=$articleId}" class="bs-wizard-dot"></a>
      	<div class="bs-wizard-info text-center">{translate key="author.submit.start"}</div>
    </div>
    
    <div class="col-md-2 bs-wizard-step {if $submitStep > 2}complete{elseif $submitStep == 2}active{elseif $submissionProgress < 2}disabled{/if}">
      	<div class="text-center bs-wizard-stepnum">Step 2</div>
      	<div class="progress"><div class="progress-bar"></div></div>
      	<a href="{url op="submit" path="2" articleId=$articleId}" class="bs-wizard-dot"></a>
      	<div class="bs-wizard-info text-center">{translate key="author.submit.upload"}</div>
    </div>
    
    <div class="col-md-2 bs-wizard-step {if $submitStep > 3}complete{elseif $submitStep == 3}active{elseif $submissionProgress < 3}disabled{/if}">
      	<div class="text-center bs-wizard-stepnum">Step 3</div>
      	<div class="progress"><div class="progress-bar"></div></div>
      	<a href="{url op="submit" path="3" articleId=$articleId}" class="bs-wizard-dot"></a>
      	<div class="bs-wizard-info text-center">{translate key="author.submit.metadata"}</div>
    </div>
    
    <div class="col-md-2 bs-wizard-step {if $submitStep > 4}complete{elseif $submitStep == 4}active{elseif $submissionProgress < 4}disabled{/if}">
      	<div class="text-center bs-wizard-stepnum">Step 4</div>
      	<div class="progress"><div class="progress-bar"></div></div>
      	<a href="{url op="submit" path="4" articleId=$articleId}" class="bs-wizard-dot"></a>
      	<div class="bs-wizard-info text-center">{translate key="author.submit.supplementaryFiles"}</div>
    </div>
    
    <div class="col-md-2 bs-wizard-step {if $submitStep > 5}complete{elseif $submitStep == 5}active{elseif $submissionProgress < 5}disabled{/if}">
      	<div class="text-center bs-wizard-stepnum">Step 5</div>
      	<div class="progress"><div class="progress-bar"></div></div>
      	<a href="{url op="submit" path="5" articleId=$articleId}" class="bs-wizard-dot"></a>
      	<div class="bs-wizard-info text-center">{translate key="author.submit.confirmation"}</div>
    </div>
</div>

