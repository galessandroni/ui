<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!--********************************************************************

   PhPeace - Portal Management System

   Copyright notice
   (C) 2003-2018 Francesco Iannuzzelli <francesco@phpeace.org>
   All rights reserved

   This script is part of PhPeace.
   PhPeace is free software; you can redistribute it and/or modify 
   it under the terms of the GNU General Public License as 
   published by the Free Software Foundation; either version 2 of 
   the License, or (at your option) any later version.

   PhPeace is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   The GNU General Public License (GPL) is available at
   http://www.gnu.org/copyleft/gpl.html.
   A copy can be found in the file COPYING distributed with 
   these scripts.

   This copyright notice MUST APPEAR in all copies of the script!

********************************************************************-->

<xsl:output method="html" encoding="UTF-8" indent="no" doctype-system="http://www.w3.org/TR/html4/strict.dtd" doctype-public="-//W3C//DTD HTML 4.01//EN" />

<xsl:include href="common.xsl" />

<xsl:variable name="ei" select="/root/events/info"/>

<xsl:variable name="title">
<xsl:choose>
<xsl:when test="/root/publish/@subtype='event'"><xsl:value-of select="/root/event/@start_date"/> - <xsl:value-of select="/root/event/@title"/></xsl:when>
<xsl:when test="/root/publish/@subtype='next'"><xsl:value-of select="key('label','next_events')/@tr"/></xsl:when>
<xsl:when test="/root/publish/@subtype='month'"><xsl:value-of select="concat(/root/events/info/month/@name,' ',/root/events/info/month/@year)"/></xsl:when>
<xsl:when test="/root/publish/@subtype='insert'"><xsl:value-of select="key('label','event_submit')/@tr"/></xsl:when>
<xsl:when test="/root/publish/@subtype='search'"><xsl:value-of select="$ei/search/@label"/></xsl:when>
<xsl:when test="/root/publish/@subtype='day'"><xsl:value-of select="concat(key('label','events_of_day')/@tr,' ',/root/events/info/curr_day/@label)"/></xsl:when>
</xsl:choose>
</xsl:variable>

<xsl:variable name="current_page_title" select="concat(key('label','calendar')/@tr,' - ',$title)"/>



<!-- ###############################
     CONTENT
     ############################### -->
<xsl:template name="content">
<div class="breadcrumb"><xsl:value-of select="$title"/></div>
<xsl:call-template name="feedback"/>
<div id="calendar-content">
<xsl:choose>
<xsl:when test="/root/publish/@subtype='event'">
<xsl:call-template name="dayTopBar"/>
<xsl:call-template name="eventContent"/>
</xsl:when>
<xsl:when test="/root/publish/@subtype='next' or /root/publish/@subtype='month'">
<xsl:call-template name="events">
<xsl:with-param name="root" select="/root/events"/>
</xsl:call-template>
</xsl:when>
<xsl:when test="/root/publish/@subtype='day'">
<xsl:call-template name="dayTopBar"/>
<xsl:call-template name="dayEvents"/>
</xsl:when>
<xsl:when test="/root/publish/@subtype='insert'">
<xsl:call-template name="eventInsert"/>
</xsl:when>
<xsl:when test="/root/publish/@subtype='search'">
<xsl:call-template name="eventSearch"/>
</xsl:when>
</xsl:choose>
</div>
</xsl:template>


<!-- ###############################
     DAY EVENTS
     ############################### -->
<xsl:template name="dayEvents">
<ul class="events">
<xsl:for-each select="/root/events/event">
<li>
<xsl:call-template name="eventItem">
<xsl:with-param name="e" select="."/>
<xsl:with-param name="showDate" select="'false'"/>
</xsl:call-template>
</li>
</xsl:for-each>
</ul>
</xsl:template>


<!-- ###############################
     DAY TOP BAR
     ############################### -->
