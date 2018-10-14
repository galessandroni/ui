<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:include href="root.xsl" />
<xsl:include href="tools.xsl" />


<!-- ###############################
     RIGHT BAR PCK
     ############################### -->
<xsl:template name="rightBarPck">
<xsl:call-template name="searchPck"/>
<xsl:call-template name="facebookLike">
  <xsl:with-param name="action">recommend</xsl:with-param>
  <xsl:with-param name="layout">button_count</xsl:with-param>
</xsl:call-template>
<xsl:call-template name="tickerPck"/>
<xsl:choose>
<xsl:when test="$pagetype='topic_home'">
<xsl:call-template name="newsPckTopicHome"/>
</xsl:when>

<xsl:when test="$pagetype='article'">
<xsl:variable name="f1" select="/root/features/feature[@id='33']"/>
<xsl:variable name="f2" select="/root/c_features/feature[@id='32']"/>
<div class="pckbox" id="similar">
<xsl:choose>
<xsl:when test="$f1/items">
<h3 class="feature"><xsl:value-of select="$f1/@name"/></h3>
<ul class="items">
<xsl:for-each select="$f1/items/item">
<li>
<div class="item-breadcrumb">
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="topic"/>
<xsl:with-param name="name" select="topic/@name"/>
</xsl:call-template>
</div>
<xsl:call-template name="articleItem">
<xsl:with-param name="a" select="."/>
</xsl:call-template>
</li>
</xsl:for-each>
</ul>
</xsl:when>
<xsl:otherwise>
<h3 class="feature"><xsl:value-of select="$f2/@name"/></h3>
<ul class="items">
<xsl:apply-templates select="$f2/items" mode="mainlist"/>
</ul>
</xsl:otherwise>
</xsl:choose>
</div>
</xsl:when>

<xsl:otherwise>
<xsl:variable name="f" select="/root/c_features/feature[@id='32']"/>
<xsl:if test="$f/items/item">
<div class="pckbox">
<h3 class="feature"><xsl:value-of select="$f/@name"/></h3>
<ul class="items">
<xsl:apply-templates select="$f/items" mode="mainlist"/>
</ul>
</div>
</xsl:if>

</xsl:otherwise>

</xsl:choose>
<xsl:call-template name="share"/>
</xsl:template>



<!-- ###############################
     NEWS PCK TOPIC
     ############################### -->
<xsl:template name="newsPckTopic">
<xsl:if test="/root/features/feature[@id='14']/items">
<div class="pckbox">
<xsl:apply-templates select="/root/features/feature[@id='14']"/>
</div>
</xsl:if>
</xsl:template>



<!-- ###############################
     PRINT
     ############################### -->
<xsl:template name="print">
<li><a target="_blank" title="Prima di stampare questa pagina chiediti se ne puoi fare a meno: l'ambiente ringrazia.">
<xsl:attribute name="href">
<xsl:choose>
<xsl:when test="$preview='1'">preview.php?id_type=14&amp;id=<xsl:value-of select="/root/article/@id"/>&amp;id_topic=<xsl:value-of select="/root/article/topic/@id"/></xsl:when>
<xsl:otherwise><xsl:value-of select="/root/site/@base"/>/tools/print.php?id=<xsl:value-of select="/root/article/@id"/></xsl:otherwise>
</xsl:choose>
</xsl:attribute>
<xsl:value-of select="/root/labels/label[@word='print']/@tr"/></a></li>
</xsl:template>


<!-- ###############################
ARTICLE DOCS
############################### -->
<xsl:template name="articleDocs">
<xsl:param name="docs"/>
<div id="article-docs">
<h3><xsl:value-of select="key('label','attachments')/@tr"/></h3>
<ul class="article-docs">
<xsl:for-each select="$docs/doc">
<li>
<div class="title">
<xsl:call-template name="createLink">
<xsl:with-param name="name" select="@title"/>
<xsl:with-param name="node" select="."/>
</xsl:call-template>
(<xsl:value-of select="concat(file_info/@kb,' Kb - ',key('label','format')/@tr,' ',file_info/@format,')')"/>
</div>
<xsl:if test="@author!='' or source!=''"><div class="notes"><xsl:value-of select="@author"/>
<xsl:if test="source!=''"><xsl:value-of select="concat(' - ',key('label','source')/@tr,': ')"/><xsl:value-of select="source" disable-output-escaping="yes"/></xsl:if></div></xsl:if>
<xsl:if test="description!=''"><div><xsl:value-of select="description" disable-output-escaping="yes"/></div></xsl:if>
<xsl:call-template name="licenceInfo">
<xsl:with-param name="i" select="."/>
</xsl:call-template>
</li>
</xsl:for-each>
</ul>
</div>
</xsl:template>


<!-- ###############################
ARTICLE CONTENT
############################### -->
<xsl:template name="articleContent">
<xsl:param name="a" select="/root/article"/>
<div id="article-content" data-ts="{$a/@ts}">
<xsl:attribute name="class">text-<xsl:value-of select="$a/@text-align"/> clearfix</xsl:attribute>

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

<xsl:call-template name="articleContentNotes">
<xsl:with-param name="a" select="$a"/>
</xsl:call-template>

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

<xsl:if test="$a/books">
<xsl:call-template name="articleBooks">
<xsl:with-param name="node" select="$a/books"/>
</xsl:call-template>
</xsl:if>

<xsl:call-template name="licence">
<xsl:with-param name="i" select="$a"/>
</xsl:call-template>

<xsl:call-template name="articleFooter">
<xsl:with-param name="i" select="$a"/>
</xsl:call-template>

</xsl:otherwise>
</xsl:choose>
</div>
</xsl:template>


<!-- ###############################
     NEWS PCK TOPIC
     ############################### -->
<xsl:template name="newsPckTopicHome">
<xsl:choose>
<xsl:when test="/root/topic/@id_group='10'">
<xsl:if test="/root/features/feature[@id='112']/items">
<div class="pckbox">
<xsl:apply-templates select="/root/features/feature[@id='112']"/>
</div>
</xsl:if>
</xsl:when>
<xsl:otherwise>
<xsl:if test="/root/features/feature[@id='14']/items">
<div class="pckbox">
<xsl:apply-templates select="/root/features/feature[@id='14']"/>
</div>
</xsl:if>
</xsl:otherwise>
</xsl:choose>
</xsl:template>


</xsl:stylesheet>
