<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="../0/people.xsl" />

<xsl:output method="html" encoding="UTF-8" indent="no" doctype-system="http://www.w3.org/TR/html4/strict.dtd"  doctype-public="-//W3C//DTD HTML 4.01//EN" />

<xsl:include href="common.xsl" />

<!-- ###############################
CONTENT
############################### -->
<xsl:template name="content">
<div class="linea">
<div class="breadcrumb">
<xsl:call-template name="createLink">
<xsl:with-param name="name" select="$title1"/>
<xsl:with-param name="node" select="/root/site/people"/>
</xsl:call-template>
<xsl:if test="$title2!=''"><xsl:value-of select="concat(' - ',$title2)"/></xsl:if>
</div></div>
<div id="user-content">
<xsl:call-template name="feedback"/>
<xsl:choose>
<xsl:when test="$subtype='password' and $u/@auth='1' ">
<xsl:call-template name="peoplePassword"/>
</xsl:when>
<xsl:when test="$subtype='register'">
<xsl:call-template name="peopleRegister"/>
</xsl:when>
<xsl:when test="$subtype='deactivate' and $u/@auth='1'">
<xsl:call-template name="peopleDeactivate"/>
</xsl:when>
<xsl:when test="$subtype='reminder'">
<xsl:call-template name="peopleReminder"/>
</xsl:when>
<xsl:when test="$subtype='history'">
<xsl:call-template name="peopleHistory"/>
</xsl:when>
<xsl:when test="$subtype='contact' and $u/@auth='1' ">
<xsl:call-template name="peopleContact"/>
</xsl:when>
<xsl:when test="$subtype='data' and $u/@auth='1' ">
<xsl:call-template name="peopleData"/>
</xsl:when>
<xsl:when test="$subtype='login'">
<xsl:call-template name="peopleLogin"/>
</xsl:when>
<xsl:when test="$subtype='payment'">
<xsl:call-template name="peoplePayment"/>
</xsl:when>
</xsl:choose>

<xsl:if test="$u/@name!='' and $subtype='home' ">
<xsl:call-template name="peopleInfo"/>
</xsl:if>

<xsl:if test="$subtype!='register' ">
<xsl:call-template name="loginLogout"/>
</xsl:if>

<xsl:if test="$u/@name!='' and $subtype!='register' and $subtype!='login' and $subtype!='deactivate' ">
<xsl:choose>
<xsl:when test="not($u/@verified='1') ">
<xsl:call-template name="peopleEmailVerificationButton"/>
</xsl:when>
</xsl:choose>
</xsl:if>

</div>
</xsl:template>





<!-- ###############################
     RIGHT BAR
     ############################### -->
<xsl:template name="rightBar">

<xsl:call-template name="graphic">
<xsl:with-param name="id" select="'311'"/>
<xsl:with-param name="format" select="'gif'"/>
</xsl:call-template>
<div class="nascondi"><xsl:apply-templates select="/root/c_features/feature[@id='153']" /></div>
<div class="calendario"><xsl:apply-templates select="/root/features/feature[@id='154']" /></div>
<xsl:apply-templates select="/root/features/feature[@id='76']" />

</xsl:template>





</xsl:stylesheet>