<xsl:template name="dayTopBar">
<ul class="day-topbar">
<li class="dow{$ei/prev_day/@dow}" id="bar-prev-day">
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="$ei/prev_day"/>
<xsl:with-param name="name" select="concat($ei/prev_day/@dow_name,' ',$ei/prev_day/@dom)"/>
<xsl:with-param name="follow" select="false()"/>
</xsl:call-template>
</li>
<li class="dow{$ei/curr_day/@dow}" id="bar-curr-day">
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="$ei/curr_day"/>
<xsl:with-param name="name" select="concat($ei/curr_day/@dow_name,' ',$ei/curr_day/@label)"/>
<xsl:with-param name="condition"><xsl:if test="/root/event">true</xsl:if></xsl:with-param>
</xsl:call-template>
</li>
<li class="dow{$ei/next_day/@dow}" id="bar-next-day">
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="$ei/next_day"/>
<xsl:with-param name="name" select="concat($ei/next_day/@dow_name,' ',$ei/next_day/@dom)"/>
<xsl:with-param name="follow" select="false()"/>
</xsl:call-template>
</li>
</ul>
</xsl:template>


<!-- ###############################
     EVENT CONTENT
     ############################### -->
<xsl:template name="eventContent">
<xsl:param name="e" select="/root/event"/>
<div id="event-content">

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
<div><xsl:value-of select="$e/place_details" disable-output-escaping="yes"/></div>
</div>

<div class="event-type"><xsl:value-of select="$e/@event_type"/></div>

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
     EVENT CONTENT ARTICLE
     ############################### -->
<xsl:template name="eventContentArticle">
<xsl:param name="e" select="/root/event"/>
<xsl:if test="$e/article">
<div class="event-article"><xsl:value-of select="key('label','see_event_article')/@tr"/>:
<div><xsl:value-of select="$e/article/topic/@name"/>: 
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="$e/article"/>
<xsl:with-param name="name" select="$e/article/headline"/>
</xsl:call-template></div>
</div>
</xsl:if>
</xsl:template>


<!-- ###############################
     EVENT CONTENT FOOTER
     ############################### -->
<xsl:template name="eventContentFooter">
<xsl:call-template name="eventContentNotes"/>
<xsl:call-template name="eventContentArticle"/>
</xsl:template>


<!-- ###############################
     EVENT CONTENT NOTES
     ############################### -->
<xsl:template name="eventContentNotes">
<xsl:param name="e" select="/root/event"/>
<div class="event-notes"><xsl:value-of select="key('label','more_info')/@tr"/>: 
<div><xsl:value-of select="$e/@contact_name"/></div>
<div><xsl:value-of select="$e/@phone"/></div>
<xsl:if test="$e/@email!=''">
<div><a href="mailto:{$e/@email}"><xsl:value-of select="$e/@email"/></a></div>
</xsl:if>
<xsl:if test="$e/@link!=''">
<div><a href="{$e/@link}"><xsl:value-of select="$e/@link"/></a></div>
</xsl:if>
</div>
</xsl:template>


<!-- ###############################
     EVENTS HISTORY
     ############################### -->
<xsl:template name="eventsHistory">
<xsl:if test="$ei/history">
<h3><xsl:value-of select="key('label','anniversaries')/@tr"/></h3>
<ul class="items">
<xsl:for-each select="$ei/history/r_event">
<li class="r_event-item"><xsl:value-of select="@year"/>: <xsl:value-of select="@description"/></li>
</xsl:for-each>
</ul>
</xsl:if>
</xsl:template>


<!-- ###############################
     EVENT INSERT
     ############################### -->
