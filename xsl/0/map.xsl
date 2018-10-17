<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html" encoding="UTF-8" indent="no" />

<xsl:include href="common.xsl" />

<xsl:include href="common_global.xsl" />

<xsl:variable name="current_page_title" select="concat(/root/site/@title,' - ',key('label','map')/@tr)"/>

<!-- ###############################
     CONTENT
     ############################### -->
<xsl:template name="content">
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
    <h1>
      <xsl:attribute name="class">
        <xsl:call-template name="mapGroups">
          <xsl:with-param name="string" select="'icon group'"/>
          <xsl:with-param name="id" select="@id"/>
        </xsl:call-template>
      </xsl:attribute>
      <xsl:value-of select="@name"/>
    </h1>
    <div class="description"><xsl:value-of select="@description"/></div>
    <xsl:if test="topics">
      <ul class="topics">
      <xsl:apply-templates mode="map" select="topics/topic[@archived='0']">
        <xsl:sort select="latest/item/@ts" order="descending"/>
      </xsl:apply-templates>
      </ul>
      <xsl:if test="topics/topic[@archived='1']">
        <h2 class="icon fa-archive">Archivio</h2>
        <ul class="topics">
          <xsl:apply-templates mode="map" select="topics/topic[@archived='1']">
            <xsl:sort select="latest/item/@ts" order="descending"/>
          </xsl:apply-templates>
        </ul>
      </xsl:if>
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
    <h3>
      <xsl:call-template name="createLink">
        <xsl:with-param name="node" select="."/>
        <xsl:with-param name="class" select="'icon'"/>
      </xsl:call-template>
    </h3>
    <xsl:if test="description!=''">
      <div class="description"><xsl:value-of select="description" disable-output-escaping="yes"/></div>
    </xsl:if>
    <xsl:if test="lists/list">
      <xsl:for-each select="lists/list">
        <h4>
          <xsl:call-template name="createLink">
            <xsl:with-param name="name" select="concat('Mailing List ',@name)"/>
            <xsl:with-param name="node" select="."/>
            <xsl:with-param name="class" select="'icon list'"/>
          </xsl:call-template>
          (<xsl:value-of select="@email"/>)
        </h4>
      </xsl:for-each>
    </xsl:if>
    <h4><a class="icon fa-plus-square subtopics-header">Contenuti</a></h4>
    <ul class="subtopics">
      <xsl:apply-templates mode="map" select="subtopics"/>
    </ul>
    <h4><a class="icon fa-plus-square latest-header">Ultimi articoli</a></h4>
    <ul class="items">
      <xsl:for-each select="latest/item">
        <xsl:if test="position() &lt;= 4">
          <li>
            <xsl:if test="position()=4"><xsl:attribute name="class">last</xsl:attribute></xsl:if>
            <xsl:call-template name="articleItem">
              <xsl:with-param name="a" select="."/>
            </xsl:call-template>
          </li>
        </xsl:if>
      </xsl:for-each>
    </ul>
  </li>
</xsl:template>

</xsl:stylesheet>

