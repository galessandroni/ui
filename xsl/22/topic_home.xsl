<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="../0/topic_home.xsl" />

<xsl:output method="html" encoding="UTF-8" indent="no" doctype-system="http://www.w3.org/TR/html4/strict.dtd"  doctype-public="-//W3C//DTD HTML 4.01//EN" />

<xsl:include href="common.xsl" />

<!-- ###############################
     CONTENT
     ############################### -->
<xsl:template name="content">
<div id="rid-homeX">
<h1>Sito ufficiale della Rete Italiana per il Disarmo</h1>
</div>

<div id="rid-home">

<div id="fotohome">
<xsl:call-template name="galleryImage">
<xsl:with-param name="i" select="/root/features/feature[@id='38']/items/item"/>
</xsl:call-template>
<xsl:apply-templates select="root/features/feature[@id=79]"/>
</div>


<div id="primopiano">
<h2>IN PRIMO PIANO</h2>
<xsl:call-template name="topicHome"/>
</div>

<div id="controlarms">

</div>
</div>

<div id="rid-homeA">
<div id="ultime">
<xsl:apply-templates select="root/features/feature[@id=27]"/>
</div>
<div id="ultime">
<xsl:apply-templates select="root/features/feature[@id=29]"/>
</div>
</div>

<div id="rid-homeA">
<div id="ultime">
<xsl:apply-templates select="root/features/feature[@id=28]"/>
</div>
<div id="ultime">
<xsl:apply-templates select="root/features/feature[@id=30]"/>
</div>
</div>

<div id="rid-homeA">
<div id="ultime">
<xsl:apply-templates select="root/features/feature[@id=31]"/>
</div>
<div id="ultime">
<xsl:apply-templates select="root/features/feature[@id=39]"/>
</div>







<!--
<div class="header"><xsl:apply-templates select="/root/home_header"/></div>
<xsl:call-template name="topicEvents"/>
<div><xsl:call-template name="lastUpdate"/></div>
<div class="footer"><xsl:apply-templates select="/root/home_footer"/></div>
-->

</div>


</xsl:template>


</xsl:stylesheet>
