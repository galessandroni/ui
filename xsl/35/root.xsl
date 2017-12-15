<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- ###############################
     ROOT
     ############################### -->
<xsl:template name="root">
<html>
<xsl:attribute name="lang">
<xsl:choose>
<xsl:when test="/root/topic"><xsl:value-of select="/root/topic/@lang"/></xsl:when>
<xsl:otherwise><xsl:value-of select="/root/site/@lang"/></xsl:otherwise>
</xsl:choose>
</xsl:attribute>
<head>
<xsl:call-template name="head"/>
</head>
<body class="{/root/publish/@type}" id="id{/root/publish/@id}">
<xsl:if test="/root/preview"><xsl:call-template name="previewToolbar"/></xsl:if>
<div id="main-wrap" >
<div id="top-bar"><xsl:call-template name="topBar" /></div>
<div id="main">
<div id="left-bar"><xsl:call-template name="leftBar" /></div>
<div id="center"><xsl:call-template name="content" /></div>
</div>
</div>
</body>
</html>
</xsl:template>

<!-- ###############################
     TOP BAR
     ############################### -->
<xsl:template name="topBar">
<div id="logo">
<a>
<xsl:attribute name="href">
<xsl:call-template name="createLinkUrl">
<xsl:with-param name="node" select="/root/topic"/>
</xsl:call-template>
</xsl:attribute>
<xsl:call-template name="graphic">
<xsl:with-param name="id" select="209"/>
</xsl:call-template>
</a>
</div>
</xsl:template>


<!-- ###############################
NAVIGATION MENU
############################### -->
<xsl:template name="navigationMenu">
<xsl:if test="/root/topic">
<h2>
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="/root/topic"/>
</xsl:call-template>
</h2>
<xsl:apply-templates select="/root/menu/subtopics"/>
<xsl:call-template name="userInfo"/>
<div class="menu-footer">
<xsl:apply-templates select="/root/menu/menu_footer"/>
</div>
<xsl:if test="/root/topic/rss">
<xsl:call-template name="rssLogo">
<xsl:with-param name="node" select="/root/topic/rss"/>
</xsl:call-template>
</xsl:if>
</xsl:if>
</xsl:template>


</xsl:stylesheet>
