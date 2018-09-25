<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html" encoding="UTF-8" indent="no" />

<xsl:include href="common.xsl" />

<xsl:variable name="current_page_title">
<xsl:value-of select="key('label','print')/@tr"/> - <xsl:value-of select="/root/article/headline"/>
</xsl:variable>



<!-- ###############################
     ROOT MATCH
     ############################### -->
<xsl:template match="/">
<html>
<head>
<xsl:call-template name="head"/>
</head>
<body>
<div class="{/root/publish/@type}" id="{/root/publish/@id}">
<div id="print-summary">
<div><xsl:value-of select="/root/topic/@name"/>: 
<xsl:for-each select="/root/article/breadcrumb/subtopic">
<xsl:value-of select="@name"/>
<xsl:if test="position() &lt; last()"> / </xsl:if>
</xsl:for-each></div>

<div><xsl:value-of select="/root/article/@url"/></div>

</div>
<div id="print-content"><xsl:call-template name="content" /></div>
</div>
</body>
</html>
</xsl:template>


<!-- ###############################
     CONTENT
     ############################### -->
<xsl:template name="content">
<xsl:call-template name="articleContent" />
</xsl:template>


</xsl:stylesheet>

