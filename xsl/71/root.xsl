<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">


<!-- ###############################
     ROOT
################################## -->
<xsl:template name="root">
<html>
<xsl:attribute name="lang">
<xsl:choose>
<xsl:when test="/root/topic"><xsl:value-of select="/root/topic/@lang"/></xsl:when>
<xsl:otherwise><xsl:value-of select="/root/site/@lang"/></xsl:otherwise>
</xsl:choose>
</xsl:attribute>
<head><xsl:call-template name="head"/>
<xsl:call-template name="googleAnalytics">
<xsl:with-param name="ua-id" select="'UA-27173221-1'" />
</xsl:call-template>
<script type="text/javascript" src="{/root/site/@base}/js/s71_1.js{/root/publish/@js_version}"></script>
</head>
<body class="{/root/publish/@type}" id="id{/root/publish/@id}">
<xsl:if test="/root/preview"><xsl:call-template name="previewToolbar"/></xsl:if>

<div id="head" class="clearfloat">

<div class="clearfloat">
<div id="logo">
<a>
<xsl:attribute name="href">
<xsl:call-template name="createLinkUrl">
<xsl:with-param name="node" select="/root/topic"/>
</xsl:call-template>
</xsl:attribute>
<xsl:call-template name="graphic">
<xsl:with-param name="id" select="332"/>
<xsl:with-param name="format" select="'png'"/>
</xsl:call-template>
</a>
</div>
<div id="banner-region">
<xsl:apply-templates select="/root/c_features/feature[@id='174']" /></div>
</div>

<div id="navbar" class="clearfloat">
<div id="page-bar">
<ul class="menu">
<li class="leaf first"><a>
<xsl:attribute name="href">
<xsl:call-template name="createLinkUrl">
<xsl:with-param name="node" select="/root/topic"/>
</xsl:call-template>
</xsl:attribute>
Home</a>
</li>
<xsl:for-each select="/root/menu/subtopics/subtopic">
<li>
<xsl:attribute name="class">leaf collapsed <xsl:if test="@id = /root/subtopic/@id">selected</xsl:if></xsl:attribute>
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="."/>
</xsl:call-template>
</li>
</xsl:for-each>
</ul>
</div>
</div>

</div>

<div id="page" class="clearfloat">
<div id="content" class="main-content with-sidebar"><xsl:call-template name="content"/></div>
<div id="sidebar">

<div id="appellonof35"></div>
<script type="text/javascript">
$().ready(function() {
            CampaignSigners(97,'#appellonof35');
});
</script>

<xsl:call-template name="googlePlusOne"/>

<a href="https://twitter.com/share" class="twitter-share-button" data-lang="it" data-hashtags="nof35">Tweet</a>
<script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0];if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src="//platform.twitter.com/widgets.js";fjs.parentNode.insertBefore(js,fjs);}}(document,"script","twitter-wjs");</script>

<xsl:call-template name="facebookLike">
  <xsl:with-param name="action">recommend</xsl:with-param>
  <xsl:with-param name="layout">button_count</xsl:with-param>
</xsl:call-template>

<xsl:call-template name="bannerGroup"><xsl:with-param name="id" select="'17'"/></xsl:call-template>

<!-- News -->
<xsl:apply-templates select="/root/c_features/feature[@id='175']" />

<xsl:apply-templates select="/root/c_features/feature[@id='184']" />


<!-- World map -->
<!--
<div id="world-news" class="clearfloat">
<xsl:apply-templates select="/root/c_features/feature[@id='158']" />
</div>
-->


</div>
</div>

<div id="footer-region" class="clearfloat"></div>
<div id="footer-message"></div>

</body>
</html>
</xsl:template>


<!-- ###############################
     FACEBOOK LIKE
     ############################### -->
<xsl:template name="facebookLike">
<xsl:param name="width" select="200"/>
<xsl:param name="action" select="'like'"/>
<xsl:param name="layout" select="'standard'"/>
<xsl:param name="faces" select="'false'"/>
<div class="facebook-like">
<iframe src="http://www.facebook.com/plugins/like.php?href={/root/page/@url_encoded}&amp;layout={$layout}&amp;locale=it_IT&amp;show-faces={$faces}&amp;width={$width}&amp;action={$action}&amp;colorscheme=light" scrolling="no" frameborder="0" style="border:none; overflow:hidden; width:{$width}px;" allowTransparency="true"></iframe>
</div>
</xsl:template>


