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
      <xsl:choose>
        <xsl:when test="/root/publish/@id='0'">
          <xsl:apply-templates select="/root/topics" mode="map">
            <xsl:with-param name="details" select="false()"/>
          </xsl:apply-templates>
          <li class="group">
            <h1 class="cal">
              <xsl:call-template name="createLink">
                <xsl:with-param name="name" select="/root/labels/label[@word='calendar']/@tr"/>
                <xsl:with-param name="node" select="/root/site/events"/>
                <xsl:with-param name="class" select="'icon'"/>
              </xsl:call-template>
            </h1>
          </li>
          <li class="group">
            <h1 class="search">
              <xsl:call-template name="createLink">
                <xsl:with-param name="name" select="/root/labels/label[@word='search_engine']/@tr"/>
                <xsl:with-param name="node" select="/root/site/search"/>
                <xsl:with-param name="class" select="'icon'"/>
              </xsl:call-template>
            </h1>
          </li>
          <li class="group">
            <h1 class="rss">
              <xsl:call-template name="createLink">
                <xsl:with-param name="name" select="'Feeds RSS'"/>
                <xsl:with-param name="node" select="/root/site/feeds"/>
                <xsl:with-param name="class" select="'icon'"/>
              </xsl:call-template>
            </h1>
          </li>
        </xsl:when>
        <xsl:otherwise>
          <xsl:apply-templates select="/root/topics" mode="map"/>
        </xsl:otherwise>
      </xsl:choose>
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
  <xsl:param name="details" select="true()"/>
  <li class="group">
    <h1>
      <xsl:attribute name="class">
        <xsl:call-template name="mapGroups">
          <xsl:with-param name="string" select="'group'"/>
          <xsl:with-param name="id" select="@id"/>
        </xsl:call-template>
      </xsl:attribute>
      <xsl:call-template name="createLink">
        <xsl:with-param name="node" select="."/>
        <xsl:with-param name="class" select="'icon'"/>
      </xsl:call-template>
    </h1>
    <div class="description"><xsl:value-of select="@description"/></div>
    <xsl:if test="topics and $details=true()">
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

