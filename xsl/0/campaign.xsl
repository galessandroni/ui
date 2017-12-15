<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!--********************************************************************

   PhPeace - Portal Management System

   Copyright notice
   (C) 2003-2017 Francesco Iannuzzelli <francesco@phpeace.org>
   All rights reserved

   This script is part of PhPeace.
   PhPeace is free software; you can redistribute it and/or modify 
   it under the terms of the GNU General Public License as 
   published by the Free Software Foundation; either version 2 of 
   the License, or (at your option) any later version.

   PhPeace is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   The GNU General Public License (GPL) is available at
   http://www.gnu.org/copyleft/gpl.html.
   A copy can be found in the file COPYING distributed with 
   these scripts.

   This copyright notice MUST APPEAR in all copies of the script!

********************************************************************-->

<xsl:output method="html" encoding="UTF-8" indent="no" doctype-system="http://www.w3.org/TR/html4/strict.dtd" doctype-public="-//W3C//DTD HTML 4.01//EN" />

<xsl:include href="common.xsl" />

<xsl:variable name="ca" select="/root/campaign"/>

<xsl:variable name="current_page_title">
<xsl:choose>
<xsl:when test="/root/campaign">
<xsl:value-of select="key('label','campaign')/@tr"/> - <xsl:value-of select="/root/campaign/@title"/>
</xsl:when>
<xsl:otherwise>
<xsl:value-of select="key('label','campaigns')/@tr"/>
</xsl:otherwise>
</xsl:choose>
</xsl:variable>


<!-- ###############################
     CONTENT
     ############################### -->
<xsl:template name="content">
<xsl:choose>
<xsl:when test="/root/campaign">
<xsl:call-template name="campaignBreadcrumb"/>
<xsl:call-template name="feedback"/>
<div id="campaign-content">
<h1><xsl:value-of select="key('label','campaign')/@tr"/>: 
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="$ca"/>
<xsl:with-param name="name" select="$ca/@title"/>
</xsl:call-template>
</h1>
<xsl:choose>
<xsl:when test="$ca/@active &gt; 0">
<xsl:call-template name="campaignContent"/>
</xsl:when>
<xsl:otherwise>
<p><xsl:value-of select="key('label','campaign_over')/@tr"/></p>
</xsl:otherwise>
</xsl:choose>
</div>
</xsl:when>
<xsl:when test="$subtype='insert' and /root/campaign_insert">
<div class="breadcrumb"><xsl:value-of select="/root/campaign_insert/@label"/></div>
<xsl:call-template name="campaignInsert"/>
</xsl:when>
<xsl:otherwise>
<xsl:call-template name="campaignBreadcrumb"/>
<xsl:call-template name="feedback"/>
<h1><xsl:value-of select="key('label','campaigns')/@tr"/></h1>
<xsl:if test="/root/campaigns_insert">
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="/root/campaigns_insert"/>
<xsl:with-param name="name" select="/root/campaigns_insert/@label"/>
</xsl:call-template>
</xsl:if>
<xsl:call-template name="items">
<xsl:with-param name="root" select="/root/campaigns/items"/>
<xsl:with-param name="node" select="/root/campaigns"/>
</xsl:call-template>
</xsl:otherwise>
</xsl:choose>
</xsl:template>


<!-- ###############################
     CAMPAIGN BREADCRUMB
     ############################### -->
<xsl:template name="campaignBreadcrumb">
<div class="breadcrumb">
<xsl:choose>
<xsl:when test="/root/campaign">
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="$ca"/>
<xsl:with-param name="name" select="$ca/@title"/>
<xsl:with-param name="condition" select="$ca/items"/>
</xsl:call-template>
<xsl:if test="$ca/items">
<xsl:value-of select="$breadcrumb_separator"/>
<xsl:value-of select="$ca/items/@label"/>
</xsl:if>
</xsl:when>
<xsl:otherwise><xsl:value-of select="key('label','campaigns')/@tr"/></xsl:otherwise>
</xsl:choose>
</div>
</xsl:template>


