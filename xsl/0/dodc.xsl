<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html" encoding="UTF-8" indent="no" />

<xsl:include href="common.xsl" />

<xsl:variable name="title">
<xsl:choose>
<xsl:when test="$subtype='search' ">
<xsl:value-of select="key('label','search')/@tr"/>
</xsl:when>
<xsl:otherwise>
<xsl:value-of select="key('label','homepage')/@tr"/>
</xsl:otherwise>
</xsl:choose>
</xsl:variable>

<xsl:variable name="current_page_title" select="concat(/root/modc/@label,' - ',$title)"/>


<!-- ###############################
     CONTENT
     ############################### -->
<xsl:template name="content">
<div class="breadcrumb"><xsl:call-template name="dodcBreadcrumb"/></div>
<xsl:call-template name="feedback"/>
<div id="dodc-content">
<xsl:call-template name="dodcHome"/>
</div>
</xsl:template>


<!-- ###############################
     DODC BREADCRUMB
     ############################### -->
<xsl:template name="dodcBreadcrumb">
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="/root/modc"/>
<xsl:with-param name="name" select="/root/modc/@label"/>
</xsl:call-template>
<xsl:choose>
<xsl:when test="/root/modc/search_terms">
<xsl:value-of select="$breadcrumb_separator"/>
<xsl:call-template name="createLink">
<xsl:with-param name="name" select="key('label','search')/@tr"/>
<xsl:with-param name="node" select="/root/modc/search"/>
</xsl:call-template>
</xsl:when>
<xsl:otherwise>
<xsl:if test="$title!='' ">
<xsl:value-of select="concat($breadcrumb_separator,$title)"/>
</xsl:if>
</xsl:otherwise>
</xsl:choose>
</xsl:template>


<!-- ###############################
     DODC HOME
     ############################### -->
<xsl:template name="dodcHome">
<h2>dodc</h2>
</xsl:template>



</xsl:stylesheet>
