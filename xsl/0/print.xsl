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
<xsl:value-of select="key('label','print')/@tr"/> - <xsl:value-of select="/root/article/headline"/>
</xsl:variable>



<!-- ###############################
     ROOT MATCH
     ############################### -->
<xsl:template match="/">
<html>
<head>
<xsl:call-template name="head"/>
</head>
<body>
<div class="{/root/publish/@type}" id="{/root/publish/@id}">
<div id="print-summary">
<div><xsl:value-of select="/root/topic/@name"/>: 
<xsl:for-each select="/root/article/breadcrumb/subtopic">
<xsl:value-of select="@name"/>
<xsl:if test="position() &lt; last()"> / </xsl:if>
</xsl:for-each></div>

<div><xsl:value-of select="/root/article/@url"/></div>

</div>
<div id="print-content"><xsl:call-template name="content" /></div>
</div>
</body>
</html>
</xsl:template>


<!-- ###############################
     CONTENT
     ############################### -->
<xsl:template name="content">
<xsl:call-template name="articleContent" />
</xsl:template>


</xsl:stylesheet>