<xsl:template name="eventInsert">
<xsl:choose>
<xsl:when test="/root/publish/@id &gt; 0">
<xsl:value-of select="key('label','insert_thanks')/@tr"/>
</xsl:when>
<xsl:otherwise>
<xsl:call-template name="javascriptForms"/>
<script type="text/javascript">
$().ready(function() {
	$("#event-insert").validate({
		rules: {
			start_date: "required",
			id_event_type: { required: true, min: 1	},
			title: "required",
			place: "required",
			contact_name: "required",
			email: { required: true, email:	true }
		},
		messages: {
			id_event_type: { min: "" }
		}
	});
	$("input#start_date").datepicker({ dateFormat: "dd-mm-yy" });
});
</script>
<p><xsl:value-of select="key('label','insert_event_desc')/@tr"/></p>
<form action="{/root/site/@base}/{/root/site/events/@path}/actions.php" method="post" id="event-insert" accept-charset="{/root/site/@encoding}">
<input type="hidden" name="from" value="event"/>
<xsl:if test="/root/topic">
<input type="hidden" name="id_topic" value="{/root/topic/@id}"/>
</xsl:if>
<fieldset>
<legend><xsl:value-of select="key('label','when')/@tr"/></legend>
<ul class="form-inputs">
<li class="form-notes"><xsl:value-of select="key('label','when_desc')/@tr"/></li>
<xsl:call-template name="formInput">
<xsl:with-param name="varname">start_date</xsl:with-param>
<xsl:with-param name="tr_label" select="key('label','date')/@tr"/>
<xsl:with-param name="size">small</xsl:with-param>
<xsl:with-param name="required" select="true()"/>
</xsl:call-template>
<li><label for="start_date_h" class="required"><xsl:value-of select="key('label','time')/@tr"/></label>
<input name="start_date_h" size="2" value="{/root/events/info/time/@h}"/> : <input name="start_date_i" size="2" value="{/root/events/info/time/@m}"/>
<xsl:text> </xsl:text><xsl:value-of select="key('label','time_format')/@tr"/>
</li>
<xsl:call-template name="formInput">
<xsl:with-param name="varname">length</xsl:with-param>
<xsl:with-param name="size">small</xsl:with-param>
</xsl:call-template>
<xsl:call-template name="formInput">
<xsl:with-param name="varname">allday</xsl:with-param>
<xsl:with-param name="type">checkbox</xsl:with-param>
<xsl:with-param name="label">all_day_long</xsl:with-param>
</xsl:call-template>
</ul>
</fieldset>
<fieldset>
<legend><xsl:value-of select="key('label','what')/@tr"/></legend>
<ul class="form-inputs">
<li>
<label class="required"><xsl:value-of select="key('label','event_type')/@tr"/></label>
<select name="id_event_type">
<option value="0"><xsl:value-of select="key('label','choose_option')/@tr"/></option>
<xsl:for-each select="/root/events/event_types/type">
<option value="{@id}"><xsl:value-of select="@type"/></option>
</xsl:for-each>
</select>
</li>
<xsl:call-template name="formInput">
<xsl:with-param name="varname">title</xsl:with-param>
<xsl:with-param name="required" select="true()"/>
</xsl:call-template>
<xsl:call-template name="formInput">
<xsl:with-param name="varname">description</xsl:with-param>
<xsl:with-param name="type">textarea</xsl:with-param>
</xsl:call-template>
</ul>
</fieldset>
<fieldset>
<legend><xsl:value-of select="key('label','where')/@tr"/></legend>
<ul class="form-inputs">
<xsl:call-template name="formInput">
<xsl:with-param name="varname">place</xsl:with-param>
<xsl:with-param name="label">town</xsl:with-param>
<xsl:with-param name="required" select="true()"/>
</xsl:call-template>
<xsl:call-template name="formInputGeo"/>
<xsl:call-template name="formInput">
<xsl:with-param name="varname">place_details</xsl:with-param>
<xsl:with-param name="label">address_notes</xsl:with-param>
<xsl:with-param name="type">textarea</xsl:with-param>
</xsl:call-template>
</ul>
</fieldset>
<fieldset>
<legend><xsl:value-of select="key('label','who')/@tr"/></legend>
<ul class="form-inputs">
<xsl:call-template name="formInput">
<xsl:with-param name="varname">contact_name</xsl:with-param>
<xsl:with-param name="label">contact_main</xsl:with-param>
<xsl:with-param name="required" select="true()"/>
</xsl:call-template>
<xsl:call-template name="formInput">
<xsl:with-param name="varname">email</xsl:with-param>
<xsl:with-param name="label">email_one</xsl:with-param>
<xsl:with-param name="required" select="true()"/>
</xsl:call-template>
<xsl:call-template name="formInput">
<xsl:with-param name="varname">phone</xsl:with-param>
</xsl:call-template>
</ul>
</fieldset>
<fieldset>
<legend><xsl:value-of select="key('label','more_info')/@tr"/></legend>
<ul class="form-inputs">
<xsl:call-template name="formInput">
<xsl:with-param name="varname">link</xsl:with-param>
<xsl:with-param name="label">link_one</xsl:with-param>
</xsl:call-template>
</ul>
</fieldset>
<ul class="form-inputs">
<xsl:if test="/root/site/@captcha">
<li class="clearfix">
<xsl:call-template name="captchaWrapper"/>
</li>
</xsl:if>
<li class="buttons"><input type="submit" value="{key('label','submit')/@tr}"/></li>
</ul>
</form>
</xsl:otherwise>
</xsl:choose>
</xsl:template>


