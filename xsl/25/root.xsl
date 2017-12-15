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
<div>
<a>
<xsl:attribute name="href">
<xsl:call-template name="createLinkUrl">
<xsl:with-param name="node" select="/root/topic"/>
</xsl:call-template>
</xsl:attribute>
<xsl:call-template name="graphic">
<xsl:with-param name="id" select="'108'"/>
</xsl:call-template>
</a>
</div>
<table width="760" border="0" cellspacing="0" cellpadding="0">
<tr>
<td valign="top" width="120" id="cell-menu">
<div class="left_bar">
<xsl:call-template name="navigationMenu"/>
</div>
<div class="menu_footer">
</div>
</td>
<td width="640" valign="top" id="cell-content">
<xsl:call-template name="content"/>
</td></tr>
</table>
</body>
</html>
</xsl:template>


</xsl:stylesheet>
