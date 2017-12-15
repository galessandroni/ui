<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html" encoding="UTF-8" indent="no" doctype-system="http://www.w3.org/TR/html4/strict.dtd"  doctype-public="-//W3C//DTD HTML 4.01//EN" />

<xsl:include href="common.xsl" />

<xsl:include href="common_global.xsl" />

<xsl:variable name="current_page_title" select="concat(/root/site/@title,' - ',key('label','map')/@tr)"/>

<!-- ###############################
     CONTENT
     ############################### -->
<xsl:template name="content">
<xsl:call-template name="breadcrumb"/>
<div id="sitemap">
<ul class="groups">
<xsl:apply-templates select="/root/topics" mode="map">
<xsl:with-param name="level" select="'1'"/>
</xsl:apply-templates>
<xsl:if test="/root/publish/@id='0'">
<li class="group level1">
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="/root/galleries"/>
</xsl:call-template>
<div><xsl:value-of select="/root/galleries/@description"/></div>
<ul class="groups">
<xsl:apply-templates select="/root/galleries" mode="map"/>
</ul>
</li>
<li class="level1">
<xsl:call-template name="createLink">
<xsl:with-param name="name" select="/root/labels/label[@word='calendar']/@tr"/>
<xsl:with-param name="node" select="/root/site/events"/>
</xsl:call-template>
</li>
<li class="level1">
<xsl:call-template name="createLink">
<xsl:with-param name="name" select="/root/labels/label[@word='search_engine']/@tr"/>
<xsl:with-param name="node" select="/root/site/search"/>
</xsl:call-template>
</li>
</xsl:if>
</ul>
</div>
<div id="map-latest">
<!--
<ul class="items">
<xsl:apply-templates mode="fulllist" select="/root/latest"/>
</ul>
-->
</div>
</xsl:template>



<!-- ###############################
     GALLERY
     ############################### -->
<xsl:template match="gallery" mode="map">
<li class="gallery">
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="."/>
</xsl:call-template>
</li>
</xsl:template>


<!-- ###############################
     GROUP
     ############################### -->
<xsl:template match="group" mode="map">
<xsl:param name="level"/>
<li class="group level{$level}">
<xsl:call-template name="createLink">
<xsl:with-param name="name" select="@name"/>
<xsl:with-param name="node" select="."/>
</xsl:call-template>
<div><xsl:value-of select="@description"/></div>
<xsl:if test="topics">
<ul class="topics">
<xsl:apply-templates mode="map" select="topics"/>
</ul>
</xsl:if>
<xsl:if test="galleries">
<ul class="galleries">
<xsl:apply-templates mode="map" select="galleries"/>
</ul>
</xsl:if>
<xsl:if test="groups">
<ul class="groups">
<xsl:apply-templates select="groups" mode="map"/>
</ul>
</xsl:if>
</li>
</xsl:template>


<!-- ###############################
     PAGE TITLE
     ############################### -->
<xsl:template name="pageTitle">
<xsl:if test="$preview=true()">[<xsl:value-of select="/root/labels/label[@word='preview']/@tr"/>]  - </xsl:if>
<xsl:value-of select="/root/site/@title"/><xsl:text> </xsl:text><xsl:value-of select="/root/labels/label[@word='map']/@tr"/>
</xsl:template>


<!-- ###############################
     SUBTOPIC
     ############################### -->
<xsl:template match="subtopic" mode="map">
<li class="subtopic">
<xsl:call-template name="createLink">
<xsl:with-param name="name" select="@name"/>
<xsl:with-param name="node" select="."/>
</xsl:call-template>
<xsl:if test="subtopics">
<ul class="subtopics">
<xsl:apply-templates mode="map" select="subtopics"/>
</ul>
</xsl:if>
</li>
</xsl:template>


<!-- ###############################
     TOPIC
     ############################### -->
<xsl:template match="topic" mode="map">
<li class="topic">
<xsl:call-template name="createLink">
<xsl:with-param name="name" select="@name"/>
<xsl:with-param name="node" select="."/>
</xsl:call-template>
<xsl:if test="description!=''">
<div><xsl:value-of select="description" disable-output-escaping="yes"/></div>
</xsl:if>
<!--
<xsl:if test="subtopics">
<ul class="subtopics">
<xsl:apply-templates mode="map" select="subtopics"/>
</ul>
</xsl:if>
-->
</li>
</xsl:template>

</xsl:stylesheet>

