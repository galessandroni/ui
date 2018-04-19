<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:content="http://purl.org/rss/1.0/modules/content/" xmlns:dc="http://purl.org/dc/elements/1.1/" >

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

<xsl:output method="xml" encoding="UTF-8" indent="no" omit-xml-declaration="no" />

<xsl:variable name="is_topic" select="boolean(/root/publish/@subtype='topic')"/>

<!-- ###############################
     ROOT
     ############################### -->
<xsl:template match="/" >
<xsl:choose>
<xsl:when test="/root/rss/@type='1' ">
<rdf:RDF xmlns="http://purl.org/rss/1.0/"
         xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<channel rdf:about="{/root/rss/@rss}">
<xsl:call-template name="channelInfoRss1"/>
</channel>
<xsl:apply-templates mode="rss1" select="/root/rss/items"/>
</rdf:RDF>
</xsl:when>
<xsl:when test="/root/rss/@type='2' ">
<rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom">
<channel>
<atom:link href="{/root/rss/@rss}" rel="self" type="application/rss+xml" />
<xsl:call-template name="channelInfoRss2"/>
<xsl:apply-templates mode="rss2" select="/root/rss/items"/>
</channel>
</rss>
</xsl:when>
<xsl:when test="/root/rss/@type='3' ">
<feed xmlns="http://www.w3.org/2005/Atom">
<xsl:call-template name="channelInfoAtom"/>
<xsl:apply-templates mode="atom" select="/root/rss/items"/>
</feed>
</xsl:when>
<xsl:when test="/root/rss/@type='4' ">
<rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom">
<channel>
<atom:link href="{/root/rss/@rss}" rel="self" type="application/rss+xml" />
<xsl:call-template name="channelInfoRss2"/>
<xsl:apply-templates mode="rss2" select="/root/rss/items">
<xsl:with-param name="with_images" select="true()"/>
</xsl:apply-templates>
</channel>
</rss>
</xsl:when>
<xsl:when test="/root/rss/@type='5' ">
<rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom" xmlns:content="http://purl.org/rss/1.0/modules/content/">
<channel>
<atom:link href="{/root/rss/@rss}" rel="self" type="application/rss+xml" />
<xsl:call-template name="channelInfoRss2"/>
<xsl:apply-templates mode="rss2" select="/root/rss/items">
<xsl:with-param name="with_images" select="true()"/>
<xsl:with-param name="with_content" select="true()"/>
</xsl:apply-templates>
</channel>
</rss>
</xsl:when>
</xsl:choose>
</xsl:template>

<!-- ###############################
     CHANNEL INFO RSS1
     ############################### -->
<xsl:template name="channelInfoRss1" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<title><xsl:value-of select="/root/rss/@title"/></title>
<link><xsl:value-of select="/root/rss/@link"/></link>
<description><xsl:value-of select="/root/rss/@description"/></description>
<items>
<rdf:Seq>
<xsl:for-each select="/root/rss/items/item">
<rdf:li resource="{@link}"/>
</xsl:for-each>
</rdf:Seq>
</items>
</xsl:template>


<!-- ###############################
     CHANNEL INFO RSS2
     ############################### -->
<xsl:template name="channelInfoRss2" >
<title><xsl:value-of select="/root/rss/@title"/></title>
<link><xsl:value-of select="/root/rss/@link"/></link>
<description><xsl:value-of select="/root/rss/@description"/></description>
<language><xsl:value-of select="/root/rss/@lang"/></language>
<lastBuildDate><xsl:value-of select="/root/rss/@lastbuild"/></lastBuildDate>
<generator>PhPeace <xsl:value-of select="/root/site/@phpeace"/></generator>
<ttl><xsl:value-of select="/root/rss/@ttl"/></ttl>
</xsl:template>


<!-- ###############################
     CHANNEL INFO (ATOM)
     ############################### -->
<xsl:template name="channelInfoAtom" xmlns="http://www.w3.org/2005/Atom">
<title><xsl:value-of select="/root/rss/@title"/></title>
<link href="{/root/rss/@link}"/>
<link rel="self" type="application/atom+xml" href="{/root/rss/@rss}"/>
<subtitle><xsl:value-of select="/root/rss/@description"/></subtitle>
<updated><xsl:value-of select="/root/rss/@lastbuild"/></updated>
<id><xsl:value-of select="/root/rss/@rss"/></id>
<author><name><xsl:value-of select="/root/rss/@title"/></name></author>
</xsl:template>