<!-- ###############################
     CAMPAIGN CONTENT
     ############################### -->
<xsl:template name="campaignContent">
<xsl:choose>
<xsl:when test="$subtype='info' and $ca/thanks">
<xsl:call-template name="campaignThanks"/>
</xsl:when>
<xsl:when test="$subtype='info' and not($ca/thanks)">
<xsl:call-template name="campaignInfo"/>
</xsl:when>
<xsl:when test="$subtype='sign_person' and $ca/@active='1' ">
<xsl:call-template name="campaignSignPerson"/>
</xsl:when>
<xsl:when test="$subtype='sign_org' and $ca/@orgs_sign='1' and $ca/@active='1' ">
<xsl:call-template name="campaignSignOrg"/>
</xsl:when>
<xsl:when test="$subtype='signatures_person'">
<xsl:call-template name="items">
<xsl:with-param name="root" select="$ca/items"/>
<xsl:with-param name="node" select="$ca/signatures/person"/>
</xsl:call-template>
</xsl:when>
<xsl:when test="$subtype='signatures_org' and $ca/@orgs_sign='1' ">
<xsl:call-template name="items">
<xsl:with-param name="root" select="$ca/items"/>
<xsl:with-param name="node" select="$ca/signatures/org"/>
</xsl:call-template>
</xsl:when>
<xsl:when test="$subtype='insert'">
<xsl:call-template name="campaignInsert"/>
</xsl:when>
</xsl:choose>
</xsl:template>


<!-- ###############################
     CAMPAIGN FUNDING
     ############################### -->
<xsl:template name="campaignFunding">
<xsl:call-template name="funding">
<xsl:with-param name="node" select="$ca/funding"/>
</xsl:call-template>
</xsl:template>


<!-- ###############################
     CAMPAIGN INFO
     ############################### -->
<xsl:template name="campaignInfo">
<xsl:if test="$ca/@active='2'">
<p class="over"><xsl:value-of select="key('label','campaign_over')/@tr"/></p>
</xsl:if>

<xsl:if test="$ca/@promoter!=''"><div id="campaign-promoter"><xsl:value-of select="concat(key('label','promoter')/@tr,': ',$ca/@promoter)"/></div></xsl:if>
<div id="campaign-description"><xsl:value-of select="$ca/description" disable-output-escaping="yes"/></div>
<div id="campaign-description-long"><xsl:value-of select="$ca/description_long" disable-output-escaping="yes"/></div>
<xsl:if test="$ca/vips">
<p id="vips"><xsl:value-of select="$ca/vips/@label"/><xsl:text> </xsl:text> 
<xsl:for-each select="$ca/vips/person"><xsl:value-of select="@name"/><xsl:if test="position()!=last()">, </xsl:if></xsl:for-each>
</p>
</xsl:if>

<xsl:if test="$ca/@active='1'">
<h2><xsl:value-of select="key('label','sign')/@tr"/>:</h2>
<ul class="sign-options">
<li>
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="$ca/sign/person"/>
<xsl:with-param name="name" select="key('label','as_person')/@tr"/>
</xsl:call-template>
</li>
<xsl:if test="$ca/@orgs_sign='1' ">
<li>
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="$ca/sign/org"/>
<xsl:with-param name="name" select="key('label','as_org')/@tr"/>
</xsl:call-template>
</li>
</xsl:if>
</ul>
</xsl:if>

<xsl:call-template name="campaignSignatures"/>
</xsl:template>


<!-- ###############################
     CAMPAIGN INSERT
     ############################### -->
