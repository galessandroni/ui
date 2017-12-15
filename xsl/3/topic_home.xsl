<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="../0/topic_home.xsl" />

<xsl:output method="html" encoding="UTF-8" indent="no" doctype-system="http://www.w3.org/TR/html4/strict.dtd"  doctype-public="-//W3C//DTD HTML 4.01//EN" />

<xsl:include href="common.xsl" />


<!-- ###############################
CONTENT
############################### -->
<xsl:template name="content">
<div class="header"><xsl:apply-templates select="/root/home_header"/></div>
<xsl:call-template name="topicHomeAddons"/>
<xsl:call-template name="topicHome"/>
<xsl:call-template name="topicEvents"/>
<div><xsl:call-template name="lastUpdate"/></div>
<div class="footer"><xsl:apply-templates select="/root/home_footer"/></div>
</xsl:template>


<!-- ###############################
TOPIC HOME ADDONS
############################### -->
<xsl:template name="topicHomeAddons">
<xsl:if test="/root/topic/@id=2">
<div class="topichome-addons" id="topichome-addon{/root/topic/@id}">
<xsl:choose>
<xsl:when test="/root/topic/@id=2">
<xsl:call-template name="rssLister">
<xsl:with-param name="url" 
select="'https://www.peacelink.it/feeds/rete.rss'"/>
<xsl:with-param name="title" 
select="'Ultime dalla Rete Disarmo'"/>
<xsl:with-param name="title_link" 
select="'https://www.disarmo.org'"/>
<xsl:with-param name="items" 
select="'8'"/>
</xsl:call-template>
</xsl:when>
</xsl:choose>
</div>
</xsl:if>
</xsl:template>


<!-- ###############################
     RIGHT BAR PCK
     ############################### -->
<xsl:template name="rightBarPck2">
<xsl:call-template name="searchPck"/>
<xsl:call-template name="tickerPck"/>
<xsl:call-template name="newsPckTopicHome"/>
</xsl:template>


<!-- ###############################
     NEWS PCK TOPIC
     ############################### -->
<xsl:template name="newsPckTopicHome">
<xsl:choose>
<xsl:when test="/root/topic/@id_group='10'">
<xsl:if test="/root/features/feature[@id='112']/items">
<div class="pckbox">
<xsl:apply-templates select="/root/features/feature[@id='112']"/>
</div>
</xsl:if>
</xsl:when>
<xsl:otherwise>
<xsl:if test="/root/features/feature[@id='14']/items">
<div class="pckbox">
<xsl:apply-templates select="/root/features/feature[@id='14']"/>
</div>
</xsl:if>
</xsl:otherwise>
</xsl:choose>
</xsl:template>


</xsl:stylesheet>
