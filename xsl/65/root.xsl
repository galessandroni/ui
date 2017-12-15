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
<xsl:with-param name="ua-id" select="'UA-27168243-1'" />
</xsl:call-template>
</head>
<body class="{/root/publish/@type}" id="id{/root/publish/@id}">
<xsl:if test="/root/preview"><xsl:call-template name="previewToolbar"/></xsl:if>
<div id="main-wrap" >

<div id="top-nav">
<div id="top-nav-top">
<xsl:call-template name="searchPax"/>
<xsl:call-template name="navigationMenuNavTop"/></div>
<div id="top-nav-bottom"><xsl:call-template name="navigationMenuNavBottom"/></div>
</div>

<div id="top-bar">
<div id="top-bar-top"><xsl:call-template name="topBarTop"/></div>
<div id="top-bar-bottom"><xsl:call-template name="navigationMenuBar"/></div>
</div>

<div id="main">

<div id="main-center">

<xsl:if test="/root/publish/@type='topic_home'">
<xsl:call-template name="content-banner"/></xsl:if>

<div id="center"><xsl:call-template name="content"/></div>
<div id="left-bar"><xsl:call-template name="navigationMenuLeft"/></div>
</div>

</div>
<div id="right-bar"><xsl:call-template name="rightBar"/></div>
<div id="bottom-bar"><xsl:call-template name="bottomBar"/></div>
</div>
</body>
</html>
</xsl:template>



</xsl:stylesheet>
