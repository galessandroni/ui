<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:include href="root.xsl" />
<xsl:include href="tools.xsl" />


<!-- ###############################
NAVIGATION MENU - left
############################### -->
<xsl:template name="navigationMenuLeft">
<xsl:choose>
<xsl:when  test="/root/article/breadcrumb/subtopic/@id='437' or /root/subtopic/breadcrumb/subtopic/@id='437'">
<xsl:apply-templates select="/root/menu/subtopics/subtopic[@id=437]"/>
</xsl:when >
<xsl:when  test="/root/article/breadcrumb/subtopic/@id='486' or /root/subtopic/breadcrumb/subtopic/@id='486'">
<xsl:apply-templates select="/root/menu/subtopics/subtopic[@id=486]"/>
</xsl:when >
<xsl:when  test="/root/article/breadcrumb/subtopic/@id='487' or /root/subtopic/breadcrumb/subtopic/@id='487'">
<xsl:apply-templates select="/root/menu/subtopics/subtopic[@id=487]"/>
</xsl:when >
<xsl:when  test="/root/article/breadcrumb/subtopic/@id='454' or /root/subtopic/breadcrumb/subtopic/@id='454'">
<xsl:apply-templates select="/root/menu/subtopics/subtopic[@id=454]"/>
</xsl:when >
<xsl:when  test="/root/article/breadcrumb/subtopic/@id='651' or /root/subtopic/breadcrumb/subtopic/@id='651'">
<xsl:apply-templates select="/root/menu/subtopics/subtopic[@id=651]"/>
</xsl:when >
<xsl:otherwise></xsl:otherwise>
</xsl:choose>
<div class="menu-footer">
<xsl:call-template name="graphic"><xsl:with-param name="id" select="297"/></xsl:call-template>
<xsl:apply-templates select="/root/menu/menu_footer"/>
</div>
</xsl:template>


<!-- ###############################
EVENT ITEM
############################### -->
<xsl:template name="eventItem">
<xsl:param name="e"/>
<xsl:param name="showDate" select="true()"/>
<div class="event-type"><xsl:value-of select="$e/@event_type"/></div>
<xsl:if test="$showDate=true()">
<div class="event-date"><xsl:value-of select="$e/@start_date"/>
<xsl:if test="$e/@end_ts &gt; $e/@start_ts"> - <xsl:value-of select="$e/@end_date"/>
</xsl:if>
</div>
</xsl:if>
<h3>
<xsl:call-template name="createLink">
<xsl:with-param name="name"><xsl:value-of select="$e/@title" disable-output-escaping="yes"/></xsl:with-param>
<xsl:with-param name="node" select="$e"/>
</xsl:call-template>
</h3>
<div class="notes"><xsl:value-of select="$e/@place"/><xsl:if test="$e/@geo_name!=''"><xsl:value-of select="concat(' (',$e/@geo_name,')')"/></xsl:if></div>
</xsl:template>



<!-- ###############################
NAVIGATION MENU - TOP-NAV-TOP
############################### -->
<xsl:template name="navigationMenuNavTop">
<ul class="top-right">

<!-- ###mappa del sito#### -->
<xsl:for-each select="/root/menu/subtopics//subtopic[@id=3252]">
<li class="top-item-right">
<xsl:call-template name="createLink">
<xsl:with-param name="name" select="@name"/>
<xsl:with-param name="node" select="."/>
</xsl:call-template>
</li>
<li class="top-item-right">
<xsl:text>|</xsl:text>
</li>
</xsl:for-each>


<!-- ###contatti#### -->
<xsl:for-each select="/root/menu/subtopics//subtopic[@id=439]">
<li class="top-item-right">
<xsl:call-template name="createLink">
<xsl:with-param name="name" select="@name"/>
<xsl:with-param name="node" select="."/>
</xsl:call-template>
</li>
</xsl:for-each>

</ul>
</xsl:template>

<!-- ###############################
NAVIGATION MENU - TOP-NAV-BOTTOM
############################### -->
<xsl:template name="navigationMenuNavBottom">
<ul class="top-left">

