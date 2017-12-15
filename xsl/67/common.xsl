<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:include href="root.xsl" />
<xsl:include href="tools.xsl" />





















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
NEW MENU ITEM
############################### -->
<xsl:template mode="listitem" match="subtopic">
<xsl:param name="level"/>
<li id="ms{@id}"><xsl:attribute name="class">level<xsl:value-of 
select="$level"/><xsl:if test="@id = /root/subtopic/@id or 
subtopics/subtopic/@id=/root/subtopic/@id"><xsl:text> 
</xsl:text>selected</xsl:if></xsl:attribute>
<xsl:call-template name="createLink">
<xsl:with-param name="name" select="@name"/>
<xsl:with-param name="node" select="."/>
</xsl:call-template>
<xsl:if test="subtopics and (@id = /root/subtopic/@id or 
subtopics//subtopic/@id=/root/subtopic/@id)">
<xsl:apply-templates>
<xsl:with-param name="level" select="$level + 1"/>
</xsl:apply-templates>
</xsl:if>
</li>
</xsl:template>



<!-- ###############################
NAVIGATION MENU - left
############################### -->
<xsl:template name="navigationMenuLeft">

<xsl:choose>
<xsl:when test="$pagetype='topic_home'">
<xsl:apply-templates select="/root/menu/subtopics/subtopic[@id=275]"/>
<xsl:call-template name="Abbonati"/>
<xsl:call-template name="bannerGroup"><xsl:with-param name="id" select="'34'"/></xsl:call-template>
<xsl:call-template name="bannerGroup"><xsl:with-param name="id" select="'31'"/></xsl:call-template>
<xsl:call-template name="ScriviAdAlex"/>
<xsl:call-template name="ScriviRedazione"/>
</xsl:when >

<xsl:otherwise>


<xsl:choose>
<xsl:when  test="/root/article/breadcrumb/sub/topic/@id='275' or /root/subtopic/breadcrumb/subtopic/@id='275'">
<xsl:apply-templates select="/root/menu/subtopics/subtopic[@id=275]"/>
</xsl:when >
<xsl:when  test="/root/article/breadcrumb/subtopic/@id='277' or /root/subtopic/breadcrumb/subtopic/@id='277'">
<xsl:apply-templates select="/root/menu/subtopics/subtopic[@id=277]"/>
</xsl:when >
<xsl:when  test="/root/article/breadcrumb/subtopic/@id='278' or /root/subtopic/breadcrumb/subtopic/@id='278'">
<xsl:apply-templates select="/root/menu/subtopics/subtopic[@id=278]"/>
</xsl:when >
<xsl:when  test="/root/article/breadcrumb/subtopic/@id='3053' or /root/subtopic/breadcrumb/subtopic/@id='3053'">
<xsl:apply-templates select="/root/menu/subtopics/subtopic[@id=3053]"/>
</xsl:when >

<xsl:when  test="/root/article/breadcrumb/subtopic/@id='3387' or /root/subtopic/breadcrumb/subtopic/@id='3387'">
<xsl:apply-templates select="/root/menu/subtopics/subtopic[@id=3387]"/>
</xsl:when >
<xsl:when  test="/root/article/breadcrumb/subtopic/@id='740' or /root/subtopic/breadcrumb/subtopic/@id='740'">
<xsl:apply-templates select="/root/menu/subtopics/subtopic[@id=740]"/>
</xsl:when >
<xsl:when  test="/root/article/breadcrumb/subtopic/@id='3388' or /root/subtopic/breadcrumb/subtopic/@id='3388'">
<xsl:apply-templates select="/root/menu/subtopics/subtopic[@id=3388]"/>
</xsl:when >

<xsl:otherwise>
<xsl:apply-templates select="/root/menu/subtopics/subtopic[@id=275]"/>
</xsl:otherwise>
</xsl:choose>
<xsl:call-template name="UltimoNumero"/>
<xsl:call-template name="Abbonati"/>
<xsl:call-template name="bannerGroup"><xsl:with-param name="id" select="'31'"/></xsl:call-template>
<xsl:call-template name="ScriviAdAlex"/>
<xsl:call-template name="ScriviRedazione"/>
</xsl:otherwise>
</xsl:choose>
<!-- ##<div class="banner">
<a title="Rispondi al Questionario">
<xsl:attribute name="href">
<xsl:call-template name="createLinkUrl">
<xsl:with-param name="node" select="/root/menu/subtopics//subtopic[@id=3402]"/>
</xsl:call-template>
</xsl:attribute>
<xsl:call-template name="graphic"><xsl:with-param name="id" select="322"/></xsl:call-template>
</a></div>## -->
<xsl:call-template name="bannerGroup"><xsl:with-param name="id" select="'25'"/></xsl:call-template>
</xsl:template>


