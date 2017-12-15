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
<xsl:call-template name="topNav"/>
<table width="760" border="0" cellspacing="0" cellpadding="0" height="100%" id="mdp">
<tr><td valign="top" width="150" id="left-cell">
<div class="left_bar">
<xsl:call-template name="navigationMenu"/>
</div>
<p>ConflittiDimenticati e' un progetto di Caritas e Pax Christi: loghi, email, contatti... </p>
<div><xsl:call-template name="lastUpdate"/></div>
<div><a href="http://www.caritasitaliana.it">
<xsl:call-template name="graphic">
<xsl:with-param name="id" select="'162'"/>
</xsl:call-template>
</a></div>
<div><a href="http://www.paxchristi.it">
<xsl:call-template name="graphic">
<xsl:with-param name="id" select="'163'"/>
</xsl:call-template>
</a></div> 


</td>
<td width="600" valign="top" id="center">
<xsl:call-template name="content"/>
</td></tr>
</table>
</body>
</html>
</xsl:template>


<!-- ###############################
     TOP NAV
     ############################### -->
<xsl:template name="topNav">
<table border="0" width="760" bordercolor="#4444AA" cellpadding="0" cellspacing="0" id="topbar">
<tr>
<td width="760" bgcolor="#FFFFFF">
<a>
<xsl:attribute name="href">
<xsl:call-template name="createLinkUrl">
<xsl:with-param name="node" select="/root/topic"/>
</xsl:call-template>
</xsl:attribute>
<xsl:call-template name="graphic">
<xsl:with-param name="id" select="'116'"/>
</xsl:call-template>
</a>
</td></tr></table>
</xsl:template>


</xsl:stylesheet>