<xsl:template name="campaignInsert">
<xsl:if test="/root/campaign_insert/@users &gt; 0">
<xsl:choose>
<xsl:when test="(/root/campaign_insert/@users='1' and /root/user/@auth!='1') or (/root/campaign_insert/@users='2' and not(/root/user/@id &gt; 0)) ">
<xsl:call-template name="loginFirst">
<xsl:with-param name="node" select="/root/campaign_insert/login"/>
</xsl:call-template>
</xsl:when>
<xsl:otherwise>
<h2><xsl:value-of select="/root/campaign_insert/@label"/></h2>
<xsl:call-template name="javascriptForms"/>
<script type="text/javascript">
$().ready(function() {
	$("#campaign-insert").validate({
		rules: {
			title: "required",
			name: "required",
			email: {
				required: true,
				email:	true
			}
		}
	});
});
</script>
<p><xsl:value-of select="key('label','insert_desc')/@tr"/></p>
<form action="{/root/campaign_insert/@submit}" method="post" id="campaign-insert" accept-charset="{/root/site/@encoding}">
<input type="hidden" name="from" value="campaign"/>
<input type="hidden" name="action" value="propose"/>
<input type="hidden" name="id_topic" value="{/root/topic/@id}"/>
<ul class="form-inputs">
<fieldset>
<legend><xsl:value-of select="key('label','campaign')/@tr"/></legend>
<ul class="form-inputs">
<xsl:call-template name="formInput">
<xsl:with-param name="varname">title</xsl:with-param>
<xsl:with-param name="required" select="true()"/>
</xsl:call-template>
<xsl:call-template name="formInput">
<xsl:with-param name="varname">description</xsl:with-param>
<xsl:with-param name="type">textarea</xsl:with-param>
</xsl:call-template>
</ul>
</fieldset>
<fieldset>
<legend><xsl:value-of select="key('label','promoter')/@tr"/></legend>
<ul class="form-inputs">
<xsl:call-template name="formInput">
<xsl:with-param name="varname">name</xsl:with-param>
<xsl:with-param name="required" select="true()"/>
<xsl:with-param name="value" select="/root/user/@name"/>
</xsl:call-template>
<xsl:call-template name="formInput">
<xsl:with-param name="varname">email</xsl:with-param>
<xsl:with-param name="value" select="/root/user/@email"/>
<xsl:with-param name="required" select="true()"/>
</xsl:call-template>
</ul>
</fieldset>

<xsl:call-template name="formInput">
<xsl:with-param name="varname">privacy</xsl:with-param>
<xsl:with-param name="type">checkbox</xsl:with-param>
<xsl:with-param name="tr_label"><xsl:value-of select="/root/campaign_insert/privacy_warning" disable-output-escaping="yes"/></xsl:with-param>
<xsl:with-param name="value" select="true()"/>
</xsl:call-template>
<li class="buttons"><input type="submit" value="{key('label','submit')/@tr}" name="action_sign"/></li>
</ul>
</form>

</xsl:otherwise>
</xsl:choose>
</xsl:if>
</xsl:template>


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
<xsl:call-template name="campaignSignPersonValidation"/>
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


<!-- ###############################
     CAMPAIGN SIGN PERSON CUSTOM
     ############################### -->
<xsl:template name="campaignSignPersonCustom">
<xsl:call-template name="formInput">
<xsl:with-param name="varname">param_job</xsl:with-param>
<xsl:with-param name="label">job</xsl:with-param>
</xsl:call-template>
</xsl:template>


<!-- ###############################
     CAMPAIGN SIGN PERSON VALIDATION
     ############################### -->
<xsl:template name="campaignSignPersonValidation">
<script type="text/javascript">
$().ready(function() {
	$("#sign").validate({
		rules: {
			name: "required",
			surname: "required",
			email: {
				required: true,
				email:	true
			}
		}
	});
});
</script>
</xsl:template>


<!-- ###############################
     CAMPAIGN SIGN ORG
     ############################### -->
