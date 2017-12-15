<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html" encoding="UTF-8" indent="no" doctype-system="http://www.w3.org/TR/html4/strict.dtd"  doctype-public="-//W3C//DTD HTML 4.01//EN" />

<xsl:include href="common.xsl" />

<xsl:variable name="current_page_title" select="/root/geosearch/@label"/>

<!-- ###############################
     CONTENT
     ############################### -->
<xsl:template name="content">
<xsl:call-template name="geoBreadcrumb"/>
<xsl:if test="not(/root/topic)">
<xsl:apply-templates select="/root/features/feature[@id='86']" />
</xsl:if>
<xsl:if test="/root/geosearch/geokeyword/@id &gt; 0">
<h1><xsl:value-of select="/root/geosearch/geokeyword/@name"/></h1>
</xsl:if>
<xsl:if test="/root/geosearch/geokeyword/children">
<div id="geonav">
<ul class="keyword-children" id="k{/root/geosearch/geokeyword/@id}-children">
<xsl:apply-templates select="/root/geosearch/geokeyword/children"/>
</ul>
</div>
</xsl:if>

<xsl:if test="/root/geosearch/geokeyword/articles/@tot_items &gt; 0">
<div id="articles-geosearch">
<xsl:call-template name="items">
<xsl:with-param name="root" select="/root/geosearch/geokeyword/articles"/>
<xsl:with-param name="node" select="/root/geosearch/geokeyword/articles"/>
<xsl:with-param name="showpath" select="true()"/>
</xsl:call-template>
</div>
</xsl:if>

</xsl:template>


<!-- ###############################
     GEO BREADCRUMB
     ############################### -->
<xsl:template name="geoBreadcrumb">
<div class="breadcrumb">
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="/root/geosearch"/>
<xsl:with-param name="name" select="/root/geosearch/@label"/>
</xsl:call-template>
<xsl:for-each select="/root/geosearch/geokeyword/path/geokeyword">
<xsl:value-of select="$breadcrumb_separator"/>
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="."/>
<xsl:with-param name="condition" select="position()!=last()"/>
</xsl:call-template>
</xsl:for-each>
</div>
</xsl:template>


<!-- ###############################
     GEOKEYWORD
     ############################### -->
<xsl:template match="geokeyword">
<li>
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="."/>
</xsl:call-template>
<xsl:if test="children">
<ul class="keyword-children" id="k{@id}-children">
<xsl:apply-templates select="children"/>
</ul>
</xsl:if>
</li>
</xsl:template>


<!-- ###############################
     PAGE TITLE
     ############################### -->
<xsl:template name="pageTitle">
<xsl:if test="$preview=true()">[<xsl:value-of select="/root/labels/label[@word='preview']/@tr"/>] - </xsl:if>
<xsl:value-of select="/root/geosearch/@label"/>
</xsl:template>

</xsl:stylesheet>
