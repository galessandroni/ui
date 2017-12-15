<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"><xsl:import href="../0/topic_home.xsl" />

<xsl:output method="html" encoding="UTF-8" indent="no" doctype-system="http://www.w3.org/TR/html4/strict.dtd"  doctype-public="-//W3C//DTD HTML 4.01//EN" />

<xsl:include href="common.xsl" />


<!-- ###############################
TOPIC HOME
############################### -->
<xsl:template name="topicHome">
<xsl:variable name="hometype" select="/root/topic/@home_type"/>
<xsl:choose>
<xsl:when test="$hometype='1' or $hometype='3'">
<ul class="items">
<xsl:apply-templates mode="pxlist" select="/root/items">
<xsl:with-param name="breadcrumb" select="true()"/>
</xsl:apply-templates>
</ul>
</xsl:when>
<xsl:when test="$hometype='0' or $hometype='2'">
<xsl:call-template name="articleContent">
<xsl:with-param name="a" select="/root/article"/>
</xsl:call-template>
</xsl:when>
<xsl:when test="$hometype='4'">
<xsl:call-template name="subtopic"/>
</xsl:when>
</xsl:choose>
</xsl:template>





</xsl:stylesheet>
