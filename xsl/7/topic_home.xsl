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
<div id="pal-galleries">
<div class="pal-gal">
<h3>Gaza</h3>
<xsl:variable name="ps1" select="/root/features/feature[@id='116']/items/item" />
<xsl:call-template name="slideshow">
<xsl:with-param name="id" select="$ps1/@id"/>
<xsl:with-param name="width" select="300"/>
<xsl:with-param name="height" select="200"/>
<xsl:with-param name="images" select="$ps1/@xml"/>
<xsl:with-param name="shuffle" select="$ps1/@shuffle"/>
<xsl:with-param name="bgcolor" select="'0xffffff'"/>
<xsl:with-param name="controls" select="false()"/>
<xsl:with-param name="jscaptions" select="false()"/>
</xsl:call-template>
</div>
<div class="pal-gal">
<h3>Manifestazioni da tutto il mondo</h3>
<div id="slide-caption" name="slide-caption" class="gallery-image"></div>
<xsl:variable name="ps2" select="/root/features/feature[@id='117']/items/item" />
<xsl:call-template name="slideshow">
<xsl:with-param name="id" select="$ps2/@id"/>
<xsl:with-param name="width" select="300"/>
<xsl:with-param name="height" select="200"/>
<xsl:with-param name="images" select="$ps2/@xml"/>
<xsl:with-param name="shuffle" select="$ps2/@shuffle"/>
<xsl:with-param name="bgcolor" select="'0xffffff'"/>
<xsl:with-param name="jscaptions" select="true()"/>
<xsl:with-param name="controls" select="false()"/>
</xsl:call-template>
</div>
<!--
<xsl:call-template name="rssTicker">
<xsl:with-param name="url">http://www.peacelink.it/js/rss_group.php?id=3</xsl:with-param>
<xsl:with-param name="title">News in English</xsl:with-param>
</xsl:call-template>
-->
<xsl:apply-templates select="/root/features/feature[@id='118']" />
</div>
<div id="pal-home"><xsl:call-template name="topicHome"/></div>
<div><xsl:call-template name="lastUpdate"/></div>
<div class="footer"><xsl:apply-templates select="/root/home_footer"/></div>
</xsl:template>


</xsl:stylesheet>
