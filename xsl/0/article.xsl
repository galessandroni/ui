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

<xsl:variable name="current_page_title" select="/root/article/headline"/>


<!-- ###############################
     CONTENT
     ############################### -->
<xsl:template name="content">
<xsl:call-template name="breadcrumb" />
<xsl:choose>
<xsl:when test="$subtype='thanks' ">
<xsl:call-template name="feedback"/>
<xsl:call-template name="articleItem" >
<xsl:with-param name="a" select="/root/article"/>
</xsl:call-template>
</xsl:when>
<xsl:when test="/root/article/login">
<p>
<xsl:call-template name="createLink">
<xsl:with-param name="name" select="/root/article/login/@label"/>
<xsl:with-param name="node" select="/root/article/login"/>
</xsl:call-template>
</p>
</xsl:when>
<xsl:when test="/root/article/available=0 and /root/topic/@protected=2 and /root/user/@topic_auth=0">
<p>User not authorized</p>
</xsl:when>
<xsl:otherwise>
<xsl:call-template name="toolBar" />
<xsl:call-template name="articleContent" />
</xsl:otherwise>
</xsl:choose>
</xsl:template>


</xsl:stylesheet>

