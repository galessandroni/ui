<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="xml" encoding="UTF-8" indent="no" omit-xml-declaration="yes" />

<xsl:include href="common.xsl" />

<!-- ###############################
     ROOT MATCH
     ############################### -->
<xsl:template match="/">
<xsl:choose>
<xsl:when test="/root/@type='article' and /root/article/@id &gt; 0">
<xsl:call-template name="articleItem">
<xsl:with-param name="a" select="/root/article"/>
</xsl:call-template>
</xsl:when>
<xsl:when test="/root/@type='book'">
<xsl:call-template name="bookItem">
<xsl:with-param name="b" select="/root/book"/>
</xsl:call-template>
</xsl:when>
<xsl:when test="/root/@type='book_big'">
<xsl:call-template name="bookItemBig">
<xsl:with-param name="b" select="/root/book"/>
</xsl:call-template>
</xsl:when>
<xsl:when test="/root/@type='quote'">
<xsl:call-template name="quoteItem">
<xsl:with-param name="i" select="/root/quote"/>
</xsl:call-template>
</xsl:when>
<xsl:when test="/root/@type='today'">
<xsl:call-template name="today"/>
</xsl:when>
<xsl:when test="/root/@type='user'">
<xsl:call-template name="userItem">
<xsl:with-param name="u" select="/root/user"/>
</xsl:call-template>
</xsl:when>
<xsl:when test="/root/@type='widget_feature'">
<xsl:call-template name="widgetFeature"/>
</xsl:when>
<xsl:when test="/root/@type='image'">
<xsl:call-template name="galleryImage">
<xsl:with-param name="i" select="/root/gallery_image"/>
<xsl:with-param name="jump_to_link" select="/root/gallery_image/@jump='1'"/>
</xsl:call-template>
</xsl:when>
</xsl:choose>
</xsl:template>


<!-- ###############################
     TODAY
     ############################### -->
<xsl:template name="today">
<div class="today"><xsl:value-of select="/root/today/@label"/></div>
<xsl:if test="/root/history/r_event">
<ul class="items r_events">
<xsl:for-each select="/root/history/r_event">
<li class="r_event-item">
<xsl:call-template name="recurringEventItem">
<xsl:with-param name="e" select="."/>
</xsl:call-template>
</li>
</xsl:for-each>
</ul>
</xsl:if>
</xsl:template>


<!-- ###############################
     WIDGET FEATURE
     ############################### -->
<xsl:template name="widgetFeature">
<xsl:apply-templates select="/root/feature" />
</xsl:template>

</xsl:stylesheet>
