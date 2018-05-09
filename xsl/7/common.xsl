<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:include href="root.xsl" />
<xsl:include href="tools.xsl" />

<xsl:variable name="subtopic_id">
<xsl:choose>
<xsl:when test="$pagetype='subtopic'"><xsl:value-of select="/root/subtopic/breadcrumb/subtopic/@id"/></xsl:when>
<xsl:when test="$pagetype='article'"><xsl:value-of select="/root/article/breadcrumb/subtopic/@id"/></xsl:when>
</xsl:choose>
</xsl:variable>


<!-- ###############################
TOP NAV PCK
############################### -->
<xsl:template name="topNavPck">
<h1 class="hidden">Palestina</h1>
<ul id="content-links">
<li>
<xsl:if test="$pagetype='topic_home'">
<xsl:attribute name="class">selected</xsl:attribute>
</xsl:if>
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="/root/topic"/>
<xsl:with-param name="name" select="'Home'"/>
</xsl:call-template>
</li>
<xsl:for-each select="/root/menu/subtopics/subtopic">
<li>
<xsl:if test="@id = $subtopic_id">
<xsl:attribute name="class">selected</xsl:attribute>
</xsl:if>
<xsl:call-template name="createLink">
<xsl:with-param name="name" select="@name"/>
<xsl:with-param name="node" select="."/>
</xsl:call-template>
</li>
</xsl:for-each>
</ul>
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
<xsl:call-template name="graphic">
<xsl:with-param name="id" select="'258'"/>
<xsl:with-param name="format" select="'png'"/>
</xsl:call-template>
</a>
<a>
<xsl:attribute name="href">
<xsl:call-template name="createLinkUrl">
<xsl:with-param name="node" select="/root/site"/>
</xsl:call-template>
</xsl:attribute>
<xsl:call-template name="graphic">
<xsl:with-param name="id" select="259"/>
</xsl:call-template>
</a>
<a href="http://www.odcpace.org/index.php?option=com_content&amp;task=view&amp;id=40&amp;Itemid=85" target="_blank">
<xsl:call-template name="graphic">
<xsl:with-param name="id" select="'47'"/>
</xsl:call-template>
</a>
<a href="http://www.alternativenews.org" target="_blank">
<xsl:call-template name="graphic">
<xsl:with-param name="id" select="260"/>
<xsl:with-param name="format" select="'gif'"/>
</xsl:call-template>
</a>
</div>
</xsl:template>


<!-- ###############################
     RIGHT BAR PCK
     ############################### -->
<xsl:template name="rightBarPck">
<xsl:if test="$pagetype!='topic_home'">
<div class="palbox">
<xsl:variable name="f" select="/root/c_features/feature[@id='115']"/>
<h3 class="feature"><xsl:value-of select="$f/@name"/></h3>
<ul class="items">
<xsl:apply-templates select="$f/items" mode="mainlist"/>
</ul>
</div>
</xsl:if>

<div class="quote" id="random-quote">
<script type="text/javascript">
<xsl:choose>
<xsl:when test="$async_js=true() and not(/root/topic/@domain and /root/publish/@static='1')">
getHttpContent('/js/quote.php?a=1&amp;id_topic=8','random-quote')
</xsl:when>
<xsl:otherwise>
<xsl:attribute name="src"><xsl:value-of select="/root/site/@base"/>/js/quote.php?id_topic=8</xsl:attribute>
</xsl:otherwise>
</xsl:choose>
</script>
</div>


<div id="pal-links"><xsl:apply-templates select="/root/c_features/feature[@id='114']" /></div>
<xsl:call-template name="searchPck"/>
<div class="menu-footer">
<xsl:apply-templates select="/root/menu/menu_footer"/>
</div>
<xsl:call-template name="rssLogo">
<xsl:with-param name="node" select="/root/topic/rss"/>
</xsl:call-template>
</xsl:template>


<!-- ###############################
     CSS CUSTOM
     ############################### -->
<xsl:template name="cssCustom">
<xsl:comment><![CDATA[[if lt IE 8]><link rel="stylesheet" type="text/css" media="screen" href="]]><xsl:value-of select="$css_url"/>/<xsl:value-of select="/root/publish/@style"/>/custom_5.css<![CDATA[" /><![endif]]]></xsl:comment>
</xsl:template>

</xsl:stylesheet>
