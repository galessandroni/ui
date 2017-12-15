<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="../0/topic_home.xsl" />

<xsl:output method="html" encoding="UTF-8" indent="no" doctype-system="http://www.w3.org/TR/html4/strict.dtd"  doctype-public="-//W3C//DTD HTML 4.01//EN" />

<xsl:include href="common.xsl" />


<!-- ###############################
     CONTENT
     ############################### -->
<xsl:template name="content">

<div id="top">
<xsl:apply-templates select="/root/c_features/feature[@id=98]"/>
</div>

<div id="rid-homeA">
<div id="ultime">
<xsl:apply-templates select="root/features/feature[@id=96]"/>
</div>
<div id="ultime">
<xsl:apply-templates select="root/features/feature[@id=97]"/>
</div>
</div>


</xsl:template>

</xsl:stylesheet>
