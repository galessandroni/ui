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

<xsl:call-template name="graphic"><xsl:with-param name="id" select="262"/></xsl:call-template>

<xsl:call-template name="topicHome"/>
<xsl:call-template name="topicEvents"/>
<div><xsl:call-template name="lastUpdate"/></div>
<div class="footer"><xsl:apply-templates select="/root/home_footer"/></div>
</xsl:template>


</xsl:stylesheet>
