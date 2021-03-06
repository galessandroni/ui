<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="../0/topic_home.xsl" />

<xsl:output method="html" encoding="UTF-8" indent="no" doctype-system="http://www.w3.org/TR/html4/strict.dtd"  doctype-public="-//W3C//DTD HTML 4.01//EN" />

<xsl:include href="common.xsl" />




<!-- ###############################
     RIGHT BAR 
     ############################### -->
<xsl:template name="rightBar"> 


<div id="calendario">
<xsl:apply-templates select="/root/features/feature[@id='105']" />
</div>
<div id="latest">
<xsl:apply-templates select="/root/features/feature[@id='106']" />
</div>

</xsl:template>

</xsl:stylesheet>