<!-- ###casa per la pace#### -->
<xsl:for-each select="/root/menu/subtopics//subtopic[@id=437]">
<li class="top-item-left">
<xsl:call-template name="createLink">
<xsl:with-param name="name" select="@name"/>
<xsl:with-param name="node" select="."/>
</xsl:call-template>
</li>
<li class="top-item-left">
<xsl:text>|</xsl:text>
</li>
</xsl:for-each>


<!-- ###come arrivare#### -->
<xsl:for-each select="/root/menu/subtopics//subtopic[@id=486]">
<li class="top-item-left">
<xsl:call-template name="createLink">
<xsl:with-param name="name" select="@name"/>
<xsl:with-param name="node" select="."/>
</xsl:call-template>
</li>
<li class="top-item-left">
<xsl:text>|</xsl:text>
</li>
</xsl:for-each>


<!-- ###ospitalità#### -->
<xsl:for-each select="/root/menu/subtopics//subtopic[@id=487]">
<li class="top-item-left">
<xsl:call-template name="createLink">
<xsl:with-param name="name" select="@name"/>
<xsl:with-param name="node" select="."/>
</xsl:call-template>
</li>
<li class="top-item-left">
<xsl:text>|</xsl:text>
</li>
</xsl:for-each>

<!-- ###attività#### -->
<xsl:for-each select="/root/menu/subtopics//subtopic[@id=454]">
<li class="top-item-left">
<xsl:call-template name="createLink">
<xsl:with-param name="name" select="@name"/>
<xsl:with-param name="node" select="."/>
</xsl:call-template>
</li>
<li class="top-item-left">
<xsl:text>|</xsl:text>
</li>
</xsl:for-each>


<!-- ###sostieni la casa#### -->
<xsl:for-each select="/root/menu/subtopics//subtopic[@id=651]">
<li class="top-item-left">
<xsl:call-template name="createLink">
<xsl:with-param name="name" select="@name"/>
<xsl:with-param name="node" select="."/>
</xsl:call-template>
</li>
</xsl:for-each>

</ul>
</xsl:template>

<!-- ###############################
NAVIGATION MENU - BAR
############################### -->
<xsl:template name="navigationMenuBar">
<ul class="top-right">

<!-- ###Pax Christi International#### -->
<xsl:for-each select="/root/menu/subtopics//subtopic[@id=3262]">
<li class="top-item-left">
<xsl:call-template name="createLink">
<xsl:with-param name="name" select="@name"/>
<xsl:with-param name="node" select="."/>
</xsl:call-template>
</li>
<li class="top-item-left">
<xsl:text>|</xsl:text>
</li>
</xsl:for-each>


<!-- ###Mosaico di Pace#### -->
<xsl:for-each select="/root/menu/subtopics//subtopic[@id=3263]">
<li class="top-item-left">
<xsl:call-template name="createLink">
<xsl:with-param name="name" select="@name"/>
<xsl:with-param name="node" select="."/>
</xsl:call-template>
</li>
<li class="top-item-left">
<xsl:text>|</xsl:text>
</li>
</xsl:for-each>


<!-- ###Casa per la Pace#### -->
<xsl:for-each select="/root/menu/subtopics//subtopic[@id=3264]">
<li class="top-item-left">
<xsl:call-template name="createLink">
<xsl:with-param name="name" select="@name"/>
<xsl:with-param name="node" select="."/>
</xsl:call-template>
</li>
</xsl:for-each>

</ul>

<ul class="top-left">
<!-- ###citazione di Bello#### -->
<li class="top-item-right">
<xsl:text>Riparare le tende per ripartire sui sentieri di Isaia (don Tonino Bello)</xsl:text>
</li>
</ul>
</xsl:template>


<!-- ###############################
ITEM
######################
<xsl:template mode="pxlist" match="item">
<xsl:param name="breadcrumb" select="false()"/>
<li>
<xsl:if test="position()=last()-1"><xsl:attribute name="class">last</xsl:attribute></xsl:if>
<xsl:call-template name="articleItem">
<xsl:with-param name="a" select="."/>
</xsl:call-template>
<xsl:if test="$breadcrumb">
<div class="item-breadcrumb">
<xsl:apply-templates select="breadcrumb" mode="breadcrumb"/>
</div>
</xsl:if>
</li>
</xsl:template>
######### -->

