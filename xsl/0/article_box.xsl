<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html" encoding="UTF-8" indent="no" />

<xsl:include href="common.xsl" />

<xsl:variable name="current_page_title" select="/root/box/@title"/>


<!-- ###############################
     ROOT MATCH
     ############################### -->
<xsl:template match="/">
<html>
<head>
<xsl:call-template name="head"/>
</head>
<body>
<div id="box-wrapper" class="abox-type{/root/box/@id_type}">
<div class="{/root/publish/@type}" id="{/root/publish/@id}">
<xsl:if test="/root/box/@show_title='1'"><h1><xsl:value-of select="/root/box/@title"/></h1></xsl:if>
<div id="content"><xsl:apply-templates select="/root/box/content" /></div>
<xsl:if test="/root/box/notes!=''">
<div id="abox-notes"><xsl:value-of select="/root/box/notes" disable-output-escaping="yes"/></div>
</xsl:if>
</div>
<form id="window-close"><input type="button" value="{key('label','close_window')/@tr}" onclick="window.close()"/></form>
</div>
</body>
</html>
</xsl:template>


</xsl:stylesheet>

