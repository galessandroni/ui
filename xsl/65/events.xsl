<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"><xsl:import href="../0/events.xsl" />

<xsl:output method="html" encoding="UTF-8" indent="no" doctype-system="http://www.w3.org/TR/html4/strict.dtd"  doctype-public="-//W3C//DTD HTML 4.01//EN" />

<xsl:include href="common.xsl" />


<!-- ###############################
EVENTS INFO
############################### -->
<xsl:template name="eventsInfo">
<div id="events-info">


<xsl:if test="$ei/insert">
<div id="submit-event">
<h3><xsl:value-of select="key('label','event_submit')/@tr"/></h3>
<div id="submit-event-insert">
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="$ei/insert"/>
<xsl:with-param name="name" select="key('label','event_submit_click')/@tr"/>
</xsl:call-template>
</div></div>
</xsl:if>


<div id="day-week">
<div id="curr-day"><h3><xsl:value-of select="key('label','day')/@tr"/></h3>
<div class="dow"><xsl:value-of select="$ei/curr_day/@dow_name"/></div>
<div class="dom"><xsl:value-of select="$ei/curr_day/@dom"/></div>
<div class="month"><xsl:value-of select="$ei/curr_day/@month_name"/></div>
<div class="year"><xsl:value-of select="$ei/curr_day/@year"/></div>
<!-- <div class="back-today">
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="$ei/today"/>
<xsl:with-param name="name" select="key('label','back_today')/@tr"/>
</xsl:call-template>
</div>-->
</div>

<!-- 
<div id="curr-week">
<h3>
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="$ei/week/prev"/>
<xsl:with-param name="name" select="'&lt;'"/>
<xsl:with-param name="follow" select="false()"/>
</xsl:call-template>
<xsl:text> </xsl:text><xsl:value-of select="key('label','week')/@tr"/><xsl:text> </xsl:text>
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="$ei/week/next"/>
<xsl:with-param name="name" select="'&gt;'"/>
<xsl:with-param name="follow" select="false()"/>
</xsl:call-template>
</h3>
<ul>
<xsl:for-each select="$ei/week/day">
<li class="dow{@dow}">
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="."/>
<xsl:with-param name="name" select="concat(@dow_name,' ',@dom,' ',@month_name)"/>
<xsl:with-param name="follow" select="false()"/>
</xsl:call-template>
</li>
</xsl:for-each>
</ul>
</div>
-->

</div>

<!-- 
<div id="curr-month">
<h3>
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="$ei/month/prev"/>
<xsl:with-param name="name" select="'&lt;'"/>
<xsl:with-param name="follow" select="false()"/>
</xsl:call-template>
<xsl:text> </xsl:text><xsl:value-of select="$ei/month/@name"/><xsl:text> </xsl:text>
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
<td class="{@status}">
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
-->

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
EVENT CONTENT
############################### -->
<xsl:template name="eventContent">
<xsl:param name="e" select="/root/event"/>

<div id="event-content">
<div class="linea">
<div class="event-type"><xsl:value-of select="$e/@event_type"/></div></div>


<div class="event-time">
<xsl:value-of select="$e/@start_date"/>
<xsl:if test="$e/@end_ts &gt; $e/@start_ts"> - <xsl:value-of select="$e/@end_date"/>
</xsl:if>
<xsl:if test="$e/@allday='0'">
<div>
<xsl:value-of select="$e/@start_time"/>
<xsl:if test="$e/@length &gt; 0"> (<xsl:value-of select="key('label','length')/@tr"/>: <xsl:value-of select="$e/@length"/> <xsl:value-of select="key('label','hours')/@tr"/>)</xsl:if></div>
</xsl:if>
</div>

<div class="event-place">
<xsl:value-of select="$e/@place"/>
<xsl:if test="$e/@geo_name"> (<xsl:value-of select="$e/@geo_name"/>)</xsl:if>
<div class="event-place-details"><xsl:value-of select="$e/place_details" disable-output-escaping="yes"/></div>
</div>


<h1><xsl:value-of select="$e/@title"/></h1>

<div class="event-desc"><xsl:value-of select="$e/description"
disable-output-escaping="yes"/></div>

<xsl:call-template name="eventContentFooter"/>

<div class="event-back">
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="$ei/curr_day"/>
<xsl:with-param name="name" select="concat(key('label','back_day')/@tr,' ',$ei/curr_day/@dow_name,' ',$ei/curr_day/@label)"/>
</xsl:call-template>
</div>

</div>
</xsl:template>



<!-- ###############################
RIGHT BAR CALENDAR
############################### -->
<xsl:template name="rightBarCalendar">
<xsl:call-template name="eventsInfo"/>
<xsl:call-template name="eventsHistory"/>
<xsl:call-template name="nextEvents"/>
<xsl:apply-templates select="/root/features/feature[@id='145']" />
<xsl:if test="not(/root/topic)">
<xsl:call-template name="rssLogo">
<xsl:with-param name="node" select="/root/events/info/rss"/>
</xsl:call-template>
</xsl:if>
</xsl:template>


</xsl:stylesheet>
