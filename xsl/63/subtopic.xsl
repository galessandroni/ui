<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="../0/subtopic.xsl" />

<xsl:output method="html" encoding="UTF-8" indent="no" doctype-system="http://www.w3.org/TR/html4/strict.dtd"  doctype-public="-//W3C//DTD HTML 4.01//EN" />

<xsl:include href="common.xsl" />

<!-- ###############################
     RIGHT BAR PCK
     ############################### -->
<xsl:template name="rightBarPck2">
<xsl:call-template name="searchPck"/>
<xsl:call-template name="tickerPck"/>

<div class="pckbox">
<xsl:variable name="f" select="/root/c_features/feature[@id='32']"/>
<h3 class="feature"><xsl:value-of select="$f/@name"/></h3>
<ul class="items">
<xsl:apply-templates select="$f/items" mode="mainlist"/>
</ul>
</div>

</xsl:template>

</xsl:stylesheet>
