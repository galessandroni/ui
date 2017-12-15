<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!--********************************************************************
Gestito da Francesco, non modificare
********************************************************************-->

<xsl:import href="common.xsl" />

<xsl:output method="html" encoding="UTF-8" indent="no" doctype-system="http://www.w3.org/TR/html4/strict.dtd"  doctype-public="-//W3C//DTD HTML 4.01//EN" />

<xsl:variable name="current_page_title">
<xsl:value-of select="/root/tree/@name"/>
<xsl:if test="/root/gallery/@name"> - <xsl:value-of select="/root/gallery/@name"/></xsl:if>
</xsl:variable>

<!-- ###############################
     CONTENT
     ############################### -->
<xsl:template name="content">
<xsl:call-template name="breadcrumb"/>
<xsl:choose>
<xsl:when test="$subtype='group'">
<xsl:call-template name="galleries">
<xsl:with-param name="node" select="/root/group/galleries"/>
</xsl:call-template>
</xsl:when>
<xsl:when test="$subtype='gallery'">
<xsl:call-template name="items">
<xsl:with-param name="root" select="/root/gallery/images"/>
<xsl:with-param name="node" select="/root/gallery"/>
</xsl:call-template>
<xsl:call-template name="licence">
<xsl:with-param name="i" select="/root/gallery"/>
</xsl:call-template>
</xsl:when>
<xsl:when test="$subtype='slideshow'">
<xsl:call-template name="gallerySlideshow">
<xsl:with-param name="node" select="/root/gallery"/>
</xsl:call-template>
<xsl:call-template name="licence">
<xsl:with-param name="i" select="/root/gallery"/>
</xsl:call-template>
</xsl:when>
<xsl:when test="$subtype='image'">
<xsl:call-template name="galleryImageItem2">
<xsl:with-param name="i" select="/root/gallery/image"/>
</xsl:call-template>
</xsl:when>
</xsl:choose>
</xsl:template>


<!-- ###############################
     GALLERY [summary]
     ############################### -->
<xsl:template match="gallery" mode="summary">
<div id="gallery">
<h2 class="gallery">
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="."/>
<xsl:with-param name="condition" select="$subtype!='gallery'"/>
</xsl:call-template>
</h2>
<xsl:if test="description!=''">
<div class="gallery-description"><xsl:value-of select="description" disable-output-escaping="yes"/></div>
</xsl:if>
<xsl:if test="@date!='' ">
<div class="gallery-date"><xsl:value-of select="concat(/root/labels/label[@word='date']/@tr,': ',@date)"/></div>
</xsl:if>
<xsl:if test="@author!='' ">
<div class="gallery-author"><xsl:value-of select="concat(/root/labels/label[@word='author']/@tr,': ',@author)"/></div>
</xsl:if>
<xsl:if test="@counter!='' ">
<div class="notes"><xsl:value-of select="concat(@counter,' ',/root/labels/label[@word='images']/@tr)"/></div>
</xsl:if>
<h3 class="slideshow">
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="slideshow"/>
<xsl:with-param name="name" select="slideshow/@label"/>
</xsl:call-template>
</h3>
<xsl:call-template name="licenceInfo">
<xsl:with-param name="i" select="."/>
</xsl:call-template>
</div>
</xsl:template>


<!-- ###############################
     GALLERIES
     ############################### -->
<xsl:template name="galleries">
<xsl:param name="node"/>
<ul class="galleries">
<xsl:for-each select="$node/gallery">
<li>
<xsl:call-template name="galleryItem">
<xsl:with-param name="i" select="."/>
<xsl:with-param name="with_details" select="false()"/>
</xsl:call-template>
</li>
</xsl:for-each>
</ul>
</xsl:template>


<!-- ###############################
     LEFT BAR
     ############################### -->
<xsl:template name="leftBar">
<xsl:if test="$subtype!='group' ">
<xsl:apply-templates mode="summary" select="/root/gallery"/>
</xsl:if>
<h2 class="gallery-group">
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="/root/tree"/>
</xsl:call-template>
</h2>
<xsl:apply-templates select="/root/tree/groups"/>
<xsl:call-template name="leftBottom"/>
</xsl:template>


<!-- ###############################
     PAGE TITLE
     ############################### -->
<xsl:template name="pageTitle">
<xsl:if test="$preview=true()">[<xsl:value-of select="/root/labels/label[@word='preview']/@tr"/>] -  </xsl:if><xsl:value-of select="/root/tree/@name"/><xsl:if test="/root/gallery/@name"> - <xsl:value-of select="/root/gallery/@name"/></xsl:if>
</xsl:template>


<!-- ###############################
      MENU ITEM
      ############################### -->
