<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="../0/subtopic.xsl" />

<xsl:output method="html" encoding="UTF-8" indent="no" doctype-system="http://www.w3.org/TR/html4/strict.dtd"  doctype-public="-//W3C//DTD HTML 4.01//EN" />

<xsl:include href="common.xsl" />

<!-- ###############################
     CONTENT
     ############################### -->
<xsl:template name="content">
<xsl:call-template name="breadcrumb"/>
<div class="header"><xsl:apply-templates select="/root/subtopic/header" /></div>
<xsl:if test="/root/subtopic/subtopics">
<xsl:call-template name="subtopics"/>
</xsl:if>
<xsl:call-template name="subtopic"/>
<div class="footer"><xsl:apply-templates select="/root/subtopic/footer" /></div>
</xsl:template>

</xsl:stylesheet>
