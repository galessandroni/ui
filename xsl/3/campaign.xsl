<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="../0/campaign.xsl" />

<xsl:output method="html" encoding="UTF-8" indent="no" />

<xsl:include href="common.xsl" />


<!-- ###############################
CAMPAIGN SIGN PERSON CUSTOM
############################### -->
<xsl:template name="campaignSignPersonCustom">
<xsl:call-template name="formInput">
<xsl:with-param name="varname">param_job</xsl:with-param>
<xsl:with-param name="label">job</xsl:with-param>
</xsl:call-template>
<xsl:call-template name="formInput">
<xsl:with-param name="varname">param_phone</xsl:with-param>
<xsl:with-param name="label">phone</xsl:with-param>
</xsl:call-template>
</xsl:template>


</xsl:stylesheet>
