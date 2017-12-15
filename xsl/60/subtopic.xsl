<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"><xsl:import href="../0/subtopic.xsl" />

<xsl:output method="html" encoding="UTF-8" indent="no" doctype-system="http://www.w3.org/TR/html4/strict.dtd"  doctype-public="-//W3C//DTD HTML 4.01//EN" />

<xsl:include href="common.xsl" />


<!-- ###############################
CONTENT
############################### -->
<xsl:template name="content">
<xsl:call-template name="breadcrumb"/>
<h1><xsl:value-of select="/root/subtopic/@name"/></h1>
<div class="description"><xsl:value-of select="/root/subtopic/@description" disable-output-escaping="yes"/></div>

<div class="header"><xsl:apply-templates select="/root/subtopic/header" /></div>
<xsl:call-template name="subtopic"/>
<div class="footer"><xsl:apply-templates select="/root/subtopic/footer" /></div>
</xsl:template>


<!-- ###############################
     RIGHT BAR
     ############################### -->
<xsl:template name="rightBar">
<xsl:param name="a" select="/root/subtopic/content/article"/>
<xsl:choose>
<xsl:when  test="/root/subtopic/breadcrumb/subtopic/@id='489'">
<xsl:apply-templates select="/root/c_features/feature[@id='140']" />
</xsl:when >
<xsl:when  test="/root/subtopic/breadcrumb/subtopic/@id='497'">
<xsl:apply-templates select="/root/c_features/feature[@id='141']" />
</xsl:when >
<xsl:when  test="/root/subtopic/breadcrumb/subtopic/@id='491'">
<xsl:apply-templates select="/root/c_features/feature[@id='142']" />
</xsl:when >
<xsl:when  test="/root/subtopic/breadcrumb/subtopic/@id='513'">
<xsl:apply-templates select="/root/c_features/feature[@id='143']" />
</xsl:when >
<xsl:when  test="/root/subtopic/breadcrumb/subtopic/@id='3251'">
<xsl:apply-templates select="/root/c_features/feature[@id='144']" />
</xsl:when >
<xsl:otherwise>
<xsl:apply-templates select="/root/c_features/feature[@id='140']" /></xsl:otherwise>
</xsl:choose>


<xsl:call-template name="articleContentNotes">
<xsl:with-param name="a" select="$a"/>
</xsl:call-template>

<xsl:if test="$a/docs">
<xsl:call-template name="articleDocs">
<xsl:with-param name="docs" select="$a/docs"/>
</xsl:call-template>
</xsl:if>

<xsl:if test="$a/related">
<xsl:call-template name="related">
<xsl:with-param name="items" select="$a/related"/>
<xsl:with-param name="title" select="key('label','seealso')/@tr"/>
</xsl:call-template>
</xsl:if>

</xsl:template>



<!-- ###############################
ARTICLE CONTENT
############################### -->
<xsl:template name="articleContent">
<xsl:param name="a" select="/root/article"/>
<div id="article-content">
<xsl:attribute name="class">text-<xsl:value-of select="$a/@text-align"/></xsl:attribute>

<xsl:choose>
<xsl:when test="$a/@id_template">
<div class="article-template{$a/@id_template}">
<xsl:call-template name="articleTemplate">
<xsl:with-param name="a" select="$a"/>
<xsl:with-param name="id_template" select="$a/@id_template"/>
</xsl:call-template>
</div>
</xsl:when>
<xsl:otherwise>

<xsl:call-template name="articleContentHeadings">
<xsl:with-param name="a" select="$a"/>
</xsl:call-template>

<xsl:call-template name="articleContentComments">
<xsl:with-param name="a" select="$a"/>
</xsl:call-template>

<xsl:if test="$a/translations">
<xsl:call-template name="articleContentTranslations">
<xsl:with-param name="a" select="$a"/>
</xsl:call-template>
</xsl:if>

<div id="article-text"><xsl:apply-templates select="$a/content"/></div>

<xsl:if test="$a/@id_template">
<xsl:call-template name="articleTemplate">
<xsl:with-param name="a" select="$a"/>
</xsl:call-template>
</xsl:if>

<xsl:if test="$a/translation">
<xsl:call-template name="articleTranslation">
<xsl:with-param name="a" select="$a/translation"/>
</xsl:call-template>
</xsl:if>

<xsl:if test="$a/books">
<xsl:call-template name="articleBooks">
<xsl:with-param name="node" select="$a/books"/>
</xsl:call-template>
</xsl:if>

<xsl:call-template name="licence">
<xsl:with-param name="i" select="$a"/>
</xsl:call-template>

</xsl:otherwise>
</xsl:choose>
</div>
</xsl:template>



</xsl:stylesheet>