<!-- ###############################
FEATURE
############################### -->
<xsl:template match="feature">
<xsl:if test="@name !=''">
<h3 class="feature"><xsl:value-of select="@name"/></h3>
</xsl:if>
<xsl:choose>
<xsl:when test="@id_function='1' or @id_function='2' or @id_function='27'">
<ul class="items">
<xsl:choose>
<xsl:when test="params/@with_content='1'">
<xsl:for-each select="items/item">
<li class="{@type}-item">
<xsl:call-template name="articleContent">
<xsl:with-param name="a" select="."/>
</xsl:call-template>
</li>
</xsl:for-each>
</xsl:when>
<xsl:otherwise>
<xsl:apply-templates select="items" mode="mainlist"/>
</xsl:otherwise>
</xsl:choose>
</ul>
</xsl:when>
<xsl:when test="@id_function='3'">
<ul class="topics">
<xsl:apply-templates mode="mainlist" select="items"/>
</ul>
</xsl:when>
<xsl:when test="@id_function='6'">
<xsl:choose>
<xsl:when test="params/@with_content='1'">
<xsl:call-template name="articleContent">
<xsl:with-param name="a" select="items/item"/>
</xsl:call-template>
</xsl:when>
<xsl:otherwise>
<xsl:call-template name="articleItem">
<xsl:with-param name="a" select="items/item"/>
</xsl:call-template>
</xsl:otherwise>
</xsl:choose>
</xsl:when>
<xsl:when test="@id_function='7'">
<xsl:call-template name="subtopicItem">
<xsl:with-param name="s" select="items/subtopic"/>
<xsl:with-param name="with_children" select="params/@with_children='1'"/>
<xsl:with-param name="with_tags" select="true()"/>
</xsl:call-template>
</xsl:when>
<xsl:when test="@id_function='8'">
<ul class="items">
<xsl:apply-templates mode="mainlist" select="items"/>
</ul>
</xsl:when>
<xsl:when test="@id_function='11'">
<xsl:call-template name="rssParse">
<xsl:with-param name="node" select="items/rss/rss"/>
</xsl:call-template>
</xsl:when>
<xsl:when test="@id_function='12'">
<div id="gtext-{items/item/@id}" class="generic-text">
<xsl:value-of select="items/item/content" disable-output-escaping="yes"/>
</div>
</xsl:when>
<xsl:when test="@id_function='13' or @id_function='14'">
<ul class="groups">
<xsl:apply-templates select="items" mode="mainlist"/>
</ul>
</xsl:when>
<xsl:when test="@id_function='15'">
<h4><xsl:call-template name="createLink">
<xsl:with-param name="node" select="items/topic_full/topic"/>
</xsl:call-template></h4>
<xsl:if test="params/@with_menu='1'">
<xsl:apply-templates select="items/topic_full/menu/subtopics"/>
</xsl:if>
</xsl:when>
<xsl:when test="@id_function='22'">
<xsl:call-template name="videoNode">
<xsl:with-param name="node" select="items/video"/>
</xsl:call-template>
</xsl:when>
<xsl:when test="@id_function='23'">
<xsl:call-template name="slideshow">
<xsl:with-param name="id" select="items/item/@id"/>
<xsl:with-param name="width" select="items/item/@width"/>
<xsl:with-param name="height" select="items/item/@height"/>
<xsl:with-param name="images" select="items/item/@xml"/>
<xsl:with-param name="watermark"></xsl:with-param>
<xsl:with-param name="audio"><xsl:if test="items/item/@audio!=''"><xsl:value-of select="items/item/@audio"/></xsl:if></xsl:with-param>
<xsl:with-param name="shuffle" select="items/item/@shuffle"/>
<xsl:with-param name="bgcolor" select="'0xFFFFFF'"/>
<xsl:with-param name="jscaptions" select="items/item/@show_captions='1'"/>
</xsl:call-template>
<xsl:if test="items/item/@show_captions='1'">
<div id="slide-caption-{items/item/@id}" class="gallery-image"></div>
</xsl:if>
</xsl:when>
<xsl:when test="@id_function='25'">
<xsl:choose>
<xsl:when test="items/xml/feature_group">
<ul class="items">
<xsl:apply-templates select="items/xml/feature_group/items" mode="mainlist"/>
</ul>
</xsl:when>
<xsl:when test="items/xml/rss">
<xsl:call-template name="rssParse">
<xsl:with-param name="node" select="items/xml/rss"/>
</xsl:call-template>
</xsl:when>
</xsl:choose>
</xsl:when>
<xsl:otherwise>
<ul class="items">
<xsl:apply-templates select="items" mode="mainlist"/>
</ul>
</xsl:otherwise>
</xsl:choose>
</xsl:template>


