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
<xsl:with-param name="node" select="/root/site/galleries"/>
<xsl:with-param name="node" select="/root/topic"/>
</xsl:call-template>
</xsl:attribute>
<xsl:call-template name="graphic"><xsl:with-param name="id" select="329"/></xsl:call-template>
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
<div id="search-bar">
<xsl:if test="$pagetype!='error404'">
<xsl:call-template name="userInfo"/>
</xsl:if>
</div>
</xsl:template>

<!-- ###############################
LEFT BAR PCK
############################### -->
<xsl:template name="leftBarPck">
<xsl:call-template name="banner"><xsl:with-param name="id" select="'316'"/></xsl:call-template>
<xsl:call-template name="banner"><xsl:with-param name="id" select="'319'"/></xsl:call-template>
<xsl:call-template name="bannerGroup"><xsl:with-param name="id" select="'33'"/></xsl:call-template>
</xsl:template>

<!-- ###############################
LEFT BOTTOM
############################### -->
<xsl:template name="leftBottom">
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
<xsl:call-template name="facebookLike">
<xsl:with-param name="action">recommend</xsl:with-param>
<xsl:with-param name="layout">button_count</xsl:with-param>
</xsl:call-template>
<xsl:call-template name="bannerGroup"><xsl:with-param name="id" select="'32'"/></xsl:call-template>
<xsl:call-template name="bannerGroup"><xsl:with-param name="id" select="'29'"/></xsl:call-template>
<xsl:call-template name="bannerGroup"><xsl:with-param name="id" select="'30'"/></xsl:call-template>

<xsl:call-template name="supportPck"/>
<xsl:choose>
<xsl:when test="$pagetype='events'">

</xsl:when>
<xsl:otherwise>
<!-- RIGHT BAR generica -->
<xsl:if test="$pagetype!='error404'">


<xsl:call-template name="bannerGroup"><xsl:with-param name="id" select="'27'"/></xsl:call-template>

<xsl:if test="/root/features/feature[@id='6']">
<div id="tematiche" class="pckbox2">

</div>

</xsl:if>

<xsl:call-template name="gallerie"/>
<xsl:call-template name="share"/>
</xsl:if>
<!--
<xsl:call-template name="listsPck"/>
<xsl:call-template name="linksPck"/>
-->
</xsl:otherwise>
</xsl:choose>

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
EDITORIALE ALTRO PCK
############################### -->
<xsl:template name="editorialeAltroPck">
<div class="pckbox">
<xsl:apply-templates select="/root/c_features/feature[@id='133']" />
</div>
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
BOTTOM BAR PCK
############################### -->
<xsl:template name="bottomBarPck">
- AmicidiChiaraCastellani -<a href="mailto:coordinamento.chiaracastellani@gmail.com"> coordinamento.chiaracastellani@gmail.com</a> - 
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="/root/c_features/feature[@id='18']/items/subtopic"/>
<xsl:with-param name="name" select="/root/c_features/feature[@id='18']/@name"/>
</xsl:call-template>
<!--
- Portale realizzato con <a href="http://www.phpeace.org">PhPeace <xsl:value-of select="/root/site/@phpeace"/></a>
Privacy - Accessibilita - Web standards -
-->
</xsl:template>

<!-- ###############################
SUPPORT PCK
############################### -->
<xsl:template name="supportPck">
<div class="pckbox" id="support">

<xsl:apply-templates select="/root/c_features/feature[@id='133']" />

</div>
</xsl:template>

<!-- ###############################
GALLERIE
############################### -->
<xsl:template name="gallerie">
<div class="pckbox2" id="gallerie">
<h3 class="feature">



</h3>

</div>
</xsl:template>



<!-- ###############################
NEWS PCK
############################### -->
<xsl:template name="newsPck">
<div class="pckbox">

</div>
</xsl:template>


<!-- ###############################
DOSSIER PCK
############################### -->
<xsl:template name="dossierPck">
<div class="pckbox">

</div>
</xsl:template>


<!-- ###############################
MEDIA NEWS
############################### -->
<xsl:template name="giornalismi">
<div id="giornalismi" class="pckbox">

</div>
</xsl:template>

<!-- ###############################
MAMMA.AM
############################### -->
<xsl:template name="mamma">
<div id="mamma" class="pckbox">

</div>
</xsl:template>

<!-- ###############################
BOOKS PCK
############################### -->
<xsl:template name="booksPck">
<div class="pckbox">
</div>
</xsl:template>

<!-- ###############################
RSS TICKER PCK
############################### -->
<xsl:template name="tickerPck">
<xsl:choose>
<xsl:when test="/root/topic/lists/list/@feed!=''">
<xsl:call-template name="rssTicker">
<xsl:with-param name="url" select="/root/topic/lists/list/@feed"/>
<xsl:with-param name="title" select="concat('Lista ',/root/topic/lists/list/@name)"/>
<xsl:with-param name="title_link" select="/root/topic/lists/list/@url"/>
</xsl:call-template>
</xsl:when>
<xsl:otherwise>
<xsl:call-template name="rssTicker">
<xsl:with-param name="url">http://lists.peacelink.it/feed/news/news.rss</xsl:with-param>
<xsl:with-param name="title">PeaceLink News</xsl:with-param>
<xsl:with-param name="title_link">http://www.peacelink.it/liste/index.php?id=15</xsl:with-param>
</xsl:call-template>
</xsl:otherwise>
</xsl:choose>
</xsl:template>


</xsl:stylesheet>