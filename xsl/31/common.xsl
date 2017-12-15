<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:include href="root.xsl" />
<xsl:include href="tools.xsl" />


<!-- ###############################
HEAD
############################### -->
<xsl:template name="head">
<xsl:call-template name="metaRobots"/>
<xsl:call-template name="keywordsMeta"/>
<xsl:call-template name="generator"/>
<xsl:variable name="feed_mimetype">
<xsl:choose>
<xsl:when test="/root/site/feeds/@type='3'">atom+xml</xsl:when>
<xsl:otherwise>rss+xml</xsl:otherwise>
</xsl:choose>
</xsl:variable>
<xsl:call-template name="favicon"/>
<xsl:if test="/root/topic">
<link rel="alternate" type="application/{$feed_mimetype}" title="{/root/topic/@name}"
href="{/root/topic/rss/@url}" />
</xsl:if>
<xsl:if test="/root/publish/@global='1'">
<link rel="alternate" type="application/{$feed_mimetype}" title="{/root/site/@title}"
href="{/root/site/rss/@url}" />
</xsl:if>
<title><xsl:call-template name="headPageTitle"/></title>
<xsl:call-template name="css"/>
<xsl:call-template name="javascriptHead"/>
<xsl:call-template name="googleAnalytics">
<xsl:with-param name="ua-id" select="'UA-27168243-4'" />
</xsl:call-template>
</xsl:template>

<!-- ###############################
MENU ITEM
############################### -->
<xsl:template mode="listitem" match="subtopic">
<xsl:param name="level"/>
<li><xsl:attribute name="class">level<xsl:value-of select="$level"/><xsl:if test="@id = /root/subtopic/@id or subtopics/subtopic/@id=/root/subtopic/@id"><xsl:text> </xsl:text>selected</xsl:if></xsl:attribute>
<xsl:if test="$level=2">&gt; </xsl:if>
<xsl:call-template name="createLink">
<xsl:with-param name="name" select="@name"/>
<xsl:with-param name="node" select="."/>
</xsl:call-template>
<xsl:if test="subtopics and $level &lt; 2 and (@id = /root/subtopic/@id or subtopics/subtopic/@id=/root/subtopic/@id)">
<xsl:apply-templates>
<xsl:with-param name="level" select="$level + 1"/>
</xsl:apply-templates>
</xsl:if>
</li>
</xsl:template>


<!-- ###############################
     TOP BAR PCK
    ############################### -->
<xsl:template name="topBarPck">
<div id="logo">
<a>
<xsl:attribute name="href">
<xsl:call-template name="createLinkUrl">
<xsl:with-param name="node" select="/root/topic"/>
</xsl:call-template>
</xsl:attribute>
<xsl:call-template name="graphic">
<xsl:with-param name="id" select="'225'"/>
</xsl:call-template>
</a>
</div>
</xsl:template>
	  
<!-- ###############################
     TOP NAV PCK
    ############################### -->
<xsl:template name="topNavPck">
<div id="cd-search">
<xsl:call-template name="searchForm"/>
</div>
</xsl:template>
	  

<!-- ###############################
     LEFT BAR PCK
 ############################### -->
<xsl:template name="leftBarPck">
<xsl:call-template name="navigationMenu"/>
<xsl:call-template name="leftBottom"/>
</xsl:template>


<!-- ###############################
     BOTTOM BAR PCK
############################### -->
<xsl:template name="bottomBarPck">
<xsl:apply-templates select="/root/c_features/feature[@id='113']" />
</xsl:template>
	   	  

<!-- ###############################
     RIGHT BAR PCK
############################### -->
<xsl:template name="rightBarPck">
<div class="cd-box"><xsl:apply-templates select="/root/c_features/feature[@id=25]"/></div>
<div id="cd-gallery">
<xsl:call-template name="galleryImage">
<xsl:with-param name="i" select="/root/c_features/feature[@id='73']/items/item"/>
</xsl:call-template>
</div>
<xsl:choose>
<xsl:when test="$pagetype='topic_home'"></xsl:when>
<xsl:when test="$pagetype='search'">
<xsl:call-template name="rightBarSearch"/>
</xsl:when>
<xsl:otherwise>
<div class="cd-box"><xsl:apply-templates select="/root/c_features/feature[@id=74]"/></div>
</xsl:otherwise>
</xsl:choose>

</xsl:template>
	  

<!-- ###############################
GALLERY IMAGE
############################### -->
<xsl:template name="galleryImage">
<xsl:param name="i"/>
<xsl:param name="jump_to_link" select="true()"/>
<xsl:variable name="src">
<xsl:call-template name="createLinkUrl">
<xsl:with-param name="node" select="$i/src"/>
</xsl:call-template>
</xsl:variable>
<xsl:choose>
<xsl:when test="$jump_to_link and $i/@link!=''">
<a href="{$i/@link}">
<img width="{$i/@width}" height="{$i/@height}" alt="{$i/@caption}" src="{$src}"/>
</a>
</xsl:when>
<xsl:otherwise>
<a>
<xsl:attribute name="href">
<xsl:call-template name="createLinkUrl">
<xsl:with-param name="node" select="$i/gallery"/>
</xsl:call-template>
</xsl:attribute>
<img width="{$i/@width}" height="{$i/@height}" alt="{$i/@caption}" src="{$src}"/>
</a>
</xsl:otherwise>
</xsl:choose>
</xsl:template>


</xsl:stylesheet>
