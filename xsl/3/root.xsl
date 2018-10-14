<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- ###############################
     LEFT BOTTOM
     ############################### -->
<xsl:template name="leftBottom">
  <xsl:if test="/root/topic/@id_group=1">
    <xsl:call-template name="bannerGroup"><xsl:with-param name="id" select="'3'"/></xsl:call-template>
  </xsl:if>
</xsl:template>

</xsl:stylesheet>
