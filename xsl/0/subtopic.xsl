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

<xsl:variable name="current_page_title">
<xsl:value-of select="/root/topic/@name"/> - <xsl:value-of select="/root/subtopic/@name"/>
</xsl:variable>


<!-- ###############################
     CONTENT
     ############################### -->
<xsl:template name="content">
	<xsl:if test="/root/subtopic/@visible=1">
		<xsl:call-template name="breadcrumb"/>
	</xsl:if>
	<div class="subtopic-headings">
		<h1><xsl:value-of select="/root/subtopic/@name"/></h1>
		<div class="description"><xsl:value-of select="/root/subtopic/@description" disable-output-escaping="yes"/></div>
	</div>
	<xsl:if test="/root/subtopic/subtopics">
		<xsl:call-template name="subtopics"/>
	</xsl:if>
	<div class="header"><xsl:apply-templates select="/root/subtopic/header" /></div>
	<xsl:call-template name="subtopic"/>
	<div class="footer"><xsl:apply-templates select="/root/subtopic/footer" /></div>
</xsl:template>


<!-- ###############################
     CONTACT
     ############################### -->
<xsl:template name="contact">
<xsl:param name="form_node" select="/root/subtopic/content"/>
<xsl:variable name="upload_progress" select="$form_node/@progress_key!=''"/>
<xsl:if test="$form_node/doc">
<xsl:call-template name="subtopicFormDoc"/>
</xsl:if>
<xsl:choose>
<xsl:when test="$subtype='contact' ">
<xsl:if test="$form_node/payment/@id &gt; 0">
<p><xsl:value-of select="$form_node/payment/@label"/></p>
<xsl:choose>
<xsl:when test="$form_node/payment/account/@id_type='3' or $form_node/payment/account/@id_type='4'">
<p><xsl:value-of select="$form_node/payment/account/@label"/></p>
<xsl:call-template name="paypal">
<xsl:with-param name="amount" select="$form_node/payment/@amount"/>
<xsl:with-param name="params_node" select="$form_node/payment/account/params"/>
<xsl:with-param name="currency" select="$form_node/payment/@currency_code"/>
<xsl:with-param name="description" select="$form_node/payment/@reason"/>
<xsl:with-param name="item_number" select="concat('form-',$form_node/@id_form)"/>
<xsl:with-param name="token" select="$form_node/payment/@token"/>
<xsl:with-param name="subscription" select="$form_node/payment/account/@id_type='4'"/>
<xsl:with-param name="lang_code" select="$form_node/payment/@lang_code"/>
</xsl:call-template>
</xsl:when>
<xsl:otherwise>
<p><xsl:value-of select="$form_node/payment/@description"/></p>
<h3><xsl:value-of select="$form_node/payment/account/@label"/></h3>
<ul id="account-params">
<xsl:for-each select="$form_node/payment/account/params/param">
<li><xsl:value-of select="concat(@label,': ',@value)"/></li>
</xsl:for-each>
</ul>
</xsl:otherwise>
</xsl:choose>
</xsl:if>
</xsl:when>
<xsl:when test="$form_node/@require_auth='0'">
<!-- Do nothing, form is closed -->
</xsl:when>
<xsl:when test="$form_node/login">
<xsl:call-template name="loginFirst">
<xsl:with-param name="node" select="$form_node/login"/>
</xsl:call-template>
</xsl:when>
<xsl:otherwise>
<xsl:call-template name="javascriptForms"/>
<script type="text/javascript">
<xsl:if test="$upload_progress=true()">
var progress_key = '<xsl:value-of select="$form_node/@progress_key"/>';
</xsl:if>
$().ready(function() {
<xsl:if test="$upload_progress=true()">
	$("#uploadprogressbar").progressBar();
	$("#uploadprogressbar").toggle();
	$("form").submit(function() {
		var fileinput = $(":file[value!='']");
		if(fileinput.length > 0) {
			$(".input-submit:first").css("background-color","#999999");
			$(".input-submit:gt(0)").toggle();
			$('#uploadprogressbar').progressBar({ barImage: '/js/jquery/progress-images/progressbg_orange.gif'});
			$("#uploadprogressbar").fadeIn();
			setTimeout("showUpload()", 750);
		}
	});
</xsl:if>
	$("#form<xsl:value-of select="$form_node/@id_form"/>").validate({
		rules: {
<xsl:for-each select="$form_node/params/param[@mandatory='1']">
	<xsl:choose>
	<xsl:when test="@type='text' and @use='4'">
		param_<xsl:value-of select="@id"/>: { required: true, email: true }
	</xsl:when>
	<xsl:otherwise>
		param_<xsl:value-of select="@id"/>: "required"
	</xsl:otherwise>
	</xsl:choose>
	<xsl:if test="position()!=last()">,</xsl:if>
</xsl:for-each>
		}
	});
<xsl:for-each select="$form_node/params/param[@type='date']">
	$("input#param_<xsl:value-of select="@id"/>").datepicker({ dateFormat: "dd-mm-yy" });
</xsl:for-each>
});
</script>
<form method="post" id="form{$form_node/@id_form}" accept-charset="{/root/site/@encoding}">
<xsl:choose>
<xsl:when test="$form_node/params/param/@type='upload' or $form_node/params/param/@type='upload_image'">
<xsl:attribute name="enctype">multipart/form-data</xsl:attribute>
<xsl:attribute name="action"><xsl:value-of select="/root/site/@upload_host"/>/tools/actions.php</xsl:attribute>
</xsl:when>
<xsl:otherwise>
<xsl:attribute name="action"><xsl:value-of select="/root/site/@base"/>/tools/actions.php</xsl:attribute>
</xsl:otherwise>
</xsl:choose>
<input type="hidden" name="from" value="form"/>
<input type="hidden" name="id_topic" value="{/root/topic/@id}"/>
<input type="hidden" name="id_subtopic" value="{/root/subtopic/@id}"/>
<input type="hidden" name="id_form" value="{$form_node/@id_form}"/>
<xsl:if test="$form_node/@require_auth='1' or $form_node/@require_auth='2'">
<input type="hidden" name="id_p" value="{/root/user/@id}"/>
</xsl:if>
<xsl:if test="$form_node/@id_doc">
<input type="hidden" name="id_doc" value="{$form_node/@id_doc}"/>
</xsl:if>
<xsl:if test="$upload_progress=true()">
<script type="text/javascript" src="/js/jquery/jquery-progressbar.min.js"></script>
<input id="progress_key" name="UPLOAD_IDENTIFIER" type="hidden" value="{$form_node/@progress_key}"/>";
</xsl:if>
<ul class="form-inputs">
<xsl:apply-templates select="$form_node/params/param" mode="custom"/>
<xsl:if test="$form_node/funding">
<xsl:call-template name="funding">
<xsl:with-param name="node" select="$form_node/funding"/>
</xsl:call-template>
</xsl:if>
<xsl:call-template name="contactCheckbox"/>
<xsl:if test="$form_node/@captcha='1' and /root/site/@captcha">
<li class="clearfix">
<xsl:call-template name="captchaWrapper"/>
</li>
</xsl:if>
<xsl:if test="$form_node/privacy_warning">
<xsl:call-template name="privacyWarning"/>
</xsl:if>
<li class="buttons"><input type="submit" value="{key('label','submit')/@tr}"/>
<xsl:if test="$upload_progress=true()"><span id="uploadprogressbar" class="progressbar"></span></xsl:if>
</li>
</ul>
</form>
</xsl:otherwise>
</xsl:choose>
</xsl:template>