<xsl:template mode="groupitem" match="group">
<xsl:param name="level"/>
<li><xsl:attribute name="class">level<xsl:value-of select="$level"/><xsl:if test="@id = /root/group/@id or @id=/root/gallery/@id_group"><xsl:text> </xsl:text>selected</xsl:if></xsl:attribute>
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="."/>
<xsl:with-param name="name" select="@name"/>
</xsl:call-template>
<xsl:if test="@description!=''">
<div class="group-description"><xsl:value-of select="@description"/></div>
</xsl:if>
<xsl:if test="groups">
<xsl:apply-templates select="groups">
<xsl:with-param name="level" select="$level + 1"/>
</xsl:apply-templates>
</xsl:if>
</li>
</xsl:template>


<!-- ###############################
      MENU ITEMS
      ############################### -->
<xsl:template match="groups">
<xsl:param name="level" select="'1'"/>
<ul class="groups">
<xsl:apply-templates mode="groupitem">
<xsl:with-param name="level" select="$level"/>
</xsl:apply-templates>
</ul>
</xsl:template>


<!-- ###############################
     GALLERY IMAGE ITEM
     ############################### -->
<xsl:template name="galleryImageItem2">
<xsl:param name="i"/>
<xsl:variable name="src">
<xsl:call-template name="createLinkUrl">
<xsl:with-param name="node" select="$i/src"/>
</xsl:call-template>
</xsl:variable>
<div id="prev-next">
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="$i/prev"/>
<xsl:with-param name="name" select="$i/prev/@label"/>
<xsl:with-param name="condition" select="$i/prev/@id &gt; 0"/>
</xsl:call-template> -
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="$i/next"/>
<xsl:with-param name="name" select="$i/next/@label"/>
<xsl:with-param name="condition" select="$i/next/@id &gt; 0"/>
</xsl:call-template>
</div>

<div class="gallery-image">
<xsl:choose>
<xsl:when test="$i/@link!='' ">
<a href="{$i/@link}"><img width="{$i/@width}" height="{$i/@height}" alt="{$i/@caption}" src="{$src}"/></a>
</xsl:when>
<xsl:otherwise>
<img width="{$i/@width}" height="{$i/@height}" alt="{$i/@caption}" src="{$src}"/>
</xsl:otherwise>
</xsl:choose>
<div class="image-info">
<div class="caption"><xsl:value-of select="$i/@caption"/></div>
<xsl:if test="$i/@author!=''">
<div class="author">
<xsl:value-of select="concat(/root/labels/label[@word='author']/@tr,': ',$i/@author)"/>
</div>
</xsl:if>
<xsl:if test="$i/@date!=''">
<div class="image-date">
<xsl:value-of select="concat(/root/labels/label[@word='date']/@tr,': ',$i/@date)"/>
</div>
</xsl:if>
<xsl:if test="$i/@source!=''">
<div class="source">
<xsl:value-of select="concat(/root/labels/label[@word='source']/@tr,': ',$i/@source)"/>
</div>
</xsl:if>
<xsl:if test="$i/file">
<div class="orig">
<div><xsl:call-template name="createLink">
<xsl:with-param name="node" select="$i/file"/>
<xsl:with-param name="name" select="/root/labels/label[@word='download_orig']/@tr"/>
</xsl:call-template></div>
<div><xsl:value-of select="concat($i/file/info/@width,'x',$i/file/info/@height,' px - ',$i/file/info/@kb,' Kb')"/></div>
</div>
</xsl:if>
<xsl:if test="$i/image_footer">
<div class="notes"><xsl:value-of select="$i/image_footer" disable-output-escaping="yes"/></div>
</xsl:if>
</div>
<xsl:call-template name="licence">
<xsl:with-param name="i" select="$i"/>
</xsl:call-template>
</div>
</xsl:template>


<!-- ###############################
     GALLERY SLIDESHOW
     ############################### -->
<xsl:template name="gallerySlideshow">
<xsl:param name="node"/>
<xsl:call-template name="slideshow">
<xsl:with-param name="id" select="$node/@id"/>
<xsl:with-param name="width" select="$node/@width"/>
<xsl:with-param name="height" select="$node/@height"/>
<xsl:with-param name="images" select="$node/@xml"/>
<xsl:with-param name="watermark"><xsl:if test="$node/@watermark"><xsl:value-of select="$node/@watermark"/></xsl:if></xsl:with-param>
<xsl:with-param name="shuffle" select="$node/@shuffle"/>
<xsl:with-param name="bgcolor" select="'0x000000'"/>
<xsl:with-param name="jscaptions" select="true()"/>
</xsl:call-template>
<div id="slide-caption" name="slide-caption" class="gallery-image"></div>
</xsl:template>



</xsl:stylesheet>
