<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html" encoding="UTF-8" indent="no" />

<xsl:include href="common.xsl" />

<xsl:variable name="current_page_title">
<xsl:choose>
<xsl:when test="/root/topic"><xsl:value-of select="/root/topic/@name"/></xsl:when>
<xsl:otherwise><xsl:value-of select="/root/site/@title"/></xsl:otherwise>
</xsl:choose>
 - <xsl:value-of select="key('label','error404_msg')/@tr"/>
</xsl:variable>


<!-- ###############################
     CONTENT
     ############################### -->
<xsl:template name="content">
<h2><xsl:value-of select="key('label','error404_msg')/@tr"/></h2>
<h3><xsl:value-of select="/root/error/@uri"/></h3>
<p>
<xsl:value-of select="key('label','go_back_to')/@tr"/>
<xsl:text> </xsl:text>
<xsl:choose>
<xsl:when test="/root/topic">
<xsl:call-template name="createLink">
<xsl:with-param name="name" select="'homepage'"/>
<xsl:with-param name="node" select="/root/topic"/>
</xsl:call-template>
</xsl:when>
<xsl:otherwise>
<xsl:call-template name="createLink">
<xsl:with-param name="name" select="'homepage'"/>
<xsl:with-param name="node" select="/root/site"/>
</xsl:call-template>
</xsl:otherwise>
</xsl:choose>
</p>
</xsl:template>


</xsl:stylesheet>