<!-- ###############################
     CONTACT CHECKBOX
     ############################### -->
<xsl:template name="contactCheckbox">
<xsl:call-template name="formInput">
<xsl:with-param name="varname">contact</xsl:with-param>
<xsl:with-param name="type">checkbox</xsl:with-param>
<xsl:with-param name="tr_label"><xsl:value-of select="/root/subtopic/content/contact_warning" disable-output-escaping="yes"/></xsl:with-param>
<xsl:with-param name="value" select="true()"/>
</xsl:call-template>
</xsl:template>


<!-- ###############################
     SUBTOPICS
     ############################### -->
<xsl:template name="subtopics">
<ul class="subtopics">
<xsl:apply-templates select="/root/subtopic/subtopics" mode="details"/>
</ul>
</xsl:template>


<!-- ###############################
     SUBTOPIC
     ############################### -->
<xsl:template match="subtopic" mode="details">
<li>
<xsl:attribute name="class">
<xsl:choose>
<xsl:when test="(position() mod 4) = 2">col1</xsl:when>
<xsl:otherwise>col2</xsl:otherwise>
</xsl:choose>
</xsl:attribute>
<xsl:call-template name="subtopicItem">
<xsl:with-param name="s" select="."/>
</xsl:call-template>
</li>
</xsl:template>


