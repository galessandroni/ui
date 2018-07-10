<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">


<!-- ###############################
     ROOT
     ############################### -->
<xsl:template name="root">
<html lang="/root/topic/@lang">
<head>
<xsl:call-template name="head"/>
</head>
<body class="{/root/publish/@type}" id="id{/root/publish/@id}">
<xsl:if test="/root/preview"><xsl:call-template name="previewToolbar"/></xsl:if>
<div id="main-wrap" >
<div id="top-bar"><xsl:call-template name="topBar" /></div>
<!-- <div id="top-nav"><xsl:call-template name="topNav"/></div> -->
<div id="main">
<div id="left-bar"><xsl:call-template name="leftBar" /></div>
<!-- <div id="right-bar"><xsl:call-template name="rightBar" /></div> -->
<div id="center"><xsl:call-template name="content" /></div>
</div>
<div id="bottom-bar"><xsl:call-template name="bottomBar" /></div>
</div>
</body>
</html>
</xsl:template>


<!-- ###############################
     LEFT BOTTOM
     ############################### -->
<xsl:template name="leftBottom">
<xsl:call-template name="graphic">
<xsl:with-param name="id" select="228"/>
</xsl:call-template>
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
<xsl:with-param name="id" select="247"/>
</xsl:call-template>
</a>
</div>
<xsl:call-template name="graphic">
<xsl:with-param name="id" select="248"/>
</xsl:call-template>
</xsl:template>


<!-- ###############################
     BOTTOM BAR
############################### -->
<xsl:template name="bottomBar">
<xsl:apply-templates select="/root/c_features/feature[@id=81]"/>
<xsl:call-template name="graphic">
<xsl:with-param name="id" select="249"/>
</xsl:call-template>
<xsl:call-template name="graphic">
<xsl:with-param name="id" select="250"/>
</xsl:call-template>
</xsl:template>


</xsl:stylesheet>