<xsl:template name="campaignSignOrg">
<p><xsl:value-of select="key('label','signature_org')/@tr"/></p>
<div id="pre-sign"><xsl:value-of select="$ca/pre_sign" disable-output-escaping="yes"/></div>
<xsl:call-template name="javascriptForms"/>
<xsl:call-template name="campaignSignOrgValidation"/>
<p><xsl:value-of select="key('label','insert_desc')/@tr"/></p>
<form action="{/root/campaign/@submit}" method="post" id="sign" accept-charset="{/root/site/@encoding}">
<input type="hidden" name="from" value="org"/>
<input type="hidden" name="action" value="insert"/>
<input type="hidden" name="id_campaign" value="{$ca/@id}"/>
<input type="hidden" name="id_topic" value="{/root/topic/@id}"/>

<ul class="form-inputs">
<li class="form-notes"><xsl:call-template name="signIntro"/></li>
<xsl:call-template name="formInput">
<xsl:with-param name="varname">name</xsl:with-param>
<xsl:with-param name="label">org</xsl:with-param>
<xsl:with-param name="required" select="true()"/>
</xsl:call-template>
<xsl:call-template name="formInput">
<xsl:with-param name="varname">contact_main</xsl:with-param>
</xsl:call-template>
<xsl:call-template name="formInput">
<xsl:with-param name="varname">address</xsl:with-param>
</xsl:call-template>
<xsl:call-template name="formInputGeo"/>
<xsl:call-template name="formInput">
<xsl:with-param name="varname">phone</xsl:with-param>
</xsl:call-template>
<xsl:call-template name="formInput">
<xsl:with-param name="varname">email</xsl:with-param>
<xsl:with-param name="required" select="true()"/>
</xsl:call-template>
<xsl:call-template name="formInput">
<xsl:with-param name="varname">website</xsl:with-param>
</xsl:call-template>
<xsl:call-template name="campaignSignOrgCustom"/>
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
<xsl:call-template name="privacyWarning">
<xsl:with-param name="node" select="$ca/privacy_warning"/>
</xsl:call-template>
<li class="form-notes"><xsl:call-template name="signNotes"/></li>
<xsl:if test="$ca/@notify"><li class="form-notes"><xsl:value-of select="$ca/@notify"/></li></xsl:if>
<li class="buttons"><input type="submit" value="{key('label','submit')/@tr}" name="action_sign"/></li>
</ul>
<xsl:call-template name="signFooter"/>
</form>
</xsl:template>


<!-- ###############################
     CAMPAIGN SIGN ORG CUSTOM
     ############################### -->
<xsl:template name="campaignSignOrgCustom">
</xsl:template>


<!-- ###############################
     CAMPAIGN SIGN ORG VALIDATION
     ############################### -->
<xsl:template name="campaignSignOrgValidation">
<script type="text/javascript">
$().ready(function() {
	$("#sign").validate({
		rules: {
			name: "required",
			email: {
				required: true,
				email:	true
			}
		}
	});
});
</script>
</xsl:template>


<!-- ###############################
     CAMPAIGN SIGNATURES
     ############################### -->
<xsl:template name="campaignSignatures">
<p>
<xsl:value-of select="key('label','signatures_since')/@tr"/>
<xsl:text> </xsl:text>
<xsl:value-of select="$ca/@start_date"/>: 
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="$ca/signatures/person"/>
<xsl:with-param name="name" select="concat($ca/stats/@persons,' ',key('label','persons')/@tr)"/>
<xsl:with-param name="condition" select="$ca/stats/@persons &gt; 0"/>
</xsl:call-template>
<xsl:if test="$ca/@orgs_sign='1' ">
, 
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="$ca/signatures/org"/>
<xsl:with-param name="name" select="concat($ca/stats/@orgs,' ',key('label','orgs')/@tr)"/>
<xsl:with-param name="condition" select="$ca/stats/@orgs &gt; 0"/>
</xsl:call-template>
</xsl:if>
</p>
</xsl:template>


<!-- ###############################
     CAMPAIGN THANKS
     ############################### -->