<!-- ###############################
     ITEM RSS1
     ############################### -->
<xsl:template match="item" mode="rss1" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns="http://purl.org/rss/1.0/">
<item rdf:about="{@link}">
<title>
<xsl:if test="not($is_topic) and topic/@name!=''"><xsl:value-of select="topic/@name"/>: </xsl:if>
<xsl:value-of select="headline"/></title>
<description><xsl:value-of select="subhead"/></description>
<link><xsl:value-of select="@link"/></link>
</item>
</xsl:template>


<!-- ###############################
     ITEM RSS2
     ############################### -->
<xsl:template match="item" mode="rss2">
<xsl:param name="with_images" select="false()"/>
<xsl:param name="with_content" select="false()"/>
<item>
<xsl:if test="@id_topic &gt; 0">
<category domain="{topic/@url}"><xsl:value-of select="topic/@name"/></category>
</xsl:if>
<title>
<xsl:if test="not($is_topic) and topic/@name!=''"><xsl:value-of select="topic/@name"/>: </xsl:if>
<xsl:value-of select="headline"/></title>
<link><xsl:value-of select="@link"/></link>
<guid><xsl:value-of select="@link"/></guid>
<pubDate><xsl:value-of select="@pubdate"/></pubDate>
<xsl:if test="author"><dc:creator><xsl:value-of select="author/@name"/></dc:creator></xsl:if>
<xsl:choose>
<xsl:when test="$with_images=true() and image">
<description>
<![CDATA[<p><img src="]]><xsl:value-of select="image/@url"/><![CDATA[" alt="" hspace="5" align="left" width="]]><xsl:value-of select="image/@width"/><![CDATA[" height="]]><xsl:value-of select="image/@height"/><![CDATA["/>]]><xsl:value-of select="subhead"/><![CDATA[</p>]]>
</description>
</xsl:when>
<xsl:otherwise>
<description><xsl:value-of select="subhead"/></description>
</xsl:otherwise>   
</xsl:choose>
<xsl:if test="$with_content=true() and content">
<content:encoded>
<xsl:if test="subhead!=''">
<![CDATA[<em>]]><xsl:value-of select="subhead"/><![CDATA[</em>]]>
</xsl:if>
<xsl:apply-templates select="content" mode="rss-fragment"/>
</content:encoded>
</xsl:if>
</item>
</xsl:template>


<!-- ###############################
     ITEM
     ############################### -->
<xsl:template match="item" mode="atom" xmlns="http://www.w3.org/2005/Atom">
<entry>
<title>
<xsl:if test="not($is_topic) and topic/@name!=''"><xsl:value-of select="topic/@name"/>: </xsl:if>
<xsl:value-of select="headline"/></title>
<xsl:if test="subhead!=''"><summary><xsl:value-of select="subhead"/></summary></xsl:if>
<link href="{@link}"/>
<id><xsl:value-of select="@link"/></id>
<updated><xsl:value-of select="@pubdate"/></updated>
<xsl:if test="author/@name!=''"><author><name><xsl:value-of select="author/@name"/></name></author></xsl:if>
</entry>
</xsl:template>


<!-- ###############################
     RSS FRAGMENT
     ############################### -->
<xsl:template match="fragment" mode="rss-fragment">
<xsl:choose>
<xsl:when test="@type='text'">
<xsl:value-of select="text()" disable-output-escaping="yes"/>
</xsl:when>
<xsl:when test="@type='img'">
<xsl:variable name="id_image" select="@id"/>
<xsl:variable name="inode" select="../../images/image[@id=$id_image]"/>
<xsl:variable name="ialign">
<xsl:choose>
<xsl:when test="$inode/@align=0">right</xsl:when>
<xsl:otherwise>left</xsl:otherwise>
</xsl:choose>
</xsl:variable>
<![CDATA[<img src="]]><xsl:value-of select="$inode/@url"/><![CDATA[" alt="" hspace="5" align="]]><xsl:value-of select="$ialign"/><![CDATA[" width="]]><xsl:value-of select="$inode/@width"/><![CDATA[" height="]]><xsl:value-of select="$inode/@height"/><![CDATA["/>]]>
</xsl:when>
</xsl:choose>
</xsl:template>


</xsl:stylesheet>
