<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html" encoding="UTF-8" indent="no" />

<xsl:include href="common.xsl" />

<xsl:variable name="current_page_title" select="/root/image/@caption"/>

<!-- ###############################
     ROOT MATCH
     ############################### -->
<xsl:template match="/">
<html>
<head>
<xsl:call-template name="head"/>
</head>
<body class="{/root/publish/@type}" id="id{/root/publish/@id}">
<xsl:if test="/root/preview"><xsl:call-template name="previewToolbar"/></xsl:if>
<div id="img-wrapper">
<div>
<xsl:attribute name="id"><xsl:value-of select="/root/publish/@type"/>_<xsl:value-of select="/root/publish/@id"/></xsl:attribute>
<xsl:variable name="node" select="/root/image"/>
<img alt="{$node/@caption}" width="{$node/@width}" height="{$node/@height}">
<xsl:attribute name="src">
<xsl:call-template name="createLinkUrl">
<xsl:with-param name="node" select="$node"/>
</xsl:call-template>
</xsl:attribute>
</img>

<div id="caption">
<xsl:value-of select="/root/image/@caption"/>
</div>

<xsl:if test="/root/image/@author!=''">
<div id="author"><xsl:value-of select="/root/image/@author_label"/>: <xsl:value-of select="/root/image/@author"/></div>
</xsl:if>

<xsl:if test="/root/image/@source!=''">
<div id="source"><xsl:value-of select="key('label','source')/@tr"/>: <xsl:value-of select="/root/image/@source"/></div>
</xsl:if>

<xsl:call-template name="licenceInfo">
<xsl:with-param name="i" select="/root/image"/>
</xsl:call-template>

</div>

<form id="window-close"><input type="button" value="{key('label','close_window')/@tr}" onclick="window.close()"/></form>

</div>
</body>
</html>
</xsl:template>


</xsl:stylesheet>