<!-- ###############################
ULTIMO NUMERO
############################### -->
<xsl:template name="UltimoNumero">
<div id="ultimo-numero">
<xsl:apply-templates select="/root/c_features/feature[@id='155']" />
<div class="leggi">
<xsl:for-each select="/root/c_features/feature[@id=155]">
<xsl:call-template name="createLink">
<xsl:with-param name="name"><xsl:text>L'ultimo numero</xsl:text></xsl:with-param>
<xsl:with-param name="node" select="items/item"/>
</xsl:call-template>
</xsl:for-each>
</div>
</div>
</xsl:template>


<!-- ###############################
NAVIGATION MENU - ABBONATI
############################### -->
<xsl:template name="Abbonati">
<a title="Abbonati">
<xsl:attribute name="href">
<xsl:call-template name="createLinkUrl">
<xsl:with-param name="node" select="/root/menu/subtopics//subtopic[@id=286]"/>
</xsl:call-template>
</xsl:attribute>
<xsl:call-template name="graphic"><xsl:with-param name="id" select="318"/></xsl:call-template>
</a>
</xsl:template>


<!-- ###############################
NAVIGATION MENU - SCRIVI AD ALEX
############################### -->
<xsl:template name="ScriviAdAlex">
<a title="Scrivi ad Alex">
<xsl:attribute name="href">
<xsl:call-template name="createLinkUrl">
<xsl:with-param name="node" select="/root/menu/subtopics//subtopic[@id=2825]"/>
</xsl:call-template>
</xsl:attribute>
<xsl:call-template name="graphic"><xsl:with-param name="id" select="319"/></xsl:call-template>
</a>
</xsl:template>


<!-- ###############################
NAVIGATION MENU - SCRIVI ALLA REDAZIONE
############################### -->
<xsl:template name="ScriviRedazione">
<a title="Scrivi alla redazione">
<xsl:attribute name="href">
<xsl:call-template name="createLinkUrl">
<xsl:with-param name="node" select="/root/menu/subtopics//subtopic[@id=279]"/>
</xsl:call-template>
</xsl:attribute>
<xsl:call-template name="graphic"><xsl:with-param name="id" select="320"/></xsl:call-template>
</a>
</xsl:template>


<!-- ###############################
NAVIGATION MENU - TOP-NAV-TOP
############################### -->
<xsl:template name="navigationMenuNavTop">
<ul class="top-right">

<!-- ###abbonati#### -->
<xsl:for-each select="/root/menu/subtopics//subtopic[@id=286]">
<li class="top-item-right">
<xsl:call-template name="createLink">
<xsl:with-param name="name" select="@name"/>
<xsl:with-param name="node" select="."/>
</xsl:call-template>
</li>
</xsl:for-each>

<li class="top-item-right">
<xsl:text>|</xsl:text>
</li>

<!-- ### sostienici #### -->
<xsl:for-each select="/root/menu/subtopics//subtopic[@id=286]">
<li class="top-item-right">
<xsl:call-template name="createLink">
<xsl:with-param name="name">Sostienici</xsl:with-param>
<xsl:with-param name="node" select="."/>
</xsl:call-template>
</li>
</xsl:for-each>

<li class="top-item-right">
<xsl:text>|</xsl:text>
</li>


<!-- ### link amici  #### -->
<xsl:for-each select="/root/menu/subtopics//subtopic[@id=2823]">
<li class="top-item-right">
<xsl:call-template name="createLink">
<xsl:with-param name="name" select="@name"/>
<xsl:with-param name="node" select="."/>
</xsl:call-template>
</li>
</xsl:for-each>

<li class="top-item-right">
<xsl:text>|</xsl:text>
</li>