<!-- ###############################
     TOP BAR LOGO
     ############################### -->
<xsl:template name="topBarTop">

<div id="logo-left">
<a title="Homepage Casa della Pace">
<xsl:attribute name="href">
<xsl:call-template name="createLinkUrl">
<xsl:with-param name="node" select="/root/topic"/>
</xsl:call-template>
</xsl:attribute>
<xsl:call-template name="graphic">
<xsl:with-param name="id" select="298"/>
</xsl:call-template>
</a>
</div>
<div id="logo">
<xsl:call-template name="graphic">
<xsl:with-param name="id" select="283"/>
</xsl:call-template>
</div>
</xsl:template>




<!-- ###############################
     SEARCH pax
    ############################### -->
<xsl:template name="searchPax">
<form method="get" id="search-form" accept-charset="{/root/site/@encoding}">
<xsl:attribute name="action">
<xsl:call-template name="createLinkUrl">
<xsl:with-param name="node" select="/root/site/search"/>
</xsl:call-template>
</xsl:attribute>
<fieldset>
<legend><xsl:value-of select="/root/site/search/@label"/></legend>
<xsl:if test="$preview='1'"><input type="hidden" name="id_type" value="18"/></xsl:if>
<input type="hidden" name="id_topic" value="{/root/topic/@id}"/>
<input type="text" name="q" value="{/root/search/@q}" class="search-input"/>
<input type="submit" value="{/root/site/search/@name}" class="search-submit"/>
</fieldset>
</form>
</xsl:template>

<!-- ###############################
BOTTOM BAR
############################### -->
<xsl:template name="bottomBar">
<xsl:if test="/root/topic/page_footer"><div id="page-footer"><xsl:apply-templates select="/root/topic/page_footer"/></div></xsl:if>
<div id="phpeace">Realizzato da Off.ed comunicazione con <a href="http://www.phpeace.org">PhPeace <xsl:value-of select="/root/site/@phpeace"/></a></div>
</xsl:template>


<!-- ###############################
BREADCRUMB
############################### -->
<xsl:template name="breadcrumb">
<div class="linea">
<div class="breadcrumb">
<xsl:choose>
<xsl:when test="$pagetype='subtopic'">
<xsl:apply-templates select="/root/subtopic/breadcrumb" mode="breadcrumb"/>
</xsl:when>
<xsl:when test="$pagetype='article' or $pagetype='send_friend'">
<xsl:apply-templates select="/root/article/breadcrumb" mode="breadcrumb"/>
</xsl:when>
<xsl:when test="$pagetype='map'">
<xsl:call-template name="createLink">
<xsl:with-param name="name" select="key('label','map')/@tr"/>
<xsl:with-param name="node" select="/root/site/map"/>
</xsl:call-template>
<xsl:if test="/root/publish/@id &gt; 0">
<xsl:value-of select="$breadcrumb_separator"/>
<xsl:apply-templates select="/root/topics/group/breadcrumb" mode="breadcrumb"/>
</xsl:if>
</xsl:when>
<xsl:when test="$pagetype='gallery_group'">
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="/root/tree"/>
</xsl:call-template>
<xsl:if test="/root/publish/@id &gt; 0">
<xsl:value-of select="$breadcrumb_separator"/>
<xsl:apply-templates select="/root/group/breadcrumb" mode="breadcrumb"/>
</xsl:if>
<xsl:if test="$subtype!='group' ">
<xsl:value-of select="$breadcrumb_separator"/>
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="/root/gallery"/>
</xsl:call-template>
</xsl:if>
</xsl:when>
<xsl:when test="$pagetype='feeds'">Feeds</xsl:when>
<xsl:otherwise>
<xsl:apply-templates select="/root/subtopic/breadcrumb" mode="breadcrumb"/>
</xsl:otherwise>
</xsl:choose>
</div></div>
</xsl:template>


</xsl:stylesheet>
