<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="../0/events.xsl" />

<xsl:output method="html" encoding="UTF-8" indent="no" doctype-system="http://www.w3.org/TR/html4/strict.dtd"  doctype-public="-//W3C//DTD HTML 4.01//EN" />

<xsl:include href="common.xsl" />


<!-- ###############################
EVENTS INFO
############################### -->
<xsl:template name="eventsInfo">
<div id="events-info">

<div id="curr-month">
<h3>
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="$ei/month/prev"/>
<xsl:with-param name="name" select="'&lt;'"/>
<xsl:with-param name="follow" select="false()"/>
</xsl:call-template>
<xsl:text> </xsl:text>
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="$ei/month"/>
<xsl:with-param name="follow" select="false()"/>
<xsl:with-param name="condition" select="$subtype!='month'"/>
</xsl:call-template>
<xsl:text> </xsl:text>
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="$ei/month/next"/>
<xsl:with-param name="name" select="'&gt;'"/>
<xsl:with-param name="follow" select="false()"/>
</xsl:call-template>
</h3>
<table cellpadding="0" cellspacing="0" border="0">
<tr>
<xsl:for-each select="$ei/week/day">
<td class="dow{@dow}"><xsl:value-of select="substring(@dow_name,0,4)"/></td>
</xsl:for-each>
</tr>
<xsl:for-each select="$ei/month/week">
<tr>
<xsl:for-each select="day">
<td>
<xsl:attribute name="class"><xsl:value-of select="@status"/><xsl:if test="@events &gt; 0"> has_events</xsl:if></xsl:attribute>
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="."/>
<xsl:with-param name="name" select="@dom"/>
<xsl:with-param name="follow" select="false()"/>
</xsl:call-template>
</td>
</xsl:for-each>
</tr>
</xsl:for-each>
</table>
</div>

<div id="event-search">
<h3>
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="$ei/search"/>
<xsl:with-param name="name" select="$ei/search/@label"/>
</xsl:call-template>
</h3>
<form method="get" id="event-search-form" accept-charset="{/root/site/@encoding}">
<xsl:attribute name="action">
<xsl:call-template name="createLinkUrl">
<xsl:with-param name="node" select="$ei/search"/>
</xsl:call-template>
</xsl:attribute>
<xsl:if test="$preview='1'">
<input type="hidden" name="id_type" value="5"/>
<input type="hidden" name="subtype" value="search"/>
</xsl:if>
<input type="hidden" name="id_topic" value="{/root/topic/@id}"/>
<input type="text" name="q" value="{/root/events/search/@q}" />
<input type="submit" value="{key('label','search')/@tr}" />
</form>
</div>
</div>

</xsl:template>


<!-- ###############################
RIGHT BAR CALENDAR
############################### -->
<xsl:template name="rightBarCalendar">
<xsl:call-template name="eventsInfo"/>
<xsl:call-template name="nextEvents"/>
</xsl:template>

</xsl:stylesheet>
