<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html" encoding="UTF-8" indent="no" />

<xsl:include href="common.xsl" />

<xsl:variable name="current_page_title">
<xsl:choose>
<xsl:when test="$subtype='video' ">
<xsl:value-of select="key('label','videos')/@tr"/> - <xsl:value-of select="/root/video/@title"/>
</xsl:when>
<xsl:when test="$subtype='audio' ">
<xsl:value-of select="key('label','audios')/@tr"/><xsl:if test="/root/audio"> - <xsl:value-of select="/root/audio/@title"/></xsl:if>
</xsl:when>
<xsl:otherwise>
<xsl:value-of select="key('label','homepage')/@tr"/>
</xsl:otherwise>
</xsl:choose>
</xsl:variable>


<!-- ###############################
     CONTENT
     ############################### -->
<xsl:template name="content">
<xsl:call-template name="mediaBreadcrumb"/>
<xsl:call-template name="feedback"/>
<div id="media-content" class="media-{$subtype}">
<xsl:choose>
<xsl:when test="$subtype='video'">
<xsl:if test="/root/video"><xsl:call-template name="video"/></xsl:if>
</xsl:when>
<xsl:when test="$subtype='audio' and /root/audio">
<xsl:if test="/root/audio"><xsl:call-template name="audio"/></xsl:if>
</xsl:when>
<xsl:when test="$subtype='audio' and not(/root/audio)">
<xsl:call-template name="audioHome"/>
</xsl:when>
<xsl:otherwise>
<xsl:call-template name="mediaHome"/>
</xsl:otherwise>
</xsl:choose>
</div>
</xsl:template>


<!-- ###############################
     MEDIA BREADCRUMB
     ############################### -->
<xsl:template name="mediaBreadcrumb">
<div class="breadcrumb">
<xsl:choose>
<xsl:when test="$subtype='video' ">
<xsl:call-template name="createLink">
<xsl:with-param name="name" select="key('label','videos')/@tr"/>
<xsl:with-param name="node" select="/root/videos"/>
</xsl:call-template>
<xsl:value-of select="$breadcrumb_separator"/>
<xsl:value-of select="/root/video/@title"/>
</xsl:when>
<xsl:when test="$subtype='audio' ">
<xsl:call-template name="createLink">
<xsl:with-param name="name" select="key('label','audios')/@tr"/>
<xsl:with-param name="node" select="/root/audios"/>
</xsl:call-template>
<xsl:if test="/root/audio">
<xsl:value-of select="$breadcrumb_separator"/>
<xsl:value-of select="/root/audio/@title"/>
</xsl:if>
</xsl:when>
<xsl:otherwise>
<xsl:call-template name="createLink">
<xsl:with-param name="name" select="key('label','videos')/@tr"/>
<xsl:with-param name="node" select="/root/videos"/>
</xsl:call-template>
</xsl:otherwise>

</xsl:choose>
</div>
</xsl:template>


<!-- ###############################
     MEDIA HOME
     ############################### -->
<xsl:template name="mediaHome">
<xsl:call-template name="items">
<xsl:with-param name="root" select="/root/videos/items"/>
<xsl:with-param name="node" select="/root/videos"/>
</xsl:call-template>
</xsl:template>


<!-- ###############################
     AUDIO HOME
     ############################### -->
<xsl:template name="audioHome">
<xsl:call-template name="items">
<xsl:with-param name="root" select="/root/audios/items"/>
<xsl:with-param name="node" select="/root/audios"/>
</xsl:call-template>
</xsl:template>


<!-- ###############################
     VIDEO
     ############################### -->
<xsl:template name="video">
<xsl:call-template name="videoNode">
<xsl:with-param name="node" select="/root/video"/>
</xsl:call-template>
<div class="video-info">
<h1><xsl:value-of select="/root/video/@title"/></h1>
<xsl:if test="/root/video/@length"><div class="length"><xsl:value-of select="concat(key('label','length')/@tr,': ',/root/video/@length)"/></div></xsl:if>
<xsl:if test="/root/video/@author"><div class="author"><xsl:value-of select="concat(key('label','author')/@tr,': ',/root/video/@author)"/></div></xsl:if>
<xsl:if test="/root/video/@date"><div class="date"><xsl:value-of select="concat(key('label','date')/@tr,': ',/root/video/@date)"/></div></xsl:if>
<xsl:if test="/root/video/source"><div class="source"><xsl:value-of select="concat(key('label','source')/@tr,': ',/root/video/source)" disable-output-escaping="yes"/></div></xsl:if>
<div class="views"><xsl:value-of select="concat(key('label','views')/@tr,': ',/root/video/@views)"/></div>
<xsl:if test="/root/video/description"><p class="description"><xsl:value-of select="/root/video/description" disable-output-escaping="yes"/></p></xsl:if>
<xsl:call-template name="licence">
<xsl:with-param name="i" select="/root/video"/>
</xsl:call-template>
</div>
<div class="video-embed">
<form>
<label for="video_link">URL</label><input type="text" name="video_link" value="{/root/video/@url}" size="70" readonly="readonly"  onClick="this.select();"/>
<label for="video_html">HTML</label><textarea name="video_html" readonly="readonly"  onClick="this.select();"><xsl:value-of select="/root/video/embed" disable-output-escaping="yes"/></textarea>
</form>
</div>
</xsl:template>


<!-- ###############################
     AUDIO
     ############################### -->
<xsl:template name="audio">
<xsl:call-template name="audioNode">
<xsl:with-param name="node" select="/root/audio"/>
</xsl:call-template>
<div class="audio-info">
<h1><xsl:value-of select="/root/audio/@title"/></h1>
<xsl:if test="/root/audio/@length"><div class="length"><xsl:value-of select="concat(key('label','length')/@tr,': ',/root/audio/@length)"/></div></xsl:if>
<xsl:if test="/root/audio/@author"><div class="author"><xsl:value-of select="concat(key('label','author')/@tr,': ',/root/audio/@author)"/></div></xsl:if>
<xsl:if test="/root/audio/@date"><div class="date"><xsl:value-of select="concat(key('label','date')/@tr,': ',/root/audio/@date)"/></div></xsl:if>
<xsl:if test="/root/audio/source"><div class="source"><xsl:value-of select="concat(key('label','source')/@tr,': ',/root/audio/source)" disable-output-escaping="yes"/></div></xsl:if>
<div class="views"><xsl:value-of select="concat(key('label','views')/@tr,': ',/root/audio/@views)"/></div>
<xsl:if test="/root/audio/description"><p class="description"><xsl:value-of select="/root/audio/description" disable-output-escaping="yes"/></p></xsl:if>
<xsl:call-template name="licence">
<xsl:with-param name="i" select="/root/audio"/>
</xsl:call-template>
</div>
<div class="audio-embed">
<form>
<label for="audio_link">URL</label><input type="text" name="audio_link" value="{/root/audio/@url}" size="70" readonly="readonly"  onClick="this.select();"/>
<label for="audio_html">HTML</label><textarea name="audio_html" readonly="readonly"  onClick="this.select();"><xsl:value-of select="/root/audio/embed" disable-output-escaping="yes"/></textarea>
</form>
</div>
</xsl:template>

</xsl:stylesheet>
