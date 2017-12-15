<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- ###############################
     CSS CUSTOM
     ############################### -->
<xsl:template name="cssCustom">
<xsl:comment><![CDATA[[if IE 7]><link rel="stylesheet" type="text/css" media="screen" href="]]><xsl:value-of select="$css_url"/><![CDATA[/31/custom_2.css" /><![endif]]]></xsl:comment>
<xsl:comment><![CDATA[[if lt IE 7]><link rel="stylesheet" type="text/css" media="screen" href="]]><xsl:value-of select="$css_url"/><![CDATA[/31/custom_3.css" /><![endif]]]></xsl:comment>
</xsl:template>


</xsl:stylesheet>
