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
<head><xsl:call-template name="head"/></head>
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
<xsl:with-param name="id" select="308"/>
</xsl:call-template>
</a>
</div>
<div id="banner-region">
<a href="http://www.nuclearabolition.org/" taget="_blank"><xsl:call-template name="graphic"><xsl:with-param name="id" select="323"/><xsl:with-param name="format" select="'png'"/></xsl:call-template></a></div>
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

<xsl:call-template name="facebookLike">
  <xsl:with-param name="action">recommend</xsl:with-param>
  <xsl:with-param name="layout">button_count</xsl:with-param>
</xsl:call-template>


<xsl:call-template name="banner"><xsl:with-param name="id" select="'337'"/></xsl:call-template>

<!-- Photos -->
<xsl:apply-templates select="/root/c_features/feature[@id='159']" />



<!-- News -->
<xsl:if test="not($pagetype='subtopic' and /root/subtopic/@id=3425)">
<xsl:apply-templates select="/root/c_features/feature[@id='163']" />
</xsl:if>

<!-- World map -->
<div id="world-news" class="clearfloat">
<xsl:apply-templates select="/root/c_features/feature[@id='158']" />
</div>


</div>
</div>

<div id="footer-region" class="clearfloat"></div>
<div id="footer-message"></div>


</body>
</html>
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
<xsl:with-param name="bgcolor" select="'0xECECEC'"/>
<xsl:with-param name="jscaptions" select="items/item/@show_captions='1'"/>
</xsl:call-template>
<div id="slide-caption" name="slide-caption" class="gallery-image"></div>
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


</xsl:stylesheet>