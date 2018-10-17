<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html" encoding="UTF-8" indent="no" />

<xsl:include href="common.xsl" />

<xsl:variable name="current_page_title" select="/root/topic/@name"/>


<!-- ###############################
     CONTENT
     ############################### -->
<xsl:template name="content">
  <xsl:call-template name="feedback"/>
  <div class="header"><xsl:apply-templates select="/root/home_header"/></div>
  <xsl:call-template name="topicHome"/>
  <xsl:call-template name="topicEvents"/>
  <div class="footer"><xsl:apply-templates select="/root/home_footer"/></div>
</xsl:template>


<!-- ###############################
     TOPIC HOME
     ############################### -->
<xsl:template name="topicHome">
  <xsl:variable name="hometype" select="/root/topic/@home_type"/>
  <xsl:choose>
    <xsl:when test="$hometype='1' or $hometype='3'">
      <ul class="items">
        <xsl:choose>
          <xsl:when test="/root/topic/@show_path='1'">
            <xsl:apply-templates mode="fulllist" select="/root/items"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:apply-templates mode="mainlist" select="/root/items"/>
          </xsl:otherwise>
        </xsl:choose>
      </ul>
    </xsl:when>
    <xsl:when test="$hometype='5' or $hometype='6'">
      <ul class="items">
        <xsl:apply-templates mode="contentlist" select="/root/items"/>
      </ul>
    </xsl:when>
    <xsl:when test="$hometype='0' or $hometype='2'">
      <xsl:call-template name="articleContent">
        <xsl:with-param name="a" select="/root/article"/>
      </xsl:call-template>
    </xsl:when>
    <xsl:when test="$hometype='4'">
      <xsl:call-template name="subtopic"/>
    </xsl:when>
  </xsl:choose>
</xsl:template>


<!-- ###############################
     TOPIC EVENTS
     ############################### -->
<xsl:template name="topicEvents">
  <xsl:if test="count(/root/events/event) &gt; 0">
    <div class="calendar">
      <div>calendario</div>
        <xsl:call-template name="calendar">
          <xsl:with-param name="root" select="/root/events"/>
        </xsl:call-template>
      </div>
  </xsl:if>
</xsl:template>

</xsl:stylesheet>

