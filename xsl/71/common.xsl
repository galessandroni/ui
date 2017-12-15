<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:include href="root.xsl" />
<xsl:include href="tools.xsl" />



<!-- ###############################
SUBTOPIC HIGHLIGHT
############################### -->
<xsl:template name="subtopicHighlight">
<xsl:param name="id_feature"/>
<xsl:variable name="id_highlight" select="/root/features/feature[@id=$id_feature]/items/item/@id"/>
<xsl:if test="/root/subtopic/content/items/@page=1 and /root/features/feature[@id=$id_feature]/items/item">
<xsl:call-template name="subtopicHighlightArticle">
<xsl:with-param name="a" select="/root/features/feature[@id=$id_feature]/items/item"/>
</xsl:call-template>
</xsl:if>
<xsl:call-template name="items2">
<xsl:with-param name="root" select="/root/subtopic/content/items"/>
<xsl:with-param name="node" select="/root/subtopic"/>
<xsl:with-param name="exclude" select="$id_highlight"/>
</xsl:call-template>
</xsl:template>


<!-- ###############################
SUBTOPIC HIGHLIGHT ARTICLE
############################### -->
<xsl:template name="subtopicHighlightArticle">
<xsl:param name="a"/>
<div class="article-highlight">
<xsl:call-template name="articleItem">
<xsl:with-param name="a" select="$a"/>
</xsl:call-template>
</div>
</xsl:template>



<!-- ###############################
SUBTOPIC
############################### -->
<xsl:template name="subtopic">
<xsl:call-template name="feedback"/>
<xsl:variable name="id_type" select="/root/subtopic/@id_type"/>
<xsl:choose>
<xsl:when test="$id_type='1' or $id_type='3' or ($id_type='9' and /root/subtopic/@id_subitem!='2') or $id_type='10' or $id_type='11' or $id_type='15'">

<xsl:choose>
<xsl:when test="/root/subtopic/@id=3504">
<xsl:call-template name="subtopicHighlight">
<xsl:with-param name="id_feature" select="178"/>
</xsl:call-template>
</xsl:when>
<xsl:when test="/root/subtopic/@id=3503">
<xsl:call-template name="subtopicHighlight">
<xsl:with-param name="id_feature" select="180"/>
</xsl:call-template>
</xsl:when>
<xsl:otherwise>
<xsl:call-template name="items">
<xsl:with-param name="root" select="/root/subtopic/content/items"/>
<xsl:with-param name="node" select="/root/subtopic"/>
<xsl:with-param name="showpath" select="$id_type='3'"/>
</xsl:call-template>
</xsl:otherwise>
</xsl:choose>


</xsl:when>
<xsl:when test="$id_type='2'">
<xsl:call-template name="articleContent">
<xsl:with-param name="a" select="/root/subtopic/content/article"/>
</xsl:call-template>
</xsl:when>
<xsl:when test="$id_type='4'">
<ul>
<xsl:choose>
<xsl:when test="/root/subtopic/@id_item &gt; 0">
<xsl:apply-templates select="/root/menu/subtopics//subtopic[@id=/root/subtopic/@id_item]" mode="map"/>
</xsl:when>
<xsl:otherwise>
<xsl:apply-templates select="/root/menu/subtopics" mode="map"/>
</xsl:otherwise>
</xsl:choose>
</ul>
</xsl:when>
<xsl:when test="$id_type='5'">
<xsl:call-template name="contact"/>
</xsl:when>
<xsl:when test="$id_type='9' and /root/subtopic/@id_subitem='2'">
<xsl:call-template name="slideshow">
<xsl:with-param name="id" select="/root/subtopic/content/gallery/@id"/>
<xsl:with-param name="width" select="/root/subtopic/content/gallery/@width"/>
<xsl:with-param name="height" select="/root/subtopic/content/gallery/@height"/>
<xsl:with-param name="images" select="/root/subtopic/content/gallery/@xml"/>
<xsl:with-param name="watermark"><xsl:if test="/root/subtopic/content/gallery/@watermark"><xsl:value-of select="/root/subtopic/content/gallery/@watermark"/></xsl:if></xsl:with-param>
<xsl:with-param name="shuffle" select="/root/subtopic/content/gallery/@shuffle"/>
<xsl:with-param name="bgcolor" select="'0x000000'"/>
<xsl:with-param name="jscaptions" select="true()"/>
</xsl:call-template>
<div id="slide-caption" name="slide-caption" class="gallery-image"></div>
</xsl:when>
<xsl:when test="$id_type='13'">
<xsl:call-template name="subtopicInsert"/>
</xsl:when>
<xsl:when test="$id_type='16'">
<xsl:call-template name="subtopicSearch"/>
</xsl:when>
<xsl:when test="$id_type='18'">
<xsl:call-template name="subtopicDynamic"/>
</xsl:when>
</xsl:choose>
</xsl:template>


<!-- ###############################
     ITEMS
     ############################### -->
<xsl:template name="items2">
<xsl:param name="root"/>
<xsl:param name="node"/>
<xsl:param name="exclude"/>
<xsl:if test="$root/@tot_items">
<xsl:call-template name="paging">
<xsl:with-param name="currentPage" select="$root/@page"/>
<xsl:with-param name="totalPages" select="$root/@tot_pages"/>
<xsl:with-param name="totalItems" select="$root/@tot_items"/>
<xsl:with-param name="label" select="$root/@label"/>
<xsl:with-param name="type" select="'header'"/>
<xsl:with-param name="node" select="$node"/>
</xsl:call-template>
<ul class="items">
<xsl:choose>
<xsl:when test="$exclude &gt; 0">
<xsl:apply-templates mode="mainlist" select="$root/item[@id != $exclude]"/>
</xsl:when>
<xsl:otherwise>
<xsl:apply-templates mode="mainlist" select="$root"/>
</xsl:otherwise>
</xsl:choose>
</ul>
<xsl:call-template name="paging">
<xsl:with-param name="currentPage" select="$root/@page"/>
<xsl:with-param name="totalPages" select="$root/@tot_pages"/>
<xsl:with-param name="totalItems" select="$root/@tot_items"/>
<xsl:with-param name="label" select="$root/@label"/>
<xsl:with-param name="type" select="'footer'"/>
<xsl:with-param name="node" select="$node"/>
</xsl:call-template>
</xsl:if>
</xsl:template>


</xsl:stylesheet>
