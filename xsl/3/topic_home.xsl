<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="../0/topic_home.xsl" />

<xsl:output method="html" encoding="UTF-8" indent="no" />

<xsl:include href="common.xsl" />


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


</xsl:stylesheet>
