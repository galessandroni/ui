<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="common.xsl" />

<xsl:output method="html" encoding="UTF-8" indent="no" />

<xsl:variable name="current_page_title" select="concat(/root/site/@title,' - RSS Feeds')"/>

<xsl:include href="common_global.xsl" />

<!-- ###############################
     CONTENT
     ############################### -->
<xsl:template name="content">
  <h1 class="icon">Feeds RSS</h1>
  <ul class="feeds">
    <xsl:call-template name="rssItem">
      <xsl:with-param name="node" select="/root/site"/>
      <xsl:with-param name="name" select="/root/site/@title"/>
    </xsl:call-template>
    <li>
      <xsl:call-template name="createLink">
        <xsl:with-param name="name" select="/root/site/events/@label"/>
        <xsl:with-param name="node" select="/root/site/events"/>
      </xsl:call-template>
      - <xsl:value-of select="key('label','next_events')/@tr"/>: 
      <xsl:apply-templates select="/root/site/events" mode="feeds"/>
    </li>
    <xsl:for-each select="/root/site/keywords/rss">
      <li>
        <xsl:value-of select="@name"/>: <xsl:apply-templates select="." mode="feeds"/>
      </li>
    </xsl:for-each>
  </ul>
</xsl:template>


<!-- ###############################
     GROUP
     ############################### -->
<xsl:template match="group" mode="feeds">
  <xsl:call-template name="rssItem">
    <xsl:with-param name="node" select="."/>
  </xsl:call-template>
</xsl:template>


<!-- ###############################
     TOPIC
     ############################### -->
<xsl:template match="topic" mode="feeds">
<xsl:call-template name="rssItem">
<xsl:with-param name="node" select="."/>
<xsl:with-param name="type" select="'topic'"/>
</xsl:call-template>
</xsl:template>


<!-- ###############################
     RSS ITEM
     ############################### -->
<xsl:template name="rssItem">
  <xsl:param name="node"/>
  <xsl:param name="name" select="$node/@name"/>
  <xsl:param name="type" select="'group'"/>
    <li class="{$type}">
      <xsl:if test="$node/rss">
        <xsl:call-template name="createLink">
          <xsl:with-param name="name" select="$name"/>
          <xsl:with-param name="node" select="$node"/>
        </xsl:call-template>
        <xsl:apply-templates select="$node/rss" mode="feeds"/>
      </xsl:if>
    <xsl:if test="$node/topics">
      <ul class="topics">
        <xsl:apply-templates select="$node/topics/topic[@archived='0' and rss]" mode="feeds"/>
      </ul>
    </xsl:if>
    <xsl:if test="$node/groups">
      <ul class="groups">
        <xsl:apply-templates select="$node/groups" mode="feeds"/>
      </ul>
    </xsl:if>
  </li>
</xsl:template>


<!-- ###############################
     RSS 
     ############################### -->
<xsl:template match="rss" mode="feeds">
  <xsl:text>: </xsl:text>
  <xsl:call-template name="createLink">
    <xsl:with-param name="name" select="@url"/>
    <xsl:with-param name="node" select="."/>
  </xsl:call-template>
</xsl:template>


</xsl:stylesheet>

