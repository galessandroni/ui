<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:variable name="id_sublevel">
<xsl:choose>
<xsl:when test="$pagetype='subtopic'"><xsl:value-of select="/root/subtopic/breadcrumb/subtopic/@id"/></xsl:when>
<xsl:when test="$pagetype='article'"><xsl:value-of select="/root/article/breadcrumb/subtopic/@id"/></xsl:when>
</xsl:choose>
</xsl:variable>



<!-- ###############################
     ROOT
     ############################### -->
<xsl:template name="root">
<html lang="{/root/topic/@lang}">
<head>
<xsl:call-template name="head"/>
</head>
<body class="{/root/publish/@type}" id="id{/root/publish/@id}">
<xsl:if test="/root/preview"><xsl:call-template name="previewToolbar"/></xsl:if>
<div id="main-wrap" class="sesicg">
<div id="top-bar"><xsl:call-template name="topBarPck" /></div>
<div id="top-nav"><xsl:call-template name="topNavPck"/></div>
<div id="main">
<div id="left-bar"><xsl:call-template name="leftBarPck" /></div>
<div id="right-bar"><xsl:call-template name="rightBarPck" /></div>
<div id="center"><xsl:call-template name="content" /></div>
</div>
<div id="bottom-bar"><xsl:call-template name="bottomBarPck" /></div>
</div>
</body>
</html>
</xsl:template>


<!-- ###############################
     TOP BAR PCK
     ############################### -->
<xsl:template name="topBarPck">
<div id="logo">
<a>
<xsl:attribute name="href">
<xsl:call-template name="createLinkUrl">
<xsl:with-param name="node" select="/root/topic"/>
</xsl:call-template>
</xsl:attribute>
<xsl:call-template name="graphic"><xsl:with-param name="id" select="242"/></xsl:call-template>
</a>
</div>
<div id="sesicg">
<div></div>
<h1>
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="/root/topic"/>
</xsl:call-template>
</h1>
</div>
<ul id="main-menu">
<xsl:for-each select="/root/menu/subtopics/subtopic">
<li>
<xsl:attribute name="class">pos<xsl:value-of select="position()"/>
<xsl:if test="@id=$id_sublevel"><xsl:text> </xsl:text>selected</xsl:if></xsl:attribute>
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="."/>
</xsl:call-template>
</li>
</xsl:for-each>
</ul>
</xsl:template>


<!-- ###############################
TOP NAV PCK
############################### -->
<xsl:template name="topNavPck">
</xsl:template>



<!-- ###############################
     LEFT BAR PCK
     ############################### -->
<xsl:template name="leftBarPck">
<xsl:call-template name="navigationMenu"/>
<xsl:call-template name="leftBottom"/>
</xsl:template>


<!-- ###############################
     LEFT BAR SP
     ############################### -->
<xsl:template name="leftBarSp">
<xsl:if test="/root/c_features/feature[@id='85']/items/item">
<div id="sp-main">
<h3>IN PRIMO PIANO</h3>
<xsl:call-template name="articleItem">
<xsl:with-param name="a" select="/root/c_features/feature[@id='85']/items/item" />
</xsl:call-template>
</div>
</xsl:if>
<xsl:call-template name="randomQuote"/>
</xsl:template>


<!-- ###############################
NAVIGATION MENU
############################### -->
<xsl:template name="navigationMenu">
<xsl:choose>
<xsl:when test="$id_sublevel &gt; 0">
<h2>
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="/root/menu/subtopics/subtopic[@id=$id_sublevel]"/>
</xsl:call-template>
</h2>
<xsl:apply-templates select="/root/menu/subtopics/subtopic[@id=$id_sublevel]"/>
</xsl:when>
<xsl:otherwise>
<xsl:call-template name="leftBarSp"/>
</xsl:otherwise>
</xsl:choose>

<div class="menu-footer">
<xsl:apply-templates select="/root/menu/menu_footer"/>
</div>

</xsl:template>



<!-- ###############################
     RIGHT BAR PCK
     ############################### -->
<xsl:template name="rightBarPck">
<xsl:call-template name="searchPck"/>
<!-- <xsl:call-template name="tickerPck"/> -->
<xsl:call-template name="rssLogo">
<xsl:with-param name="node" select="/root/topic/rss"/>
</xsl:call-template>
<xsl:call-template name="nextEventsPck"/>
</xsl:template>


<!-- ###############################
RANDOM QUOTE
############################### -->
<xsl:template name="randomQuote">
<xsl:if test="$pagetype!='error404'">
<div class="quote" id="random-quote">
<script type="text/javascript">
<xsl:choose>
<xsl:when test="$async_js=true() and not(/root/topic/@domain and /root/publish/@static='1')">
getHttpContent('/js/quote.php?a=1&amp;id_topic=<xsl:value-of select="/root/topic/@id"/>','random-quote')
</xsl:when>
<xsl:otherwise>
<xsl:attribute name="src"><xsl:value-of select="/root/site/@base"/>/js/quote.php&amp;id_topic=<xsl:value-of select="/root/topic/@id"/></xsl:attribute>
</xsl:otherwise>
</xsl:choose>
</script>
<noscript>Random quote</noscript>
</div>
</xsl:if>
</xsl:template>


<!-- ###############################
     SEARCH PCK
    ############################### -->
<xsl:template name="searchPck">
<form method="get" id="search-form-pck" accept-charset="{/root/site/@encoding}">
<xsl:attribute name="action">
<xsl:call-template name="createLinkUrl">
<xsl:with-param name="node" select="/root/site/search"/>
</xsl:call-template>
</xsl:attribute>
<fieldset>
<legend><xsl:value-of select="/root/site/search/@label"/></legend>
<xsl:if test="$preview='1'"><input type="hidden" name="id_type" value="18"/></xsl:if>
<input type="hidden" name="id_topic" value="{/root/topic/@id}"/>
<input type="text" name="q" value="{/root/search/@q}" class="search-input"/>
<input type="submit" value="{/root/site/search/@name}" class="search-submit"/>
</fieldset>
</form>
</xsl:template>


<!-- ###############################
BREADCRUMB
############################### -->
<xsl:template name="breadcrumb">
<div class="breadcrumb">
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="/root/topic"/>
<xsl:with-param name="name" select="'Homepage'"/>
</xsl:call-template>
<xsl:value-of select="$breadcrumb_separator"/>
<xsl:choose>
<xsl:when test="$pagetype='subtopic'">
<xsl:apply-templates select="/root/subtopic/breadcrumb" mode="breadcrumb"/>
</xsl:when>
<xsl:when test="$pagetype='article' or $pagetype='send_friend'">
<xsl:apply-templates select="/root/article/breadcrumb" mode="breadcrumb"/>
</xsl:when>
<xsl:otherwise>
<xsl:apply-templates select="/root/subtopic/breadcrumb" mode="breadcrumb"/>
</xsl:otherwise>
</xsl:choose>
</div>
</xsl:template>


<!-- ###############################
     BOTTOM BAR
     ############################### -->
<xsl:template name="bottomBarPck">
<xsl:if test="/root/topic/page_footer"><div id="page-footer"><xsl:apply-templates select="/root/topic/page_footer"/></div></xsl:if>
</xsl:template>


</xsl:stylesheet>
