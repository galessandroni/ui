<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="text" encoding="UTF-8" />

<xsl:include href="common.xsl" />

<xsl:variable name="newsletter_separator"><xsl:text>

=============================

</xsl:text></xsl:variable>

<!-- ###############################
     ROOT MATCH
     ############################### -->
<xsl:template match="/">
<xsl:text>&#10;</xsl:text>
Newsletter <xsl:value-of select="/root/site/@title"/>
<xsl:text>&#10;</xsl:text>
<xsl:value-of select="/root/site/@base"/>
<xsl:text>&#10;</xsl:text>
<xsl:text>&#10;</xsl:text>
<xsl:if test="/root/newsletter/@tot_articles &gt; 0">
<xsl:value-of select="concat(key('label','newsletter_articles')/@tr,' ',/root/newsletter/@last_date)"/>
<xsl:text>&#10;</xsl:text>
<xsl:apply-templates mode="newsletter" select="/root/newsletter/group[@tot_articles &gt; 0]"/>
</xsl:if>

<xsl:if test="/root/newsletter/@tot_events &gt; 0">
<xsl:value-of select="$newsletter_separator"/>
<xsl:call-template name="newsletterEvents"/>
</xsl:if>
<xsl:text>&#10;</xsl:text>
</xsl:template>


<!-- ###############################
     TOPIC GROUP
     ############################### -->
<xsl:template match="group" mode="newsletter">
=== <xsl:value-of select="@name"/> ===
<xsl:value-of select="@description"/>
<xsl:text>&#10;</xsl:text>
<xsl:apply-templates mode="newsletter" select="topics/topic[@tot_articles &gt; 0]"/>
</xsl:template>


<!-- ###############################
     TOPIC
     ############################### -->
<xsl:template match="topic" mode="newsletter">
<xsl:text>&#10;</xsl:text>
** <xsl:call-template name="uppercase">
<xsl:with-param name="text" select="@name"/>
</xsl:call-template>
<xsl:text>&#10;</xsl:text>
<xsl:value-of select="@url"/>
<xsl:text>&#10;</xsl:text>
<xsl:apply-templates mode="newsletter" select="article"/>
<xsl:text>&#10;</xsl:text>
</xsl:template>


<!-- ###############################
     EVENTS
     ############################### -->
<xsl:template name="newsletterEvents">
<xsl:value-of select="key('label','calendar')/@tr"/>: 
<xsl:value-of select="key('label','newsletter_events')/@tr"/>
<xsl:apply-templates select="/root/newsletter/events" mode="newsletter"/>
</xsl:template>


<!-- ###############################
     ARTICLE
     ############################### -->
<xsl:template match="article" mode="newsletter">
<xsl:text>&#10;</xsl:text>
<xsl:if test="halftitle!=''">
<xsl:value-of select="halftitle"/>
<xsl:text>&#10;</xsl:text>
</xsl:if>
<xsl:call-template name="uppercase">
<xsl:with-param name="text" select="headline"/>
</xsl:call-template>
<xsl:text>&#10;</xsl:text>
<xsl:if test="subhead!=''">
<xsl:value-of select="subhead"/>
<xsl:text>&#10;</xsl:text>
</xsl:if>
<xsl:value-of select="@url"/>
<xsl:text>&#10;</xsl:text>
</xsl:template>


<!-- ###############################
     EVENT
     ############################### -->
<xsl:template match="event" mode="newsletter">
<xsl:text>&#10;</xsl:text>
<xsl:value-of select="@start_date"/>
<xsl:text>&#10;</xsl:text>
<xsl:call-template name="uppercase">
<xsl:with-param name="text" select="@event_type"/>
</xsl:call-template>
<xsl:text>&#10;</xsl:text>
<xsl:value-of select="@title"/>
<xsl:text>&#10;</xsl:text>
<xsl:value-of select="@place"/> - <xsl:value-of select="@geo_name"/>
<xsl:text>&#10;</xsl:text>
<xsl:value-of select="@url"/>
</xsl:template>

</xsl:stylesheet>


