<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="../0/campaign.xsl" />

<xsl:output method="html" encoding="UTF-8" indent="no" doctype-system="http://www.w3.org/TR/html4/strict.dtd"  doctype-public="-//W3C//DTD HTML 4.01//EN" />

<xsl:include href="common.xsl" />

<!-- ###############################
CAMPAIGN SIGN PERSON
############################### -->
<xsl:template name="campaignSignPerson">
<xsl:choose>
<xsl:when test="$ca/login">
<xsl:call-template name="loginFirst">
<xsl:with-param name="node" select="$ca/login"/>
</xsl:call-template>
</xsl:when>
<xsl:otherwise>
<p><xsl:value-of select="key('label','signature_person')/@tr"/></p>
<div id="pre-sign"><xsl:value-of select="$ca/pre_sign" disable-output-escaping="yes"/></div>
<xsl:call-template name="javascriptForms"/>
<script type="text/javascript">
$().ready(function() {
$("#sign").validate({
rules: {
name: "required",
surname: "required",
email: {
required: true,
email: true
}
}
});
});
</script>
<p><xsl:value-of select="key('label','insert_desc')/@tr"/></p>
<form action="{/root/campaign/@submit}" method="post" id="sign" accept-charset="{/root/site/@encoding}">
<input type="hidden" name="from" value="person"/>
<input type="hidden" name="action" value="insert"/>
<input type="hidden" name="id_campaign" value="{$ca/@id}"/>
<input type="hidden" name="id_topic" value="{/root/topic/@id}"/>
<ul class="form-inputs">
<li class="form-notes"><xsl:call-template name="signIntro"/></li>
<xsl:call-template name="formInput">
<xsl:with-param name="varname">name</xsl:with-param>
<xsl:with-param name="required" select="true()"/>
<xsl:with-param name="value" select="/root/user/@name1"/>
</xsl:call-template>
<xsl:call-template name="formInput">
<xsl:with-param name="varname">surname</xsl:with-param>
<xsl:with-param name="required" select="true()"/>
<xsl:with-param name="value" select="/root/user/@name2"/>
</xsl:call-template>
<xsl:call-template name="formInput">
<xsl:with-param name="varname">email</xsl:with-param>
<xsl:with-param name="required" select="true()"/>
<xsl:with-param name="value" select="/root/user/@email"/>
</xsl:call-template>
<xsl:call-template name="formInputGeo"/>
<xsl:call-template name="campaignSignPersonCustom"/>
<xsl:if test="$ca/funding">
<xsl:call-template name="campaignFunding"/>
</xsl:if>
<xsl:call-template name="formInput">
<xsl:with-param name="varname">comments</xsl:with-param>
<xsl:with-param name="type">textarea</xsl:with-param>
</xsl:call-template>
<xsl:call-template name="formInput">
<xsl:with-param name="varname">contact</xsl:with-param>
<xsl:with-param name="type">checkbox</xsl:with-param>
<xsl:with-param name="tr_label"><xsl:call-template name="signContactWarning"/></xsl:with-param>
<xsl:with-param name="value" select="true()"/>
</xsl:call-template>
<xsl:call-template name="formInput">
<xsl:with-param name="varname">privacy</xsl:with-param>
<xsl:with-param name="type">checkbox</xsl:with-param>
<xsl:with-param name="tr_label"><xsl:value-of select="$ca/privacy_warning" disable-output-escaping="yes"/></xsl:with-param>
<xsl:with-param name="value" select="true()"/>
</xsl:call-template>
<li class="form-notes"><xsl:call-template name="signNotes"/></li>
<xsl:if test="$ca/@notify"><li class="form-notes"><xsl:value-of select="$ca/@notify"/></li></xsl:if>
<li class="buttons"><input type="submit" value="{key('label','submit')/@tr}" name="action_sign"/></li>
</ul>
<xsl:call-template name="signFooter"/>
</form>
</xsl:otherwise>
</xsl:choose>
</xsl:template>


</xsl:stylesheet>
