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

<xsl:variable name="current_page_title" select="/root/image/@caption"/>

<!-- ###############################
     ROOT MATCH
     ############################### -->
<xsl:template match="/">
<html>
<head>
<xsl:call-template name="head"/>
</head>
<body class="{/root/publish/@type}" id="id{/root/publish/@id}">
<xsl:if test="/root/preview"><xsl:call-template name="previewToolbar"/></xsl:if>
<div id="img-wrapper">
<div>
<xsl:attribute name="id"><xsl:value-of select="/root/publish/@type"/>_<xsl:value-of select="/root/publish/@id"/></xsl:attribute>
<xsl:variable name="node" select="/root/image"/>
<img alt="{$node/@caption}" width="{$node/@width}" height="{$node/@height}">
<xsl:attribute name="src">
<xsl:call-template name="createLinkUrl">
<xsl:with-param name="node" select="$node"/>
</xsl:call-template>
</xsl:attribute>
</img>

<div id="caption">
<xsl:value-of select="/root/image/@caption"/>
</div>

<xsl:if test="/root/image/@author!=''">
<div id="author"><xsl:value-of select="/root/image/@author_label"/>: <xsl:value-of select="/root/image/@author"/></div>
</xsl:if>

<xsl:if test="/root/image/@source!=''">
<div id="source"><xsl:value-of select="key('label','source')/@tr"/>: <xsl:value-of select="/root/image/@source"/></div>
</xsl:if>

<xsl:call-template name="licenceInfo">
<xsl:with-param name="i" select="/root/image"/>
</xsl:call-template>

</div>

<form id="window-close"><input type="button" value="{key('label','close_window')/@tr}" onclick="window.close()"/></form>

</div>
</body>
</html>
</xsl:template>


</xsl:stylesheet>
