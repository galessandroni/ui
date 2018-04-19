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

<xsl:variable name="title">
<xsl:choose>
<xsl:when test="/root/meeting">
<xsl:value-of select="/root/meeting/@title"/>
</xsl:when>
<xsl:otherwise>
<xsl:value-of select="key('label','homepage')/@tr"/>
</xsl:otherwise>
</xsl:choose>
</xsl:variable>

<xsl:variable name="current_page_title" select="concat(/root/meet/@label,' - ',$title)"/>

<!-- ###############################
     CONTENT
     ############################### -->
<xsl:template name="content">
<xsl:call-template name="meetingBreadcrumb"/>
<xsl:call-template name="feedback"/>
<div id="meet-content">
<xsl:if test="/root/meet/login">
<xsl:call-template name="loginFirst">
<xsl:with-param name="node" select="/root/meet/login"/>
</xsl:call-template>
</xsl:if>
<xsl:choose>
<xsl:when test="$subtype='home'">
<ul>
<xsl:for-each select="/root/meet/meetings/items/item">
<li>
<xsl:call-template name="meetingItem">
<xsl:with-param name="i" select="."/>
</xsl:call-template>
</li>
</xsl:for-each>
</ul>
</xsl:when>
<xsl:when test="$subtype='meeting'">
<xsl:call-template name="meetingDetails"/>
</xsl:when>
<xsl:when test="$subtype='participants'">
<xsl:call-template name="meetingParticipants"/>
</xsl:when>
<xsl:when test="$subtype='subscribe' and /root/meet/meeting/@status='1'">
<xsl:call-template name="meetingSubscribe"/>
</xsl:when>
</xsl:choose>
</div>
</xsl:template>


<!-- ###############################
     MEETING BREADCRUMB
     ############################### -->
<xsl:template name="meetingBreadcrumb">
<div class="breadcrumb">
<xsl:choose>
<xsl:when test="/root/meet/meeting">
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="/root/meet/meeting"/>
<xsl:with-param name="name" select="/root/meet/meeting/@title"/>
<xsl:with-param name="condition" select="$subtype!='meeting'"/>
</xsl:call-template>
<xsl:if test="$subtype='participants'">
<xsl:value-of select="$breadcrumb_separator"/>
<xsl:value-of select="/root/meet/meeting/participants/@label"/>
</xsl:if>
<xsl:if test="$subtype='subscribe'">
<xsl:value-of select="$breadcrumb_separator"/>
<xsl:value-of select="/root/meet/meeting/subscribe/@label"/>
</xsl:if>
</xsl:when>
<xsl:otherwise><xsl:value-of select="/root/meet/@label"/></xsl:otherwise>
</xsl:choose>
</div>
</xsl:template>


<!-- ###############################
     MEETING DETAILS
     ############################### -->
<xsl:template name="meetingDetails">
<xsl:variable name="me" select="/root/meet/meeting"/>
<h1><xsl:value-of select="$me/@title"/></h1>
<xsl:if test="$me/@status='2'">
<p class="over"><xsl:value-of select="$me/@over_label"/></p>
</xsl:if>
<div class="description"><xsl:value-of select="$me/description" disable-output-escaping="yes"/></div>
<xsl:if test="$me/slots/@num &gt; 0">
<ul class="meeting-slots">
<xsl:for-each select="$me/slots/slot">
<li>
<div class="meeting-time"><xsl:value-of select="@start_date"/> - <xsl:value-of select="@start_time"/></div>
<h3><xsl:value-of select="@title"/></h3>
<div class="description"><xsl:value-of select="description" disable-output-escaping="yes"/></div>
</li>
</xsl:for-each>
</ul>
</xsl:if>
<xsl:if test="$me/participants">
<h3>
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="$me/participants"/>
<xsl:with-param name="name" select="$me/participants/@label"/>
</xsl:call-template>
</h3>
</xsl:if>
<xsl:if test="$me/subscribe">
<h3>
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="$me/subscribe"/>
<xsl:with-param name="name" select="$me/subscribe/@label"/>
</xsl:call-template>
</h3>
</xsl:if>
</xsl:template>


