<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:include href="root.xsl" />
<xsl:include href="tools.xsl" />


<!-- ###############################
     BOTTOM BAR
     ############################### -->
<xsl:template name="bottomBarPck">
<xsl:if test="/root/topic/page_footer"><div id="page-footer"><xsl:apply-templates select="/root/topic/page_footer"/></div></xsl:if>
</xsl:template>

</xsl:stylesheet>
