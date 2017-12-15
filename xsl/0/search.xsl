<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!--********************************************************************

   PhPeace - Content Management System for non-profit organisations

   Copyright notice
   (C) 2003-2009 Francesco Iannuzzelli <francesco@peacelink.org>
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

<xsl:output method="html" encoding="UTF-8" indent="no" doctype-system="http://www.w3.org/TR/html4/strict.dtd"  doctype-public="-//W3C//DTD HTML 4.01//EN" />

<xsl:include href="common.xsl" />

<xsl:variable name="search_title">
<xsl:choose>
<xsl:when test="/root/search/@k!=''">
<xsl:choose>
<xsl:when test="/root/search/keyword/@description!=''"><xsl:value-of select="/root/search/keyword/@description"/></xsl:when>
<xsl:otherwise><xsl:value-of select="/root/search/@k"/></xsl:otherwise>
</xsl:choose>
</xsl:when>
<xsl:otherwise>
<xsl:value-of select="/root/site/search/@name"/>: <xsl:value-of select="/root/search/@q"/>
</xsl:otherwise>
</xsl:choose>
</xsl:variable>

<xsl:variable name="current_page_title" select="$search_title"/>


<!-- ###############################
     CONTENT
     ############################### -->
<xsl:template name="content">
<ul class="breadcrumb"><li><xsl:value-of select="$search_title"/></li></ul>

<xsl:call-template name="feedback"/>

<xsl:choose>
<xsl:when test="/root/search">

<p><xsl:value-of select="concat(/root/search/@tot,' ',key('label','results')/@tr)"/>
<xsl:if test="/root/search/@tot &gt; 0">
(
<xsl:if test="/root/search/articles/@tot_items &gt; 0">
<xsl:value-of select="concat(/root/search/articles/@tot_items,' ',/root/search/articles/@label)"/>
</xsl:if>
<xsl:if test="/root/search/events/@tot_items &gt; 0">
<xsl:if test="/root/search/articles/@tot_items &gt; 0"> - </xsl:if>
<xsl:value-of select="concat(/root/search/events/@tot_items,' ',/root/search/events/@label)"/>
</xsl:if>
<xsl:if test="/root/search/books/@tot_items &gt; 0">
<xsl:if test="/root/search/articles/@tot_items &gt; 0 or /root/search/events/@tot_items &gt; 0"> - </xsl:if>
<xsl:value-of select="concat(/root/search/books/@tot_items,' ',/root/search/books/@label)"/>
</xsl:if>
)
</xsl:if>
</p>

<xsl:if test="/root/search/articles/@tot_items &gt; 0">
<div id="articles-search">
<h2><xsl:value-of select="concat(key('label','articles_containing')/@tr,' ' ,/root/search/@q)"/></h2>
<xsl:call-template name="items">
<xsl:with-param name="root" select="/root/search/articles"/>
<xsl:with-param name="node" select="/root/search"/>
<xsl:with-param name="showpath" select="true()"/>
</xsl:call-template>
</div>
</xsl:if>

<xsl:if test="/root/search/books/@tot_items &gt; 0">
<div id="books-search">
<h2><xsl:value-of select="concat(key('label','books_containing')/@tr,' ' ,/root/search/@q)"/></h2>
<xsl:call-template name="items">
<xsl:with-param name="root" select="/root/search/books"/>
<xsl:with-param name="node" select="/root/search"/>
</xsl:call-template>
</div>
</xsl:if>

<xsl:if test="/root/search/articles/suggestions">
<xsl:variable name="searchSuggUrl">
<xsl:choose>
<xsl:when test="/root/topic"><xsl:value-of select="/root/topic/search/@url"/></xsl:when>
<xsl:otherwise><xsl:value-of select="/root/search/@url"/></xsl:otherwise>
</xsl:choose>
</xsl:variable>
<h3>Ricerche simili:</h3>
<ul>
<xsl:for-each select="/root/search/articles/suggestions/search_word/word[@results &gt; 1]">
<li>
<a href="{$searchSuggUrl}&amp;q={@word}"><xsl:value-of select="@word"/></a>
</li>
</xsl:for-each>
</ul>
</xsl:if>

</xsl:when>
<xsl:otherwise>
<xsl:call-template name="searchForm"/>
</xsl:otherwise>
</xsl:choose>

</xsl:template>


<!-- ###############################
     RIGHT BAR SEARCH
     ############################### -->
<xsl:template name="rightBarSearch">
<xsl:if test="/root/search/events/item">
<div id="search-info">
<h2>
<xsl:call-template name="createLink">
<xsl:with-param name="name" select="/root/site/events/@label"/>
<xsl:with-param name="node" select="/root/search/events"/>
</xsl:call-template>
</h2>
<div><xsl:value-of select="key('label','events_containing')/@tr"/><xsl:text> </xsl:text><b><xsl:value-of select="/root/search/@q"/></b></div>
</div>
<xsl:call-template name="events">
<xsl:with-param name="root" select="/root/search/events"/>
</xsl:call-template>
</xsl:if>
</xsl:template>


</xsl:stylesheet>