<!-- ###############################
     EVENT SEARCH
     ############################### -->
<xsl:template name="eventSearch">

<xsl:call-template name="items">
<xsl:with-param name="root" select="/root/events/items"/>
<xsl:with-param name="node" select="/root/events/search"/>
</xsl:call-template>
<form method="get" accept-charset="{/root/site/@encoding}">
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
<ul class="form-inputs">
<xsl:call-template name="formInput">
<xsl:with-param name="varname">q</xsl:with-param>
<xsl:with-param name="label">text</xsl:with-param>
<xsl:with-param name="value" select="/root/events/search/@q"/>
</xsl:call-template>
<xsl:call-template name="formInputGeo">
<xsl:with-param name="currentGeo" select="/root/events/search/@id_geo"/>
</xsl:call-template>
<li><label for="id_etype"><xsl:value-of select="key('label','event_type')/@tr"/></label>
<select name="id_etype">
<option value="0"><xsl:value-of select="key('label','all_option')/@tr"/></option>
<xsl:for-each select="/root/events/event_types/type">
<option value="{@id}">
<xsl:if test="@id=/root/events/search/@id_etype">
<xsl:attribute name="selected">selected</xsl:attribute>
</xsl:if>
<xsl:value-of select="@type"/></option>
</xsl:for-each>
</select>
</li>
<li><label for="period"><xsl:value-of select="key('label','events')/@tr"/></label>
<select name="period">
<option value="0">
<xsl:if test="/root/events/search/@period='0'">
<xsl:attribute name="selected">selected</xsl:attribute>
</xsl:if>
<xsl:value-of select="key('label','all_option')/@tr"/></option>
<option value="1">
<xsl:if test="/root/events/search/@period='1' or not(/root/events/search)">
<xsl:attribute name="selected">selected</xsl:attribute>
</xsl:if>
<xsl:value-of select="key('label','future')/@tr"/></option>
<option value="2">
<xsl:if test="/root/events/search/@period='2'">
<xsl:attribute name="selected">selected</xsl:attribute>
</xsl:if>
<xsl:value-of select="key('label','past')/@tr"/></option>
</select>
</li>
<li class="buttons"><input type="submit" value="{key('label','search')/@tr}"/>
<input type="reset" value="{key('label','reset')/@tr}"/>
</li>
</ul>
</form>
</xsl:template>



<!-- ###############################
     EVENTS INFO
     ############################### -->
<xsl:template name="eventsInfo">
<div id="events-info">

<xsl:if test="$ei/insert">
<div id="submit-event">
<h3><xsl:value-of select="key('label','event_submit')/@tr"/></h3>
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="$ei/insert"/>
<xsl:with-param name="name" select="key('label','event_submit_click')/@tr"/>
</xsl:call-template>
</div>
</xsl:if>

<div id="day-week">
<div id="curr-day"><h3><xsl:value-of select="key('label','day')/@tr"/></h3>
<div class="dow"><xsl:value-of select="$ei/curr_day/@dow_name"/></div>
<div class="dom"><xsl:value-of select="$ei/curr_day/@dom"/></div>
<div class="month"><xsl:value-of select="$ei/curr_day/@month_name"/></div>
<div class="year"><xsl:value-of select="$ei/curr_day/@year"/></div>
<div class="back-today">
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="$ei/today"/>
<xsl:with-param name="name" select="key('label','back_today')/@tr"/>
</xsl:call-template>
</div>
</div>

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

</div>

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
     NEXT EVENTS
     ############################### -->
<xsl:template name="nextEvents">
<xsl:apply-templates select="/root/c_features/feature[@id_user='0' and @id_function='4']"/>
</xsl:template>


<!-- ###############################
     RIGHT BAR CALENDAR
     ############################### -->
<xsl:template name="rightBarCalendar">
<xsl:call-template name="eventsInfo"/>
<xsl:call-template name="eventsHistory"/>
<xsl:call-template name="nextEvents"/>
<xsl:if test="not(/root/topic)">
<xsl:call-template name="rssLogo">
<xsl:with-param name="node" select="/root/events/info/rss"/>
</xsl:call-template>
</xsl:if>
</xsl:template>


</xsl:stylesheet>
