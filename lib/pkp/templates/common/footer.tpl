{**
 * templates/common/footer.tpl
 *
 * Copyright (c) 2013-2014 Simon Fraser University Library
 * Copyright (c) 2000-2014 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Common site footer.
 *
 *}
{if $displayCreativeCommons}
    {translate key="common.ccLicense"}
{/if}
{if $pageFooter}
    <br /><br />
    <div id="pageFooter">{$pageFooter}</div>
{/if}
{call_hook name="Templates::Common::Footer::PageFooter"}
</div><!-- content -->
</div><!-- main -->

{call_hook|assign:"leftSidebarCode" name="Templates::Common::LeftSidebar"}
{call_hook|assign:"rightSidebarCode" name="Templates::Common::RightSidebar"}
{if $leftSidebarCode || $rightSidebarCode}<link rel="stylesheet" href="{$baseUrl}/styles/sidebar.css" type="text/css" />{/if}
{if $leftSidebarCode}<link rel="stylesheet" href="{$baseUrl}/styles/leftSidebar.css" type="text/css" />{/if}
{if $rightSidebarCode}<link rel="stylesheet" href="{$baseUrl}/styles/rightSidebar.css" type="text/css" />{/if}
{if $leftSidebarCode && $rightSidebarCode}<link rel="stylesheet" href="{$baseUrl}/styles/bothSidebars.css" type="text/css" />{/if}



{if $leftSidebarCode || $rightSidebarCode}
    <div id="sidebar">
        {if $leftSidebarCode}
            <div id="leftSidebar">
                {$leftSidebarCode}
            </div>
        {/if}
        {if $rightSidebarCode}
            <div id="rightSidebar">
                {$rightSidebarCode}
            </div>
        {/if}
    </div>
{/if}

</div><!-- body -->

{get_debug_info}
{if $enableDebugStats}{include file=$pqpTemplate}{/if}

</div><!-- container -->
<div id="footer">
    <div class="cern-logo">
        <a href="http://cern.ch" title="CERN" rel="CERN"><span>cern.ch</span></a>
    </div>
</div>
</body>
</html>