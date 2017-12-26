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

<xsl:output method="html" encoding="UTF-8" indent="no" doctype-system="http://www.w3.org/TR/html4/strict.dtd" doctype-public="-//W3C//DTD HTML 4.01//EN" />

<xsl:include href="common.xsl" />

<xsl:variable name="title">
<xsl:choose>
<xsl:when test="$subtype='search' ">
<xsl:value-of select="key('label','search')/@tr"/>
</xsl:when>
<xsl:otherwise>
<xsl:value-of select="key('label','homepage')/@tr"/>
</xsl:otherwise>
</xsl:choose>
</xsl:variable>

<xsl:variable name="current_page_title" select="concat(/root/modc/@label,' - ',$title)"/>


<!-- ###############################
     CONTENT
     ############################### -->
<xsl:template name="content">
<div class="breadcrumb"><xsl:call-template name="dodcBreadcrumb"/></div>
<xsl:call-template name="feedback"/>
<div id="dodc-content">
<xsl:call-template name="dodcHome"/>
</div>
</xsl:template>


<!-- ###############################
     DODC BREADCRUMB
     ############################### -->
<xsl:template name="dodcBreadcrumb">
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="/root/modc"/>
<xsl:with-param name="name" select="/root/modc/@label"/>
</xsl:call-template>
<xsl:choose>
<xsl:when test="/root/modc/search_terms">
<xsl:value-of select="$breadcrumb_separator"/>
<xsl:call-template name="createLink">
<xsl:with-param name="name" select="key('label','search')/@tr"/>
<xsl:with-param name="node" select="/root/modc/search"/>
</xsl:call-template>
</xsl:when>
<xsl:otherwise>
<xsl:if test="$title!='' ">
<xsl:value-of select="concat($breadcrumb_separator,$title)"/>
</xsl:if>
</xsl:otherwise>
</xsl:choose>
</xsl:template>


<!-- ###############################
     DODC HOME
     ############################### -->
<xsl:template name="dodcHome">
<h2>dodc</h2>
</xsl:template>



</xsl:stylesheet>
