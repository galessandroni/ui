<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">




<!-- ###############################
     RID LEFT BAR
     ############################### -->
<xsl:template name="ridLeftBar">
<a>
<xsl:attribute name="href">
<xsl:call-template name="createLinkUrl">
<xsl:with-param name="node" select="/root/topic"/>
</xsl:call-template>
</xsl:attribute>
<xsl:call-template name="graphic">
<xsl:with-param name="id" select="'216'"/>
<xsl:with-param name="format" select="'gif'"/>
</xsl:call-template>
</a>
<xsl:call-template name="navigationMenu"/>
</xsl:template>


</xsl:stylesheet>