<!-- ###############################
SLIDESHOW
############################### -->
<xsl:template name="slideshow">
<xsl:param name="id"/>
<xsl:param name="width"/>
<xsl:param name="height"/>
<xsl:param name="images"/>
<xsl:param name="controls" select="true()"/>
<xsl:param name="repeat" select="true()"/>
<xsl:param name="audio" select="''"/>
<xsl:param name="transition" select="'fade'"/>
<xsl:param name="watermark" select="''"/>
<xsl:param name="shuffle" select="'false'"/>
<xsl:param name="jscaptions" select="false()"/>
<xsl:param name="bgcolor" select="'0x000000'"/>

<xsl:if test="$jscaptions=true()">
<script type="text/javascript">
var currentItem<xsl:value-of select="$id"/>;
function getUpdate(typ,pr1,pr2,swfid) {
  eval("getUpdate"+swfid+"('"+typ+"','"+pr1+"','"+pr2+"')");
}
function getUpdate<xsl:value-of select="$id"/>(typ,pr1,pr2) {
if(typ == 'item') { currentItem<xsl:value-of select="$id"/> = pr1; setTimeout("getItemData<xsl:value-of select="$id"/>(currentItem<xsl:value-of select="$id"/>)",100); }
};
function getItemData<xsl:value-of select="$id"/>(idx) {
var obj = thisMovie("galshow-<xsl:value-of select="$id"/>").itemData(idx);
gc = document.getElementById("slide-caption-<xsl:value-of select="$id"/>");
gc.innerHTML = obj['description'];
};
</script>
</xsl:if>

<div id="galshow-{$id}" class="slideshow"><p class="flash-warning"><xsl:value-of select="key('label','flash_warning')/@tr" disable-output-escaping="yes"/></p></div>
<script type="text/javascript">
var flashvars = {};
flashvars.javascriptid = '<xsl:value-of select="$id"/>';
flashvars.width = '<xsl:value-of select="$width"/>';
flashvars.height = '<xsl:value-of select="$height"/>';
flashvars.file = encodeURIComponent('<xsl:value-of select="$images"/>');
<xsl:if test="$audio!=''">
flashvars.audio = encodeURIComponent('<xsl:value-of select="$audio"/>');
flashvars.showeq = 'true';
</xsl:if>
<xsl:if test="$watermark!=''">
flashvars.logo = encodeURIComponent('<xsl:value-of select="$watermark"/>');
</xsl:if>
flashvars.shuffle = '<xsl:value-of select="$shuffle"/>';
flashvars.screencolor = '<xsl:value-of select="$bgcolor"/>';
<xsl:if test="$id=178">
flashvars.shownavigation = 'false';
</xsl:if>
<xsl:if test="$jscaptions=true()">
flashvars.enablejs = 'true';
</xsl:if>
flashvars.linkfromdisplay = 'true';
flashvars.overstretch = 'false';
flashvars.transition = '<xsl:value-of select="$transition"/>';
var params = {};
params.allowfullscreen = 'false';
params.wmode = 'opaque';
params.bgcolor = '<xsl:value-of select="$bgcolor"/>';
var attributes = {};
attributes.id = "galshow-<xsl:value-of select="$id"/>";
swfobject.embedSWF("/tools/imagerotator.swf","galshow-<xsl:value-of select="$id"/>",'<xsl:value-of select="$width"/>','<xsl:value-of select="$height"/>','9.0.0','<xsl:value-of select="/root/site/@base"/>/tools/expressInstall.swf',flashvars,params,attributes);
</script>
</xsl:template>

</xsl:stylesheet>