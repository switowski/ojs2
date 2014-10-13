{**
 * templates/common/minifiedScripts.tpl
 *
 * Copyright (c) 2013-2014 Simon Fraser University Library
 * Copyright (c) 2003-2014 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * This file contains a list of all JavaScript files that should be compiled
 * for distribution.
 *
 * NB: Please make sure that you add your scripts in the same format as the
 * existing files because this file will be parsed by the build script.
 *}

{* External jQuery plug-ins to be minified *}
<script type="text/javascript" src="{$baseUrl}/lib/pkp/js/lib/jquery/plugins/jquery.tag-it.js"></script>
<script type="text/javascript" src="{$baseUrl}/lib/pkp/js/lib/jquery/plugins/jquery.cookie.js"></script>
<script type="text/javascript" src="{$baseUrl}/lib/pkp/js/lib/MathJax/MathJax.js?config=TeX-AMS-MML_HTMLorMML"></script>

{* Our own functions (depend on plug-ins) *}
<script type="text/javascript" src="{$baseUrl}/lib/pkp/js/functions/fontController.js"></script>
<script type="text/javascript" src="{$baseUrl}/lib/pkp/js/functions/general.js"></script>
<script type="text/javascript" src="{$baseUrl}/lib/pkp/js/functions/jqueryValidatorI18n.js"></script>

{* Our own classes (depend on plug-ins) *}
<script type="text/javascript" src="{$baseUrl}/lib/pkp/js/classes/Helper.js"></script>
<script type="text/javascript" src="{$baseUrl}/lib/pkp/js/classes/ObjectProxy.js"></script>
<script type="text/javascript" src="{$baseUrl}/lib/pkp/js/classes/Handler.js"></script>
<script type="text/javascript" src="{$baseUrl}/lib/pkp/js/classes/linkAction/LinkActionRequest.js"></script>
<script type="text/javascript" src="{$baseUrl}/lib/pkp/js/classes/features/Feature.js"></script>

{* Generic controllers *}
<script type="text/javascript" src="{$baseUrl}/lib/pkp/js/controllers/SiteHandler.js"></script><!-- Included only for namespace definition -->
<script type="text/javascript" src="{$baseUrl}/lib/pkp/js/controllers/UrlInDivHandler.js"></script>
<script type="text/javascript" src="{$baseUrl}/lib/pkp/js/controllers/AutocompleteHandler.js"></script>
<script type="text/javascript" src="{$baseUrl}/lib/pkp/js/controllers/ExtrasOnDemandHandler.js"></script>
<script type="text/javascript" src="{$baseUrl}/lib/pkp/js/controllers/form/FormHandler.js"></script>
<script type="text/javascript" src="{$baseUrl}/lib/pkp/js/controllers/form/AjaxFormHandler.js"></script>
<script type="text/javascript" src="{$baseUrl}/lib/pkp/js/controllers/form/ClientFormHandler.js"></script>
<script type="text/javascript" src="{$baseUrl}/lib/pkp/js/controllers/grid/GridHandler.js"></script>
<script type="text/javascript" src="{$baseUrl}/lib/pkp/js/controllers/linkAction/LinkActionHandler.js"></script>

{* Specific controllers *}
<script type="text/javascript" src="{$baseUrl}/js/pages/search/SearchFormHandler.js"></script>
<script type="text/javascript" src="{$baseUrl}/js/statistics/ReportGeneratorFormHandler.js"></script>
<script type="text/javascript" src="{$baseUrl}/plugins/generic/lucene/js/LuceneAutocompleteHandler.js"></script>

{* Our own plug-in (depends on classes) *}
<script type="text/javascript" src="{$baseUrl}/lib/pkp/js/lib/jquery/plugins/jquery.pkp.js"></script>

{* Piwik statistics - we want to enable them for every page, that's why we don't use the plugin *}
<!-- Piwik -->
<script type="text/javascript">
var _paq = _paq || [];
_paq.push(['trackPageView']);
_paq.push(['enableLinkTracking']);
(function() {
var u=(("https:" == document.location.protocol) ? "https" : "http") + "://piwik.web.cern.ch/piwik/";
_paq.push(['setTrackerUrl', u+'piwik.php']);
_paq.push(['setSiteId', 1314]);
var d=document, g=d.createElement('script'), s=d.getElementsByTagName('script')[0]; g.type='text/javascript';
g.defer=true; g.async=true; g.src=u+'piwik.js'; s.parentNode.insertBefore(g,s);
})();
</script>
<noscript><p><img src="http://piwik.web.cern.ch/piwik/piwik.php?idsite=1314" style="border:0;" alt="" /></p></noscript>
<!-- End Piwik Code -->