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
<xsl:with-param name="ua-id" select="'UA-27168243-2'" />
</xsl:call-template>
</head>
<body class="{/root/publish/@type}" id="id{/root/publish/@id}">
<xsl:if test="/root/preview"><xsl:call-template name="previewToolbar"/></xsl:if>
<center>
<table width="960" border="0" cellspacing="0" cellpadding="0" id="ssntable">
<tr><td colspan="2"><a>
<xsl:attribute name="href">
<xsl:call-template name="createLinkUrl">
<xsl:with-param name="node" select="/root/topic"/>
</xsl:call-template>
</xsl:attribute>
<xsl:call-template name="graphic">
<xsl:with-param name="id" select="245"/>
</xsl:call-template></a></td></tr>
<tr>
<td valign="top" id="ssnleft">
<xsl:call-template name="navigationMenu"/>
<xsl:call-template name="leftBottom"/>
</td>
<td valign="top" id="ssncenter">
<xsl:call-template name="content"/>
</td></tr>
</table>
</center>
</body>
</html>
</xsl:template>


</xsl:stylesheet>