<!-- ###############################
     MEETING PARTICIPANTS
     ############################### -->
<xsl:template name="meetingParticipants">
<xsl:variable name="me" select="/root/meet/meeting"/>
<h1>
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="$me"/>
<xsl:with-param name="name" select="$me/@title"/>
</xsl:call-template>
</h1>
<xsl:if test="$me/slots/slot/participants">
<ul class="meeting-slots">
<xsl:for-each select="$me/slots/slot">
<li>
<div class="meeting-time"><xsl:value-of select="@start_date"/> - <xsl:value-of select="@start_time"/></div>
<h3><xsl:value-of select="@title"/> (<xsl:value-of select="@num_participants"/>)</h3>
<xsl:if test="participants">
<ul class="participants">
<xsl:for-each select="participants/participant">
<li><xsl:value-of select="@name"/></li>
</xsl:for-each>
</ul>
</xsl:if>
</li>
</xsl:for-each>
</ul>
</xsl:if>
<xsl:if test="$me/subscribe">
<h3>
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="$me/subscribe"/>
<xsl:with-param name="name" select="$me/subscribe/@label"/>
</xsl:call-template>
</h3>
</xsl:if>
</xsl:template>


<!-- ###############################
     MEETING SUBSCRIBE
     ############################### -->
<xsl:template name="meetingSubscribe">
<xsl:variable name="me" select="/root/meet/meeting"/>
<h1>
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="$me"/>
<xsl:with-param name="name" select="$me/@title"/>
</xsl:call-template>
</h1>
<xsl:if test="$me/slots/slot">
<form action="{/root/meet/@submit}" method="post" id="meet-form-{$me/@id}" class="meet-form" accept-charset="{/root/site/@encoding}">
<input type="hidden" name="from" value="meeting"/>
<input type="hidden" name="action" value="subscribe"/>
<input type="hidden" name="id_meeting" value="{$me/@id}"/>
<input type="hidden" name="id_topic" value="{/root/topic/@id}"/>

<ul class="meeting-slots">
<xsl:for-each select="$me/slots/slot">
<xsl:variable name="user_status" select="user/@status"/>
<li>
<div class="meeting-time"><xsl:value-of select="@start_date"/> - <xsl:value-of select="@start_time"/></div>
<h3><xsl:value-of select="@title"/><xsl:if test="@num_participants"> (<xsl:value-of select="@num_participants"/>)</xsl:if></h3>
<div class="description"><xsl:value-of select="description" disable-output-escaping="yes"/></div>
<ul class="form-inputs">
<li>
<label><xsl:value-of select="key('label','participation')/@tr"/></label>
<select name="slot{@id}_join">
<xsl:for-each select="$me/statuses/status"><option value="{@id}">
<xsl:if test="@id=$user_status"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>
<xsl:value-of select="@value"/></option></xsl:for-each>
</select>
</li>
<xsl:call-template name="formInput">
<xsl:with-param name="varname">slot<xsl:value-of select="@id"/>_comments</xsl:with-param>
<xsl:with-param name="label">comments</xsl:with-param>
<xsl:with-param name="type">textarea</xsl:with-param>
<xsl:with-param name="value" select="user/comments"/>
</xsl:call-template>
</ul>
</li>
</xsl:for-each>
<ul class="form-inputs">
<li class="buttons"><input type="submit" value="{key('label','submit')/@tr}"/></li>
</ul>
</ul>
</form>
</xsl:if>
</xsl:template>


<!-- ###############################
     MEETING ITEM
     ############################### -->
<xsl:template name="meetingItem">
<xsl:param name="i"/>
<h3>
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="$i"/>
<xsl:with-param name="name" select="$i/@title"/>
</xsl:call-template>
</h3>
<div class="description"><xsl:value-of select="$i/description" disable-output-escaping="yes"/></div>
</xsl:template>


</xsl:stylesheet>
