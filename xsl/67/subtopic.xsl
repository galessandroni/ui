<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"><xsl:import href="../0/subtopic.xsl" />

<xsl:output method="html" encoding="UTF-8" indent="no" doctype-system="http://www.w3.org/TR/html4/strict.dtd"  doctype-public="-//W3C//DTD HTML 4.01//EN" />

<xsl:include href="common.xsl" />






<!-- ###############################
ARTICLE ITEM
############################### -->
<xsl:template name="articleItem">
<xsl:param name="a"/>
<xsl:param name="show_topic" select="false()"/>
<xsl:param name="show_image" select="true()"/>
<xsl:param name="show_halftitle" select="true()"/>
<xsl:param name="show_path" select="false()"/>
<xsl:param name="show_trad_language" select="false()"/>
<div>
<xsl:attribute name="class">article-item <xsl:if test="$a/@id_template &gt; 0"> article-template<xsl:value-of select="$a/@id_template"/></xsl:if><xsl:if test="$a/@id_language = 6"> lang-rtl</xsl:if>
<xsl:if test="$a/@available=0"> protected</xsl:if></xsl:attribute>
<xsl:if test="$a/image and $show_image=true()">
<xsl:variable name="i" select="$a/image"/>
<xsl:variable name="src">
<xsl:call-template name="createLinkUrl">
<xsl:with-param name="node" select="$i"/>
</xsl:call-template>
</xsl:variable>
<a title="{$a/headline}">
<xsl:attribute name="href">
<xsl:call-template name="createLinkUrl">
<xsl:with-param name="node" select="$a"/>
</xsl:call-template>
</xsl:attribute>
<img width="{$i/@width}" height="{$i/@height}" alt="{$a/headline}" src="{$src}">
<xsl:attribute name="class">
<xsl:choose>
<xsl:when test="$i/@align='0'">right</xsl:when>
<xsl:when test="$i/@align='1'">left</xsl:when>
<xsl:when test="$i/@align='2'">standalone</xsl:when>
</xsl:choose>
</xsl:attribute>
</img>
</a>
</xsl:if>
<xsl:if test="$show_path=true()">
<div class="breadcrumb">In<xsl:text> </xsl:text>
<xsl:if test="topic and not(/root/topic/@id &gt; 0)">
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="topic"/>
<xsl:with-param name="name" select="topic/@name"/>
</xsl:call-template>
<xsl:text> / </xsl:text>
</xsl:if>
<xsl:apply-templates select="breadcrumb" mode="breadcrumb"/>
</div>
</xsl:if>
<xsl:if test="$show_topic=true()">
<div><xsl:value-of select="$a/topic/@name"/></div>
</xsl:if>
<xsl:if test="$a/halftitle!=''">
<div class="halftitle"><xsl:value-of select="$a/halftitle" disable-output-escaping="yes"/></div></xsl:if>

<h3>
<xsl:if test="$show_trad_language=true()"><xsl:value-of select="concat('[',$a/@tr_language,'] ')"/></xsl:if>



<xsl:choose>
<xsl:when test="$a/@available=0">
<xsl:value-of select="$a/headline" disable-output-escaping="yes"/>
</xsl:when>

<xsl:when  test="/root/subtopic/breadcrumb/subtopic/@id='277'">

<xsl:call-template name="createLink">
<xsl:with-param name="name"><xsl:value-of select="$a/headline" disable-output-escaping="yes"/>
</xsl:with-param>
<xsl:with-param name="node" select="$a"/>
</xsl:call-template>

<div class="lettura">
<xsl:call-template name="createLink">
<xsl:with-param name="name"><xsl:text>leggi tutto</xsl:text>
</xsl:with-param>
<xsl:with-param name="node" select="$a"/>
</xsl:call-template>
</div>
</xsl:when>

<xsl:otherwise>

<xsl:call-template name="createLink">
<xsl:with-param name="name"><xsl:value-of select="$a/headline" disable-output-escaping="yes"/>
</xsl:with-param>
<xsl:with-param name="node" select="$a"/>
</xsl:call-template>

</xsl:otherwise>
</xsl:choose>



</h3>
<div class="subhead"><xsl:value-of select="$a/subhead" disable-output-escaping="yes"/></div>
<div class="notes">
<xsl:if test="$a/@show_date='1' and $a/@display_date"><xsl:value-of select="$a/@display_date"/></xsl:if>
<xsl:if test="$a/@show_author='1' and $a/author/@name!=''">
<xsl:if test="$a/@show_date='1' and $a/@display_date"> - </xsl:if>
<xsl:value-of select="$a/author/@name"/>
<xsl:if test="$a/author/@notes!=''"> (<xsl:value-of select="$a/author/@notes"/>)</xsl:if>
</xsl:if>
</div>
</div>
</xsl:template>



























<!-- ###############################
CONTENT
############################### -->
<xsl:template name="content">
<xsl:choose>



<xsl:when test="/root/subtopic/@id='3387' or /root/subtopic/@id='3388'">
<xsl:call-template name="breadcrumb"/>
<div class="header"><xsl:apply-templates select="/root/subtopic/header" /></div>
<xsl:call-template name="subtopics"/>
</xsl:when>



<xsl:when test="/root/subtopic/@id='277'">
<xsl:call-template name="breadcrumb"/>
<xsl:call-template name="subtopic"/>
</xsl:when>

<xsl:when test="/root/subtopic/breadcrumb/subtopic/@id='277'">


<xsl:choose>
<xsl:when test="/root/subtopic/content=true()">
<div class="sottoarchivio1">
<h1><xsl:value-of select="/root/subtopic/@name"/></h1>
<div class="header">
 <xsl:call-template name="subtopicImg"/><div class="he">
<xsl:apply-templates select="/root/subtopic/header" /></div></div>
<xsl:call-template name="breadcrumb"/>
<xsl:call-template name="subtopics"/>
<xsl:call-template name="subtopic"/>
</div>
</xsl:when>




<xsl:otherwise>
<div class="sottoarchivio">
<xsl:call-template name="breadcrumb"/>
<xsl:call-template name="subtopics"/>
<xsl:call-template name="subtopic"/>
</div>

</xsl:otherwise>
</xsl:choose>




</xsl:when>

<xsl:otherwise>
<xsl:call-template name="breadcrumb"/>
<h1><xsl:value-of select="/root/subtopic/@name"/></h1>
<div class="description"><xsl:value-of select="/root/subtopic/@description" disable-output-escaping="yes"/></div>
<div class="header"><xsl:apply-templates select="/root/subtopic/header" /></div>
<xsl:call-template name="subtopic"/>
</xsl:otherwise>
</xsl:choose>

<div class="footer"><xsl:apply-templates select="/root/subtopic/footer" /></div>
</xsl:template>


<!-- ###############################
     RIGHT BAR
     ############################### -->
<xsl:template name="rightBar">
<xsl:param name="a" select="/root/subtopic/content/article"/>
<div class="bordobox">
<xsl:apply-templates select="/root/c_features/feature[@id='156']" /></div>


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

<!-- ###############################
SUBTOPIC img
############################### -->
<xsl:template name="subtopicImg">
<xsl:if test="/root/subtopic/image">
<img width="200"  alt="{/root/subtopic/@name}">
<xsl:attribute name="src">
<xsl:call-template name="createLinkUrl">
<xsl:with-param name="node" select="/root/subtopic/image"/>
</xsl:call-template>
</xsl:attribute>
</img>
</xsl:if>
</xsl:template>



</xsl:stylesheet>
