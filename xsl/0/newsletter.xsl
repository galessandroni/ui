<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!--********************************************************************

   PhPeace - Portal Management System

   Copyright notice
   (C) 2003-2017 Francesco Iannuzzelli <francesco@phpeace.org>
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

<xsl:output method="text" encoding="UTF-8" />

<xsl:include href="common.xsl" />

<xsl:variable name="newsletter_separator"><xsl:text>

############################

</xsl:text></xsl:variable>

<xsl:variable name="current_page_title" select="'Newsletter'"/>	

<!-- ###############################
     ROOT MATCH
     ############################### -->
<xsl:template match="/">
<xsl:choose>
<xsl:when test="/root/newsletter/@format='html'"><xsl:call-template name="contentHtml"/></xsl:when>
<xsl:otherwise><xsl:call-template name="contentText"/></xsl:otherwise>
</xsl:choose>
</xsl:template>


<!-- ###############################
     CONTENT HTML
     ############################### -->
<xsl:template name="contentHtml">
<html>
<head>
<title><xsl:value-of select="/root/site/@title"/> - Newsletter "<xsl:value-of select="/root/topic/@name"/>"</title>
<style>
a { text-decoration:none; color:#00a; }
a:hover { text-decoration:underline;  color:#fa0; }
td.articles td { border-top: dashed 1px #444; }
td { font-family: Arial, sans-serif; }
</style>
</head>
<body style="background:#fff;font-family: Arial, sans-serif;">
<h2><xsl:value-of select="/root/site/@title"/> - Newsletter "<xsl:value-of select="/root/topic/@name"/>"</h2>
<p><a href="{/root/topic/@url}"><xsl:value-of select="/root/topic/@url"/></a></p>
<table>
<tr>
<td valign="top" class="articles">
<xsl:if test="/root/newsletter/@tot_articles &gt; 0">
<xsl:if test="/root/newsletter/@ts &gt; 0"><p><xsl:value-of select="concat(key('label','newsletter_articles')/@tr,' ',/root/newsletter/@last_date)"/></p></xsl:if>
<table border="0" cellspacing="0" cellpadding="10" style="border-collapse:collapse;">
<xsl:apply-templates select="/root/newsletter/articles" mode="newsletter_html"/>
</table>
</xsl:if>
</td>
<xsl:if test="/root/newsletter/@tot_events &gt; 0">
<td valign="top">
<table border="0" cellspacing="10" bgcolor="#ddddff">
<tr><td>
<h3><xsl:value-of select="key('label','calendar')/@tr"/></h3>
<p><xsl:value-of select="key('label','newsletter_events')/@tr"/></p>
</td></tr>
<xsl:apply-templates select="/root/newsletter/events" mode="newsletter_html"/>
</table>
</td>
</xsl:if>
</tr>
</table>
</body>
</html>
</xsl:template>


<!-- ###############################
     CONTENT TEXT
     ############################### -->
<xsl:template name="contentText">
<xsl:value-of select="/root/site/@title"/> - Newsletter "<xsl:value-of select="/root/topic/@name"/>"
<xsl:text>&#10;</xsl:text>
<xsl:value-of select="/root/topic/@url"/>
<xsl:text>&#10;</xsl:text>
<xsl:text>&#10;</xsl:text>
<xsl:if test="/root/newsletter/@tot_articles &gt; 0">
<xsl:call-template name="newsletterArticles"/>
</xsl:if>
<xsl:if test="/root/newsletter/@tot_events &gt; 0">
<xsl:value-of select="$newsletter_separator"/>
<xsl:call-template name="newsletterEvents"/>
</xsl:if>
</xsl:template>


<!-- ###############################
     ARTICLES
     ############################### -->
<xsl:template name="newsletterArticles">
<xsl:text>&#10;</xsl:text>
<xsl:value-of select="concat(key('label','newsletter_articles')/@tr,' ',/root/newsletter/@last_date)"/>
<xsl:apply-templates select="/root/newsletter/articles" mode="newsletter"/>
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
<xsl:value-of select="headline_ucase"/>
<xsl:text>&#10;</xsl:text>
<xsl:if test="subhead!=''">
<xsl:value-of select="subhead"/>
<xsl:text>&#10;</xsl:text>
</xsl:if>
<xsl:value-of select="@url"/>
<xsl:text>&#10;</xsl:text>
<xsl:if test="@show_date='1' and @display_date"><xsl:value-of select="@display_date"/></xsl:if>
<xsl:if test="@show_author='1' and author/@name!=''">
<xsl:if test="@show_date='1' and @display_date"> - </xsl:if>
<xsl:value-of select="author/@name"/>
<xsl:if test="author/@notes!=''"> (<xsl:value-of select="author/@notes"/>)</xsl:if>
</xsl:if>
</xsl:template>


<!-- ###############################
     ARTICLE
     ############################### -->
<xsl:template match="article" mode="newsletter_html">
<tr>
<xsl:choose>
<xsl:when test="image">
<td>
<xsl:variable name="src">
<xsl:call-template name="createLinkUrl">
<xsl:with-param name="node" select="image"/>
</xsl:call-template>
</xsl:variable>
<a>
<xsl:if test="@available='1'">
<xsl:attribute name="href">
<xsl:call-template name="createLinkUrl">
<xsl:with-param name="node" select="."/>
</xsl:call-template>
</xsl:attribute>
</xsl:if>
<img width="{image/@width}" height="{image/@height}" alt="{headline}" src="{image/@url}" align="left" border="0"/>
</a>
</td>
<td valign="top">
<xsl:apply-templates select="." mode="newsletter_html_item"/>
</td>
</xsl:when>
<xsl:otherwise>
<td colspan="2">
<xsl:apply-templates select="." mode="newsletter_html_item"/>
</td>
</xsl:otherwise>
</xsl:choose>
</tr>
</xsl:template>


<!-- ###############################
     ARTICLE HTML ITEM
     ############################### -->
<xsl:template match="article" mode="newsletter_html_item">
<xsl:param name="show_topic" select="false()"/>
<xsl:param name="show_path" select="true()"/>
<xsl:if test="$show_path=true()">
<div style="font-size:0.9em;padding:3px;">In<xsl:text> </xsl:text>
<xsl:if test="topic and not(/root/topic/@id &gt; 0)">
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="topic"/>
<xsl:with-param name="name" select="topic/@name"/>
</xsl:call-template>
<xsl:text> / </xsl:text>
</xsl:if>
<xsl:apply-templates select="breadcrumb" mode="breadcrumb"/>
</div>
</xsl:if>

<xsl:if test="halftitle!=''"><div class="halftitle"><xsl:value-of select="halftitle" disable-output-escaping="yes"/></div></xsl:if>

<div style="font-weight:bold;font-size:1.2em;">
<xsl:call-template name="createLink">
<xsl:with-param name="name"><xsl:value-of select="headline" disable-output-escaping="yes"/></xsl:with-param>
<xsl:with-param name="node" select="."/>
</xsl:call-template>
</div>

<div class="subhead"><xsl:value-of select="subhead" disable-output-escaping="yes"/></div>
<div style="font-size:0.9em;font-style:italic;">
<xsl:if test="@show_date='1' and @display_date"><xsl:value-of select="@display_date"/></xsl:if>
<xsl:if test="@show_author='1' and author/@name!=''">
<xsl:if test="@show_date='1' and @display_date"> - </xsl:if>
<xsl:value-of select="author/@name"/>
<xsl:if test="author/@notes!=''"> (<xsl:value-of select="author/@notes"/>)</xsl:if>
</xsl:if>
</div>
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


<!-- ###############################
     EVENT
     ############################### -->
<xsl:template match="event" mode="newsletter_html">
<tr>
<td>
<xsl:value-of select="@start_date"/><br/>
<span style="text-transform:uppercase"><xsl:value-of select="@event_type"/></span><br/>
<span style="font-weight:bold;font-size:1.2em;"><a href="{@url}"><xsl:value-of select="@title"/></a></span><br/>
<xsl:value-of select="@place"/> - <xsl:value-of select="@geo_name"/>
</td>
</tr>
</xsl:template>

</xsl:stylesheet>


