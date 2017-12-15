<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">



<!-- ###############################
PARAM [CUSTOM]
############################### -->

<xsl:template match="param" mode="custom">
<xsl:variable name="varname" select="concat('param_',@id)"/>
<xsl:variable name="required" select="@mandatory='1'"/>
<xsl:choose>
<xsl:when test="@type='textarea' ">
<xsl:call-template name="formInput">
<xsl:with-param name="tr_label" select="@label"/>
<xsl:with-param name="varname" select="$varname"/>
<xsl:with-param name="type">textarea</xsl:with-param>
<xsl:with-param name="required" select="$required"/>
</xsl:call-template>
</xsl:when>
<xsl:when test="@type='checkbox' or @type='subscription' ">
<xsl:call-template name="formInput">
<xsl:with-param name="tr_label" select="@label"/>
<xsl:with-param name="varname" select="$varname"/>
<xsl:with-param name="type">checkbox</xsl:with-param>
<xsl:with-param name="required" select="$required"/>
</xsl:call-template>
</xsl:when>
<xsl:when test="@type='geo' ">
<xsl:call-template name="formInputGeo">
<xsl:with-param name="contextNode" select="."/>
<xsl:with-param name="geoLocation" select="geo/@geo_location"/>
<xsl:with-param name="required" select="$required"/>
<xsl:with-param name="geoVarname" select="'id_geo'"/>
</xsl:call-template>
</xsl:when>
<xsl:when test="@type='dropdown' ">
<li>
<label for="{$varname}"><xsl:value-of select="@label"/></label>
<select name="{$varname}">
<xsl:for-each select="subparams/subparam">
<option value="{@value}"><xsl:value-of select="@value"/></option>
</xsl:for-each>
</select>
</li>
</xsl:when>
<xsl:when test="@type='mchoice' ">

<fieldset class="mchoice">
<div class="tslebel"><xsl:value-of select="@label"/></div>
<xsl:variable name="checkbox_id" select="@label"/>
<ul class="form-inputs">
<xsl:for-each select="subparams/subparam">
<li>
<xsl:call-template name="formInput">
<xsl:with-param name="tr_label" select="@value"/>
<xsl:with-param name="varname" select="concat($varname,'[]')"/>
<xsl:with-param name="box_value" select="@value"/>
<xsl:with-param name="type">checkbox</xsl:with-param>
</xsl:call-template>
</li>
</xsl:for-each>
</ul>
</fieldset>

</xsl:when>
<xsl:when test="@type='upload' ">
<li>
<label for="{$varname}"><xsl:value-of select="@label"/></label>
<input type="file" name="{$varname}[]"/>
</li>
</xsl:when>
<xsl:otherwise>
<xsl:call-template name="formInput">
<xsl:with-param name="tr_label" select="@label"/>
<xsl:with-param name="varname" select="$varname"/>
<xsl:with-param name="required" select="$required"/>
<xsl:with-param name="value">
<xsl:if test="@use and /root/user/@id">
<xsl:choose>
<xsl:when test="@use=1"><xsl:value-of select="/root/user/@name1"/></xsl:when>
<xsl:when test="@use=2"><xsl:value-of select="/root/user/@name2"/></xsl:when>
<xsl:when test="@use=3"><xsl:value-of select="/root/user/@name3"/></xsl:when>
<xsl:when test="@use=4"><xsl:value-of select="/root/user/@email"/></xsl:when>
</xsl:choose>
</xsl:if>
</xsl:with-param>
</xsl:call-template>
</xsl:otherwise>
</xsl:choose>
</xsl:template>

</xsl:stylesheet>