<!-- ###contaci#### -->
<xsl:for-each select="/root/menu/subtopics//subtopic[@id=279]">
<li class="top-item-right">
<xsl:call-template name="createLink">
<xsl:with-param name="name" select="@name"/>
<xsl:with-param name="node" select="."/>
</xsl:call-template>
</li>
</xsl:for-each>



<!-- ###mappa del sito#
<xsl:for-each select="/root/menu/subtopics//subtopic[@id=279]">
<li class="top-item-right">
<xsl:call-template name="createLink">
<xsl:with-param name="name" select="@name"/>
<xsl:with-param name="node" select="."/>
</xsl:call-template>
</li>
</xsl:for-each>
### -->
</ul>
</xsl:template>

<!-- ###############################
NAVIGATION MENU - TOP-NAV-BOTTOM
############################### -->
<xsl:template name="navigationMenuBar">
<ul class="top-left">

<!-- ### home #### -->
<xsl:for-each select="/root/topic">
<li class="top-item-left">
<xsl:call-template name="createLink">
<xsl:with-param name="name">Home</xsl:with-param>
<xsl:with-param name="node" select="."/>
</xsl:call-template>
</li>
<li class="top-item-left">
<xsl:text>|</xsl:text>
</li>
</xsl:for-each>

<!-- ###chi siamo#### -->
<xsl:for-each select="/root/menu/subtopics//subtopic[@id=275]">
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



<!-- ###archivio#### -->
<xsl:for-each select="/root/menu/subtopics//subtopic[@id=277]">
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


<!-- ###l'opinione di...#### -->
<xsl:for-each select="/root/menu/subtopics//subtopic[@id=278]">
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

<!-- ###mosaico dei giorni#### -->
<xsl:for-each select="/root/menu/subtopics//subtopic[@id=3053]">
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


<!-- ###approfondimenti#### -->
<xsl:for-each select="/root/menu/subtopics//subtopic[@id=3387]">
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

<!-- ###iniziative#### -->
<xsl:for-each select="/root/menu/subtopics//subtopic[@id=740]">
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

<!-- ###collabora#### -->
<xsl:for-each select="/root/menu/subtopics//subtopic[@id=3388]">
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
<xsl:template name="navigationMenuNavBottom">
<ul class="top-left">

<!-- ###Pax Christi#### -->
<xsl:for-each select="/root/menu/subtopics//subtopic[@id=773]">
<li class="top-item-left">
<xsl:call-template name="createLink">
<xsl:with-param name="name" select="@name"/>
<xsl:with-param name="node" select="."/>
</xsl:call-template>
</li>
</xsl:for-each>

<li class="top-item-left">
<xsl:text>|</xsl:text>
</li>

<!-- ###Casa per la Pace#### -->
<xsl:for-each select="/root/menu/subtopics//subtopic[@id=774]">
<li class="top-item-left">
<xsl:call-template name="createLink">
<xsl:with-param name="name" select="@name"/>
<xsl:with-param name="node" select="."/>
</xsl:call-template>
</li>
</xsl:for-each>

</ul>


<xsl:call-template name="userInfo"/>


</xsl:template>



<!-- ###############################
     TOP BAR LOGO
     ############################### -->
<xsl:template name="topBarTop">

<div id="logo-left">
<a title="Homepage Pax Christi">
<xsl:attribute name="href">
<xsl:call-template name="createLinkUrl">
<xsl:with-param name="node" select="/root/topic"/>
</xsl:call-template>
</xsl:attribute>
<xsl:call-template name="graphic">
<xsl:with-param name="id" select="310"/>
</xsl:call-template>
</a>

</div>

<div id="logo">
<a title="Pax in rete">
<xsl:attribute name="href">
<xsl:call-template name="createLinkUrl">
<xsl:with-param name="node" select="/root/menu/subtopics//subtopic[@id=3246]"/>
</xsl:call-template>
</xsl:attribute>
<xsl:call-template name="graphic">
<xsl:with-param name="id" select="283"/>
</xsl:call-template>
</a>
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
<div id="phpeace">Realizzato da Off.ed comunicazione con <a href="https://www.phpeace.org">PhPeace <xsl:value-of select="/root/site/@phpeace"/></a></div>
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