<xsl:template name="campaignThanks">
<div id="campaign-thanks"><xsl:value-of select="$ca/thanks" disable-output-escaping="yes"/></div>
<xsl:if test="$ca/comment">
<div><xsl:value-of select="$ca/comment" disable-output-escaping="yes"/></div>
</xsl:if>
<xsl:if test="$ca/@notify"><p><xsl:value-of select="$ca/@notify"/></p></xsl:if>
<xsl:choose>
<xsl:when test="$ca/payment/@id &gt; 0">
<p><xsl:value-of select="$ca/payment/@label"/></p>
<xsl:choose>
<xsl:when test="$ca/payment/account/@id_type='3' or $ca/payment/account/@id_type='4' ">
<p><xsl:value-of select="$ca/payment/account/@label"/></p>
<xsl:call-template name="paypal">
<xsl:with-param name="amount" select="$ca/payment/@amount"/>
<xsl:with-param name="params_node" select="$ca/payment/account/params"/>
<xsl:with-param name="currency" select="$ca/payment/@currency_code"/>
<xsl:with-param name="description" select="concat(key('label','campaign')/@tr,': ',/root/campaign/@title)"/>
<xsl:with-param name="item_number" select="concat('campaign-',/root/campaign/@id)"/>
<xsl:with-param name="token" select="$ca/payment/@token"/>
<xsl:with-param name="subscription" select="$ca/payment/account/@id_type='4'"/>
<xsl:with-param name="lang_code" select="$ca/payment/@lang_code"/>
</xsl:call-template>
</xsl:when>
<xsl:otherwise>
<p><xsl:value-of select="$ca/payment/@description"/></p>
<h3><xsl:value-of select="$ca/payment/account/@label"/></h3>
<ul id="account-params">
<xsl:for-each select="$ca/payment/account/params/param">
<li><xsl:value-of select="concat(@label,': ',@value)"/></li>
</xsl:for-each>
</ul>
</xsl:otherwise>
</xsl:choose>

</xsl:when>
<xsl:otherwise>
<xsl:call-template name="campaignSignatures"/>
</xsl:otherwise>
</xsl:choose>
</xsl:template>


<!-- ###############################
     ORG ITEM
     ############################### -->
<xsl:template name="orgItem">
<xsl:param name="i"/>
<xsl:value-of select="$i/@rev_pos"/>. <xsl:value-of select="$i/@name"/>
<xsl:if test="$i/@geo!=''"> - <xsl:value-of select="$i/@geo"/></xsl:if> 
(<xsl:value-of select="$i/@insert_date"/>)
<xsl:if test="$i/comments">
<div class="comment"><xsl:value-of select="$i/comments" disable-output-escaping="yes"/></div>
</xsl:if>
</xsl:template>


<!-- ###############################
     PERSON ITEM
     ############################### -->
<xsl:template name="personItem">
<xsl:param name="i"/>
<xsl:value-of select="$i/@rev_pos"/>. <xsl:value-of select="$i/@name"/>
<xsl:if test="$i/@geo!=''"> - <xsl:value-of select="$i/@geo"/></xsl:if> 
(<xsl:value-of select="$i/@insert_date"/>)
<xsl:if test="$i/comments">
<div class="comment"><xsl:value-of select="$i/comments" disable-output-escaping="yes"/></div>
</xsl:if>
</xsl:template>


<!-- ###############################
     SIGN CONTACT WARNING
     ############################### -->
<xsl:template name="signContactWarning">
<xsl:value-of select="$ca/contact_warning" disable-output-escaping="yes"/>
</xsl:template>


<!-- ###############################
     SIGN INTRO
     ############################### -->
<xsl:template name="signIntro">
</xsl:template>


<!-- ###############################
     SIGN FOOTER
     ############################### -->
<xsl:template name="signFooter">
</xsl:template>


<!-- ###############################
     SIGN NOTES
     ############################### -->
<xsl:template name="signNotes">
<p><xsl:value-of select="$ca/submit_warning" disable-output-escaping="yes"/></p>
</xsl:template>



</xsl:stylesheet>
