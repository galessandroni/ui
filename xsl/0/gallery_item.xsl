<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html" encoding="UTF-8" indent="no" />

<xsl:include href="common.xsl" />

<xsl:variable name="current_page_title" select="/root/gallery_image/@caption"/>


<!-- ###############################
     CONTENT
     ############################### -->
<xsl:template name="content">
<xsl:call-template name="breadcrumb"/>
<h1><xsl:value-of select="/root/subtopic/@name"/></h1>
<div class="description"><xsl:value-of select="/root/subtopic/description/text()" disable-output-escaping="yes"/></div>
<xsl:call-template name="galleryImageItem">
<xsl:with-param name="i" select="/root/gallery_image"/>
</xsl:call-template>
</xsl:template>


</xsl:stylesheet>