<!-- ###############################
     SUBTOPIC FORM DOC
     ############################### -->
<xsl:template name="subtopicFormDoc">
<xsl:param name="doc_node" select="/root/subtopic/content/doc"/>
<div class="subtopic-doc">
<xsl:if test="$doc_node/cover">
<img width="{$doc_node/cover/@width}" alt="{$doc_node/@title}" class="left">
<xsl:attribute name="src">
<xsl:call-template name="createLinkUrl">
<xsl:with-param name="node" select="$doc_node/cover"/>
</xsl:call-template>
</xsl:attribute>
</img>
</xsl:if>
<h3 class="title"><xsl:value-of select="$doc_node/@title"/></h3>
<xsl:if test="$doc_node/@author!='' or $doc_node/source!=''">
<div class="notes"><xsl:value-of select="$doc_node/@author"/>
<xsl:if test="$doc_node/source!=''"><xsl:value-of select="concat(' - ',key('label','source')/@tr,': ')"/><xsl:value-of select="$doc_node/source" disable-output-escaping="yes"/></xsl:if>
</div>
</xsl:if>
<xsl:if test="$doc_node/description!=''"><div class="doc-description"><xsl:value-of select="$doc_node/description" disable-output-escaping="yes"/></div></xsl:if>
<div class="file-info">(<xsl:value-of select="concat($doc_node/file_info/@kb,' Kb - ',key('label','format')/@tr,' ',$doc_node/file_info/@format,')')"/></div>
<xsl:call-template name="licenceInfo">
<xsl:with-param name="i" select="$doc_node"/>
</xsl:call-template>
</div>
<div class="form-doc-download"><xsl:value-of select="$doc_node/@download_label"/></div>
</xsl:template>


<!-- ###############################
     SUBTOPIC INSERT
     ############################### -->
<xsl:template name="subtopicInsert">
<xsl:choose>
<xsl:when test="$subtype='0'">
<xsl:call-template name="insertArticle"/>
</xsl:when>
<xsl:when test="$subtype='1'">
<xsl:call-template name="insertLink"/>
</xsl:when>
</xsl:choose>
</xsl:template>


<!-- ###############################
     SUBTOPIC DYNAMIC
     ############################### -->
<xsl:template name="subtopicDynamic">
</xsl:template>


<!-- ###############################
     INSERT ARTICLE
     ############################### -->
<xsl:template name="insertArticle">
<xsl:call-template name="javascriptForms"/>
<script type="text/javascript">
$().ready(function() {
	$("#insert-article").validate({
		rules: {
			headline: "required",
			content: "required",
			email: {
				required: true,
				email:	true
			}
		}
	});
});
</script>
<form action="{/root/site/@base}/tools/actions.php" method="post" id="insert-article" accept-charset="{/root/site/@encoding}">
<input type="hidden" name="from" value="article"/>
<input type="hidden" name="id_topic" value="{/root/topic/@id}"/>
<input type="hidden" name="id_subtopic" value="{/root/subtopic/@id}"/>
<p class="form-notes"><xsl:value-of select="key('label','article_insert_public')/@tr"/></p>
<fieldset>
<legend><xsl:value-of select="key('label','text')/@tr"/></legend>
<ul class="form-inputs">
<xsl:call-template name="formInput">
<xsl:with-param name="varname">author</xsl:with-param>
</xsl:call-template>
<xsl:call-template name="formInput">
<xsl:with-param name="varname">author_notes</xsl:with-param>
</xsl:call-template>
<xsl:call-template name="formInput">
<xsl:with-param name="varname">source</xsl:with-param>
<xsl:with-param name="type">textarea</xsl:with-param>
</xsl:call-template>
<xsl:call-template name="formInput">
<xsl:with-param name="varname">halftitle</xsl:with-param>
</xsl:call-template>
<xsl:call-template name="formInput">
<xsl:with-param name="varname">headline</xsl:with-param>
<xsl:with-param name="label">title</xsl:with-param>
<xsl:with-param name="required" select="true()"/>
</xsl:call-template>
<xsl:call-template name="formInput">
<xsl:with-param name="varname">subhead</xsl:with-param>
<xsl:with-param name="label">subhead_instr</xsl:with-param>
<xsl:with-param name="type">textarea</xsl:with-param>
</xsl:call-template>
<xsl:call-template name="formInput">
<xsl:with-param name="varname">content</xsl:with-param>
<xsl:with-param name="label">text</xsl:with-param>
<xsl:with-param name="type">textarea</xsl:with-param>
<xsl:with-param name="size">extralarge</xsl:with-param>
</xsl:call-template>
<xsl:call-template name="formInput">
<xsl:with-param name="varname">notes</xsl:with-param>
<xsl:with-param name="label">content_notes</xsl:with-param>
<xsl:with-param name="type">textarea</xsl:with-param>
</xsl:call-template>
</ul>
</fieldset>
<fieldset>
<legend><xsl:value-of select="key('label','submitted_by')/@tr"/></legend>
<ul class="form-inputs">
<xsl:call-template name="formInput">
<xsl:with-param name="varname">name</xsl:with-param>
<xsl:with-param name="required" select="true()"/>
<xsl:with-param name="value" select="/root/user/@name"/>
</xsl:call-template>
<xsl:call-template name="formInput">
<xsl:with-param name="varname">email</xsl:with-param>
<xsl:with-param name="required" select="true()"/>
<xsl:with-param name="value" select="/root/user/@email"/>
</xsl:call-template>
<xsl:if test="/root/subtopic/content/privacy_warning">
<xsl:call-template name="privacyWarning">
<xsl:with-param name="node" select="/root/subtopic/content/privacy_warning"/>
</xsl:call-template>
</xsl:if>
<xsl:if test="/root/site/@captcha">
    <li class="clearfix">
        <xsl:call-template name="captchaWrapper"/>
    </li>
</xsl:if>
<li class="buttons"><input type="submit" value="{key('label','submit')/@tr}"/></li>
</ul>
</fieldset>
</form>
</xsl:template>


<!-- ###############################
     INSERT LINK
     ############################### -->
<xsl:template name="insertLink">
<xsl:call-template name="javascriptForms"/>
<script type="text/javascript">
$().ready(function() {
	$("#insert-link").validate({
		rules: {
			link: "required",
			title: "required"
		}
	});
});
</script>
<form action="{/root/site/@base}/tools/actions.php" method="post" id="insert-link" accept-charset="{/root/site/@encoding}">
<input type="hidden" name="from" value="link"/>
<input type="hidden" name="id_topic" value="{/root/topic/@id}"/>
<input type="hidden" name="id_subtopic" value="{/root/subtopic/@id}"/>
<ul class="form-inputs">
<xsl:call-template name="formInput">
<xsl:with-param name="varname">link</xsl:with-param>
<xsl:with-param name="required" select="true()"/>
</xsl:call-template>
<xsl:call-template name="formInput">
<xsl:with-param name="varname">title</xsl:with-param>
<xsl:with-param name="required" select="true()"/>
</xsl:call-template>
<xsl:call-template name="formInput">
<xsl:with-param name="varname">description</xsl:with-param>
<xsl:with-param name="type">textarea</xsl:with-param>
</xsl:call-template>
<xsl:if test="/root/site/@captcha">
    <li class="clearfix">
        <xsl:call-template name="captchaWrapper"/>
    </li>
</xsl:if>
<li class="buttons"><input type="submit" value="{key('label','submit')/@tr}"/></li>
</ul>
</form>
</xsl:template>

</xsl:stylesheet>

