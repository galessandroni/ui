<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"><xsl:import href="../0/topic_home.xsl" />

<xsl:output method="html" encoding="UTF-8" indent="no" doctype-system="http://www.w3.org/TR/html4/strict.dtd"  doctype-public="-//W3C//DTD HTML 4.01//EN" />

<xsl:include href="common.xsl" />

<!-- ###############################
GALLERY ITEM
############################### -->
<xsl:template name="galleryItem">

<xsl:param name="i"/>
<xsl:param name="with_details" select="false()"/>
<xsl:if test="$i/aimage">
<img width="342" height="192" alt="{$i/aimage/@caption}">
<xsl:attribute name="src">
<xsl:call-template name="createLinkUrl">
<xsl:with-param name="node" select="$i/aimage"/>
</xsl:call-template>
</xsl:attribute>
</img>
<div id="banda-bianca">
<xsl:call-template name="graphic">
<xsl:with-param name="id" select="301"/>
<xsl:with-param name="format" select="'png'"/>
</xsl:call-template></div>
</xsl:if>
</xsl:template>


<!-- ###############################
TOPIC HOME
############################### -->
<xsl:template name="topicHome">
<xsl:apply-templates select="/root/c_features/feature[@id='146']" />
</xsl:template>

<!-- ###############################
CONTENT
############################### -->
<xsl:template name="content">
<xsl:call-template name="feedback"/>
<xsl:call-template name="topicHome"/>
<xsl:call-template name="topicEvents"/>
<div class="footer"><xsl:apply-templates select="/root/home_footer"/></div>
</xsl:template>

<!-- ###############################
HOME BANNER
############################### -->
<xsl:template name="content-banner">
<div id="content-banner">
<div id="content-banner-left">
<xsl:apply-templates select="/root/features/feature[@id='147']" />
</div>
<div id="content-banner-right">
<xsl:call-template name="randomQuote"/>
</div>
</div>
</xsl:template>

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

<div class="linea">
<div class="breadcrumb-home">
<xsl:value-of select="$a/breadcrumb/subtopic[position()=last()]/@name"/>
</div></div>


<xsl:if test="$a/image and $show_image=true()">
<xsl:variable name="i" select="$a/image"/>
<xsl:variable name="src">
<xsl:call-template name="createLinkUrl">
<xsl:with-param name="node" select="$i"/>
</xsl:call-template>
</xsl:variable>
<a>
<xsl:if test="$a/@available='1'">
<xsl:attribute name="href">
<xsl:call-template name="createLinkUrl">
<xsl:with-param name="node" select="$a"/>
</xsl:call-template>
</xsl:attribute>
</xsl:if>
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

<div class="article-item">


<xsl:if test="$show_topic=true()">
<div><xsl:value-of select="$a/topic/@name"/></div>
</xsl:if>
<xsl:if test="$a/halftitle!=''">
<div class="halftitle"><xsl:value-of select="$a/halftitle" disable-output-escaping="yes"/></div></xsl:if>
<h3>
<xsl:if test="$show_trad_language=true()"><xsl:value-of select="concat('[',$a/@tr_language,'] ')"/></xsl:if>
<xsl:call-template name="createLink">
<xsl:with-param name="name"><xsl:value-of select="$a/headline" disable-output-escaping="yes"/></xsl:with-param>
<xsl:with-param name="node" select="$a"/>
</xsl:call-template>
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
     RIGHT BAR
     ############################### -->
<xsl:template name="rightBar">
<xsl:apply-templates select="/root/c_features/feature[@id='135']" />

<div class="bottom-img">
<a title="Immagini Casa della Pace">
<xsl:attribute name="href">
<xsl:call-template name="createLinkUrl">
<xsl:with-param name="node" select="/root/menu/subtopics//subtopic[@id='485']"/>
</xsl:call-template>
</xsl:attribute>
<xsl:call-template name="graphic">
<xsl:with-param name="id" select="299"/>
<xsl:with-param name="format" select="'gif'"/>
</xsl:call-template>
</a>
<xsl:call-template name="graphic"><xsl:with-param name="id" select="300"/><xsl:with-param name="format" select="'gif'"/></xsl:call-template>
</div>

</xsl:template>



</xsl:stylesheet>
