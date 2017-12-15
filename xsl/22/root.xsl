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
<xsl:call-template name="googleAnalytics">
<xsl:with-param name="ua-id" select="'UA-27173221-1'" />
</xsl:call-template> 
</head>
<body class="{/root/publish/@type}" id="id{/root/publish/@id}">
<xsl:if test="/root/preview"><xsl:call-template name="previewToolbar"/></xsl:if>
<div id="rid-wrap">
<div id="rid-left"><xsl:call-template name="ridLeftBar"/></div>
<div id="rid-content">
<xsl:call-template name="content"/>
<div id="rid-clear">.</div>
</div>
</div>
</body>
</html>
</xsl:template>


<!-- ###############################
     RID LEFT BAR
     ############################### -->
<xsl:template name="ridLeftBar">
<a>
<xsl:attribute name="href">
<xsl:call-template name="createLinkUrl">
<xsl:with-param name="node" select="/root/topic"/>
</xsl:call-template>
</xsl:attribute>
<xsl:call-template name="graphic">
<xsl:with-param name="id" select="'132'"/>
</xsl:call-template>
</a>
<xsl:call-template name="navigationMenu"/>


<xsl:call-template name="banner">
<xsl:with-param name="id" select="'333'"/>
</xsl:call-template>
<xsl:call-template name="banner">
<xsl:with-param name="id" select="'266'"/>
</xsl:call-template>
<xsl:call-template name="banner">
<xsl:with-param name="id" select="'237'"/>
</xsl:call-template>


<div id="appro"><xsl:apply-templates select="/root/c_features/feature[@id='103']" /></div>





<marquee id="aderenti" direction="left"><xsl:value-of select="/root/features/feature[@id=26]/items/item/content"/></marquee>

</xsl:template>



</xsl:stylesheet>
