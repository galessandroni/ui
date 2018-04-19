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

<xsl:variable name="current_page_title" select="/root/topic/@name"/>


<!-- ###############################
     CONTENT
     ############################### -->
<xsl:template name="content">
<xsl:call-template name="feedback"/>
<div class="header"><xsl:apply-templates select="/root/home_header"/></div>
<xsl:call-template name="topicHome"/>
<xsl:call-template name="topicEvents"/>
<div><xsl:call-template name="lastUpdate"/></div>
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

