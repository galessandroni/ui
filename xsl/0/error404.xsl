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

<xsl:variable name="current_page_title">
<xsl:choose>
<xsl:when test="/root/topic"><xsl:value-of select="/root/topic/@name"/></xsl:when>
<xsl:otherwise><xsl:value-of select="/root/site/@title"/></xsl:otherwise>
</xsl:choose>
 - <xsl:value-of select="key('label','error404_msg')/@tr"/>
</xsl:variable>


<!-- ###############################
     CONTENT
     ############################### -->
<xsl:template name="content">
<h2><xsl:value-of select="key('label','error404_msg')/@tr"/></h2>
<h3><xsl:value-of select="/root/error/@uri"/></h3>
<p>
<xsl:value-of select="key('label','go_back_to')/@tr"/>
<xsl:text> </xsl:text>
<xsl:choose>
<xsl:when test="/root/topic">
<xsl:call-template name="createLink">
<xsl:with-param name="name" select="'homepage'"/>
<xsl:with-param name="node" select="/root/topic"/>
</xsl:call-template>
</xsl:when>
<xsl:otherwise>
<xsl:call-template name="createLink">
<xsl:with-param name="name" select="'homepage'"/>
<xsl:with-param name="node" select="/root/site"/>
</xsl:call-template>
</xsl:otherwise>
</xsl:choose>
</p>
</xsl:template>


</xsl:stylesheet>

