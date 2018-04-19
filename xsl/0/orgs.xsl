<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!--********************************************************************

   PhPeace - Portal Management System

   Copyright notice
   (C) 2003-2018 Francesco Iannuzzelli <francesco@phpeace.org>
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

<xsl:variable name="title">
<xsl:choose>
<xsl:when test="$subtype='search'">
<xsl:value-of select="key('label','org_search')/@tr"/>
</xsl:when>
<xsl:when test="$subtype='search_advanced'">
<xsl:value-of select="/root/orgs/search_advanced/@label"/>
</xsl:when>
<xsl:when test="$subtype='insert' ">
<xsl:value-of select="key('label','org_insert')/@tr"/>
<xsl:if test="/root/orgs/asso/@id &gt; 0">
<xsl:value-of select="concat($breadcrumb_separator,/root/orgs/asso/@name)"/>
</xsl:if>
</xsl:when>
<xsl:when test="$subtype='org' ">
<xsl:value-of select="/root/orgs/asso/@name"/>
</xsl:when>
<xsl:when test="$subtype='keyword' ">
<xsl:choose>
<xsl:when test="/root/orgs/keyword/@name !='' ">
<xsl:value-of select="/root/orgs/keyword/@name"/>
</xsl:when>
<xsl:otherwise><xsl:value-of select="key('label','activities')/@tr"/></xsl:otherwise>
</xsl:choose>
</xsl:when>
<xsl:otherwise>
<xsl:value-of select="key('label','homepage')/@tr"/>
</xsl:otherwise>
</xsl:choose>
</xsl:variable>

<xsl:variable name="current_page_title" select="concat(key('label','orgs')/@tr,' - ',$title)"/>


<!-- ###############################
     CONTENT
     ############################### -->
<xsl:template name="content">
<xsl:call-template name="orgsBreadcrumb"/>
<xsl:call-template name="feedback"/>
<div id="orgs-{$subtype}" class="orgs-content">
<xsl:choose>
<xsl:when test="/root/orgs/@access_protected='1' and /root/orgs/login">
<xsl:call-template name="createLink">
<xsl:with-param name="name" select="/root/orgs/login/@label"/>
<xsl:with-param name="node" select="/root/orgs/login"/>
</xsl:call-template>
</xsl:when>
<xsl:otherwise>
	<xsl:choose>
	<xsl:when test="$subtype='search' or $subtype='search_advanced' ">
	<xsl:call-template name="orgSearch"/>
	</xsl:when>
	<xsl:when test="$subtype='insert'">
	<xsl:choose>
		<xsl:when test="/root/orgs/keywords and /root/orgs/keywords/@id &gt; 0"><xsl:call-template name="orgInsertKeywordParams"/></xsl:when>
		<xsl:when test="/root/orgs/keywords and /root/orgs/asso/@id &gt; 0"><xsl:call-template name="orgInsertKeywords"/></xsl:when>
		<xsl:otherwise><xsl:call-template name="orgInsert"/></xsl:otherwise>
	</xsl:choose>
	</xsl:when>
	<xsl:when test="$subtype='org'">
		<xsl:call-template name="org"/>
	</xsl:when>
	<xsl:when test="$subtype='keyword'">
	<xsl:call-template name="orgsKeyword"/>
	</xsl:when>
	<xsl:when test="$subtype='type'">
	<xsl:call-template name="orgsType"/>
	</xsl:when>
	<xsl:otherwise>
	<xsl:call-template name="orgsHome"/>
	</xsl:otherwise>
	</xsl:choose>
</xsl:otherwise>
</xsl:choose>
</div>
</xsl:template>


<!-- ###############################
     ORG
     ############################### -->
<xsl:template name="org">
<xsl:variable name="o" select="/root/orgs/asso"/>
<h1 class="org-name"><xsl:value-of select="$o/@name"/></h1>
<xsl:if test="$o/image">
<img class="org-image" width="{$o/image/@width}" alt="Logo {$o/@name}">
<xsl:attribute name="src">
<xsl:call-template name="createLinkUrl">
<xsl:with-param name="node" select="$o/image"/>
</xsl:call-template>
</xsl:attribute>
</img>
</xsl:if>
<div class="org-details">
<xsl:if test="$o/@name2!=''"><div class="org-name"><xsl:value-of select="$o/@name2"/></div></xsl:if>
<div class="org-type"><xsl:value-of select="key('label','type')/@tr"/>: <xsl:value-of select="$o/@asso_type"/></div>
<div class="org-address"><xsl:value-of select="key('label','address')/@tr"/>: <xsl:value-of select="$o/@address"/></div>
<xsl:if test="$o/@phone"><div class="org-postcode"><xsl:value-of select="key('label','postcode')/@tr"/>: <xsl:value-of select="$o/@postcode"/></div></xsl:if>
<div class="org-town"><xsl:value-of select="key('label','town')/@tr"/>: <xsl:value-of select="concat($o/@town,' (',$o/@geo_name,')')"/></div>
<xsl:if test="$o/@phone"><div class="org-phone">Tel: <xsl:value-of select="$o/@phone"/></div></xsl:if>
<xsl:if test="$o/@fax"><div class="org-phone">Fax: <xsl:value-of select="$o/@fax"/></div></xsl:if>
<xsl:if test="$o/@email"><div class="org-email"><xsl:value-of select="key('label','email')/@tr"/>: <a href="mailto:{$o/@email}"><xsl:value-of select="$o/@email"/></a></div></xsl:if>
<xsl:if test="$o/@website"><div class="org-website"><xsl:value-of select="key('label','website')/@tr"/>: <a href="{$o/@website}" target="_blank"><xsl:value-of select="$o/@website	"/></a></div></xsl:if>
<xsl:if test="$o/@contact"><div class="org-contact">Referente: <xsl:value-of select="$o/@contact"/></div></xsl:if>
<xsl:if test="$o/@ccp"><div class="org-ccp">Conto Corrente Postale: <xsl:value-of select="$o/@ccp"/></div></xsl:if>
<xsl:if test="$o/@publish"><div class="org-pub">Pubblicazioni: <xsl:value-of select="$o/@publish"/></div></xsl:if>
<xsl:if test="$o/description"><p class="org-description"><xsl:value-of select="$o/description" disable-output-escaping="yes"/></p></xsl:if>
</div>
<xsl:if test="/root/orgs/asso/keywords/keyword">
<xsl:call-template name="orgKeywords"/>
</xsl:if>
<xsl:if test="/root/orgs/asso/docs">
<xsl:call-template name="orgDocs">
<xsl:with-param name="docs" select="/root/orgs/asso/docs"/>
</xsl:call-template>
</xsl:if>
</xsl:template>



<!-- ###############################
     ORGS BREADCRUMB
     ############################### -->
<xsl:template name="orgsBreadcrumb">
<div class="breadcrumb">
<xsl:call-template name="createLink">
<xsl:with-param name="name" select="key('label','orgs')/@tr"/>
<xsl:with-param name="node" select="/root/orgs"/>
</xsl:call-template>
<xsl:choose>
<xsl:when test="$subtype='keyword' ">
<xsl:value-of select="$breadcrumb_separator"/>
<xsl:call-template name="createLink">
<xsl:with-param name="name" select="key('label','activities')/@tr"/>
<xsl:with-param name="node" select="/root/orgs/keywords"/>
</xsl:call-template>
<xsl:for-each select="/root/orgs/keyword/path/keyword">
<xsl:value-of select="$breadcrumb_separator"/>
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="."/>
</xsl:call-template>
</xsl:for-each>
</xsl:when>
<xsl:when test="$subtype='search' ">
<xsl:value-of select="$breadcrumb_separator"/>
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="/root/orgs/search"/>
<xsl:with-param name="name" select="$title"/>
</xsl:call-template>
</xsl:when>
<xsl:when test="$subtype='search_advanced' ">
<xsl:value-of select="$breadcrumb_separator"/>
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="/root/orgs/search_advanced"/>
<xsl:with-param name="name" select="$title"/>
</xsl:call-template>
</xsl:when>
<xsl:otherwise>
<xsl:if test="$title!='' ">
<xsl:value-of select="concat($breadcrumb_separator,$title)"/>
</xsl:if>
</xsl:otherwise>
</xsl:choose>
</div>
</xsl:template>


<!-- ###############################
     ORG DOCS
     ############################### -->
<xsl:template name="orgDocs">
<xsl:param name="docs"/>
<div id="org-docs">
<h3><xsl:value-of select="key('label','attachments')/@tr"/></h3>
<ul class="docs">
<xsl:for-each select="$docs/doc">
<li>
<div class="title">
<xsl:call-template name="createLink">
<xsl:with-param name="name" select="@title"/>
<xsl:with-param name="node" select="."/>
</xsl:call-template>
(<xsl:value-of select="concat(file_info/@kb,' Kb - ',key('label','format')/@tr,' ',file_info/@format,')')"/>
</div>
<xsl:if test="@author!='' or source!=''"><div class="notes"><xsl:value-of select="concat(key('label','author')/@tr,': ',@author)"/><xsl:if test="source!=''"><xsl:value-of select="concat(' - ',key('label','source')/@tr,': ')"/><xsl:value-of select="source" disable-output-escaping="yes"/></xsl:if></div></xsl:if>
<xsl:if test="description!=''"><div><xsl:value-of select="description" disable-output-escaping="yes"/></div></xsl:if>
<xsl:call-template name="licenceInfo">
<xsl:with-param name="i" select="."/>
</xsl:call-template>
<xsl:if test="file_info/format_info">
<div class="format-info"><xsl:value-of select="file_info/format_info" disable-output-escaping="yes"/></div>
</xsl:if>
</li>
</xsl:for-each>
</ul>
</div>
</xsl:template>



<!-- ###############################
     ORGS HOME
     ############################### -->
<xsl:template name="orgsHome">
<h2>Benvenuto</h2>
<ul>
<li>
<xsl:call-template name="createLink">
<xsl:with-param name="name" select="key('label','types')/@tr"/>
<xsl:with-param name="node" select="/root/orgs/type"/>
</xsl:call-template>
</li>
<li>
<xsl:call-template name="createLink">
<xsl:with-param name="name" select="key('label','activities')/@tr"/>
<xsl:with-param name="node" select="/root/orgs/keywords"/>
</xsl:call-template>
</li>
<li>
<xsl:call-template name="createLink">
<xsl:with-param name="name" select="key('label','org_search')/@tr"/>
<xsl:with-param name="node" select="/root/orgs/search"/>
</xsl:call-template>
</li>
<li>
<xsl:call-template name="createLink">
<xsl:with-param name="name" select="key('label','org_insert')/@tr"/>
<xsl:with-param name="node" select="/root/orgs/insert"/>
</xsl:call-template>
</li>
</ul>
</xsl:template>


<!-- ###############################
     ORG INSERT
     ############################### -->
<xsl:template name="orgInsert">
<xsl:call-template name="javascriptForms"/>
<script type="text/javascript">
$().ready(function() {
	$("#asso-insert").validate({
		rules: {
			id_asso_type: {
				required: true,
				min: 1
			},
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
<form action="{/root/site/@base}/{/root/orgs/@path}/actions.php" method="post" id="asso-insert" accept-charset="{/root/site/@encoding}">
<xsl:if test="/root/orgs/@upload='1'"><xsl:attribute name="enctype">multipart/form-data</xsl:attribute></xsl:if>
<input type="hidden" name="from" value="insert"/>
<xsl:if test="/root/topic">
<input type="hidden" name="id_topic" value="{/root/topic/@id}"/>
</xsl:if>
<fieldset>
<legend><xsl:value-of select="key('label','asso_data')/@tr"/></legend>
<ul class="form-inputs">
<li>
<xsl:if test="/root/posterrors/postvar/@name='asso_type' ">
<xsl:attribute name="class">wrong</xsl:attribute>
</xsl:if>
<label class="required"><xsl:value-of select="key('label','asso_type')/@tr"/></label>
<select name="id_asso_type">
<option value="0"><xsl:value-of select="key('label','choose_option')/@tr"/></option>
<xsl:for-each select="/root/orgs/types/type">
<option value="{@id}"><xsl:value-of select="@type"/></option>
</xsl:for-each>
</select>
</li>
<xsl:call-template name="formInput">
<xsl:with-param name="varname">name</xsl:with-param>
<xsl:with-param name="required" select="true()"/>
</xsl:call-template>
<xsl:call-template name="formInput">
<xsl:with-param name="varname">name2</xsl:with-param>
</xsl:call-template>
<xsl:call-template name="formInput">
<xsl:with-param name="varname">address</xsl:with-param>
<xsl:with-param name="type">textarea</xsl:with-param>
</xsl:call-template>
<xsl:call-template name="formInput">
<xsl:with-param name="varname">postcode</xsl:with-param>
<xsl:with-param name="size">small</xsl:with-param>
</xsl:call-template>
<xsl:call-template name="formInput">
<xsl:with-param name="varname">town</xsl:with-param>
</xsl:call-template>
<xsl:call-template name="formInputGeo">
<xsl:with-param name="geoLocation" select="'1'"/>
</xsl:call-template>
<xsl:call-template name="formInput">
<xsl:with-param name="varname">notes</xsl:with-param>
<xsl:with-param name="type">textarea</xsl:with-param>
</xsl:call-template>
</ul>
</fieldset>
<fieldset>
<legend><xsl:value-of select="key('label','contact_details')/@tr"/></legend>
<ul class="form-inputs">
<xsl:call-template name="formInput">
<xsl:with-param name="varname">phone</xsl:with-param>
</xsl:call-template>
<xsl:call-template name="formInput">
<xsl:with-param name="varname">fax</xsl:with-param>
</xsl:call-template>
<xsl:call-template name="formInput">
<xsl:with-param name="varname">email</xsl:with-param>
<xsl:with-param name="label">email_one</xsl:with-param>
<xsl:with-param name="required" select="true()"/>
</xsl:call-template>
<xsl:call-template name="formInput">
<xsl:with-param name="varname">website</xsl:with-param>
</xsl:call-template>
<xsl:call-template name="formInput">
<xsl:with-param name="varname">contact_name</xsl:with-param>
<xsl:with-param name="label">contact_main</xsl:with-param>
</xsl:call-template>
</ul>
</fieldset>
<xsl:if test="/root/orgs/@upload='1'"><xsl:call-template name="orgInsertImage"/></xsl:if>
<xsl:if test="/root/orgs/keyword/params/param">
<fieldset>
<legend><xsl:value-of select="key('label','additional_fields')/@tr"/></legend>
<ul class="form-inputs">
<xsl:apply-templates select="/root/orgs/keyword/params/param" mode="custom"/>
</ul>
</fieldset>
</xsl:if>
<fieldset>
<legend><xsl:value-of select="key('label','submit_by')/@tr"/></legend>
<ul class="form-inputs">
<xsl:call-template name="formInput">
<xsl:with-param name="label">name</xsl:with-param>
<xsl:with-param name="varname">name_p</xsl:with-param>
<xsl:with-param name="value" select="/root/user/@name"/>
<xsl:with-param name="required" select="true()"/>
<xsl:with-param name="disabled" select="/root/user/@name!='' "/>
</xsl:call-template>
<xsl:call-template name="formInput">
<xsl:with-param name="label">email</xsl:with-param>
<xsl:with-param name="varname">email_p</xsl:with-param>
<xsl:with-param name="value" select="/root/user/@email"/>
<xsl:with-param name="required" select="true()"/>
<xsl:with-param name="disabled" select="/root/user/@email!='' "/>
</xsl:call-template>
<xsl:call-template name="formInput">
<xsl:with-param name="varname">in_charge_of</xsl:with-param>
<xsl:with-param name="type">checkbox</xsl:with-param>
</xsl:call-template>
</ul>
</fieldset>
<ul class="form-inputs">
<xsl:if test="/root/site/@captcha">
<li class="clearfix">
<xsl:call-template name="captchaWrapper"/>
</li>
</xsl:if>
<li class="buttons"><input type="submit" value="{key('label','submit')/@tr}"/></li>
</ul>
</form>
</xsl:template>


<!-- ###############################
     ORG INSERT IMAGE
     ############################### -->
<xsl:template name="orgInsertImage">
<fieldset>
<legend>Immagine associata</legend>
<div id="orgs_upload_warning">Non sono ammessi files di dimensioni superiori a <xsl:value-of select="/root/orgs/@max_file_size_kb"/> Kb. Si accettano immagini solo in formato JPG</div>
<input type="hidden" name="MAX_FILE_SIZE" value="{/root/orgs/@max_file_size}"/>
<ul class="form-inputs">
<li><input type="file" name="img[]" size="50" class="upload"/></li>
</ul>
</fieldset>
</xsl:template>


<!-- ###############################
     ORG INSERT KEYWORDS
     ############################### -->
<xsl:template name="orgInsertKeywords">
<p><xsl:value-of select="key('label','insert_desc_keywords')/@tr"/></p>
<form action="{/root/site/@base}/{/root/orgs/@path}/actions.php" method="post" id="asso-keywords" accept-charset="{/root/site/@encoding}">
<input type="hidden" name="from" value="insert_keywords"/>
<xsl:if test="/root/topic">
<input type="hidden" name="id_topic" value="{/root/topic/@id}"/>
</xsl:if>
<input type="hidden" name="id_asso" value="{/root/orgs/asso/@id}"/>
<fieldset>
<legend><xsl:value-of select="key('label','asso_keywords')/@tr"/></legend>
<ul id="keywords-tree">
<xsl:apply-templates select="/root/orgs/keywords" mode="tree"/>
</ul>
</fieldset>
<ul class="form-inputs">
<li class="buttons"><input type="submit" value="{key('label','submit')/@tr}"/></li>
</ul>
</form>
</xsl:template>


<!-- ###############################
     ORG INSERT KEYWORD PARAMS
     ############################### -->
<xsl:template name="orgInsertKeywordParams">
<p><xsl:value-of select="key('label','additional_fields')/@tr"/></p>
<form action="{/root/site/@base}/{/root/orgs/@path}/actions.php" method="post" id="asso-keyword_params" accept-charset="{/root/site/@encoding}">
<input type="hidden" name="from" value="insert_keyword_params"/>
<xsl:if test="/root/topic">
<input type="hidden" name="id_topic" value="{/root/topic/@id}"/>
</xsl:if>
<input type="hidden" name="id_asso" value="{/root/orgs/asso/@id}"/>
<xsl:for-each select="/root/orgs/keywords/keyword">
<fieldset>
<legend><xsl:value-of select="@name"/></legend>
<ul class="form-inputs">
<xsl:apply-templates select="params/param" mode="custom"/>
</ul>
</fieldset>
</xsl:for-each>
<ul class="form-inputs">
<li class="buttons"><input type="submit" value="{key('label','submit')/@tr}"/></li>
</ul>
</form>
</xsl:template>


<!-- ###############################
     ORG KEYWORD [TREE]
     ############################### -->
<xsl:template match="keyword" mode="tree">
<li>
<input type="checkbox" name="k{@id}"/>
<xsl:value-of select="@name"/>
<xsl:if test="keywords">
<ul><xsl:apply-templates select="keywords" mode="tree"/></ul>
</xsl:if>
</li>
</xsl:template>


<!-- ###############################
     ORGS KEYWORD
     ############################### -->
<xsl:template name="orgsKeyword">
<xsl:if test="/root/orgs/keyword/children">
<div id="subactivities">
<h3><xsl:value-of select="key('label','subactivities')/@tr"/></h3>
<ul>
<xsl:for-each select="/root/orgs/keyword/children/keyword[@orgs_count &gt; 0]">
<li>
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="."/>
</xsl:call-template>
</li>
</xsl:for-each>
</ul>
</div>
</xsl:if>

<xsl:if test="/root/orgs/keyword/items">
<div id="keyword-orgs">
<h3><xsl:value-of select="key('label','orgs')/@tr"/></h3>
<xsl:call-template name="items">
<xsl:with-param name="root" select="/root/orgs/keyword/items"/>
<xsl:with-param name="node" select="/root/orgs/keyword"/>
</xsl:call-template>
</div>
</xsl:if>

</xsl:template>


<!-- ###############################
     ORG KEYWORDS
     ############################### -->
<xsl:template name="orgKeywords">
<div id="org-keywords">
<xsl:if test="/root/orgs/asso/keywords/keyword[@id=0]">
<ul class="kparams0">
<xsl:for-each select="/root/orgs/asso/keywords/keyword[@id=0]/params/param">
<xsl:if test="@value!=''">
<li id="kparam{@id}"><xsl:value-of select="concat(@name,': ',@value)" disable-output-escaping="yes" /></li>
</xsl:if>
</xsl:for-each>
</ul>
</xsl:if>
<xsl:if test="/root/orgs/asso/keywords/keyword[@id &gt; 0]">
<div id="categories">
<h3><xsl:value-of select="key('label','activities')/@tr"/></h3>
<ul class="keywords">
<xsl:for-each select="/root/orgs/asso/keywords/keyword[@id &gt; 0]">
<li>
<xsl:for-each select="path/keyword">
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="."/>
</xsl:call-template>
<xsl:if test="position()!=last()"><xsl:value-of select="$breadcrumb_separator"/></xsl:if>
</xsl:for-each>
<xsl:if test="params">
<ul class="kparams">
<xsl:for-each select="params/param">
<xsl:if test="@value!=''">
<li id="kparam{@id}"><xsl:value-of select="concat(@name,': ',@value)" disable-output-escaping="yes" /></li>
</xsl:if>
</xsl:for-each>
</ul>
</xsl:if>
</li>
</xsl:for-each>
</ul>
</div>
</xsl:if>
</div>
</xsl:template>


<!-- ###############################
     ORG SEARCH
     ############################### -->
<xsl:template name="orgSearch">
<xsl:if test="/root/orgs/search_terms">
<xsl:choose>
<xsl:when test="/root/orgs/items">
<xsl:call-template name="items">
<xsl:with-param name="root" select="/root/orgs/items"/>
<xsl:with-param name="node" select="/root/orgs/search"/>
</xsl:call-template>
</xsl:when>
<xsl:otherwise><xsl:value-of select="key('label','orgs')/@tr"/>: 0</xsl:otherwise>
</xsl:choose>
</xsl:if>
<form method="get" id="org-search" accept-charset="{/root/site/@encoding}">
<xsl:attribute name="action">
<xsl:call-template name="createLinkUrl">
<xsl:with-param name="node" select="/root/orgs/search"/>
</xsl:call-template>
</xsl:attribute>
<input type="hidden" name="from" value="org_search"/>
<xsl:if test="$preview='1'">
<input type="hidden" name="id_type" value="0"/>
<input type="hidden" name="subtype" value="search"/>
<input type="hidden" name="module" value="orgs"/>
<input type="hidden" name="id_module" value="8"/>
</xsl:if>
<input type="hidden" name="id_topic" value="{/root/topic/@id}"/>
<fieldset>
<legend><xsl:value-of select="key('label','asso_data')/@tr"/></legend>
<ul class="form-inputs">
<li><label for="id_assotype"><xsl:value-of select="key('label','type')/@tr"/></label>
<select name="id_assotype">
<option value="0"><xsl:value-of select="key('label','all_option')/@tr"/></option>
<xsl:for-each select="/root/orgs/types/type">
<option value="{@id}">
<xsl:if test="@id=/root/orgs/search_terms/@id_assotype">
<xsl:attribute name="selected">selected</xsl:attribute>
</xsl:if>
<xsl:value-of select="@type"/></option>
</xsl:for-each>
</select>
</li>
<li><label for="id_k"><xsl:value-of select="key('label','asso_keywords')/@tr"/></label>
<select name="id_k">
<option value="0"><xsl:value-of select="key('label','all_option')/@tr"/></option>
<xsl:apply-templates select="/root/orgs/keywords/keyword" mode="combobox"/>
</select>
</li>
<xsl:call-template name="formInput">
<xsl:with-param name="varname">name</xsl:with-param>
<xsl:with-param name="label">name</xsl:with-param>
<xsl:with-param name="value" select="/root/orgs/search_terms/@name"/>
</xsl:call-template>
<xsl:call-template name="formInput">
<xsl:with-param name="varname">address</xsl:with-param>
<xsl:with-param name="label">address</xsl:with-param>
<xsl:with-param name="value" select="/root/orgs/search_terms/@address"/>
</xsl:call-template>
<xsl:call-template name="formInput">
<xsl:with-param name="varname">town</xsl:with-param>
<xsl:with-param name="label">town</xsl:with-param>
<xsl:with-param name="value" select="/root/orgs/search_terms/@town"/>
</xsl:call-template>
<xsl:call-template name="formInputGeo">
<xsl:with-param name="currentGeo" select="/root/orgs/search_terms/@id_geo"/>
<xsl:with-param name="geoLocation" select="'1'"/>
</xsl:call-template>
<xsl:call-template name="formInput">
<xsl:with-param name="varname">text</xsl:with-param>
<xsl:with-param name="label">text</xsl:with-param>
<xsl:with-param name="value" select="/root/orgs/search_terms/@text"/>
</xsl:call-template>
</ul>
</fieldset>
<xsl:if test="$subtype='search_advanced' and /root/orgs/kparams">
<input type="hidden" name="advanced" value="1"/>
<fieldset>
<legend><xsl:value-of select="/root/orgs/search_advanced/@label"/></legend>
<ul class="form-inputs">
<xsl:apply-templates select="/root/orgs/kparams" mode="searchadv"/>
</ul>
</fieldset>
</xsl:if>
<ul class="form-inputs">
<li class="buttons"><input type="submit" value="{key('label','search')/@tr}"/>
<input type="reset" value="{key('label','reset')/@tr}"/>
</li>
</ul>
</form>
<xsl:if test="$subtype='search'">
<h3 id="search-adv">
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="/root/orgs/search_advanced"/>
<xsl:with-param name="name" select="/root/orgs/search_advanced/@label"/>
</xsl:call-template>
</h3>
</xsl:if>
</xsl:template>


<!-- ###############################
     KPARAM [SEARCH ADVANCED]
     ############################### -->
<xsl:template match="kparam" mode="searchadv">
<xsl:variable name="kparam_id" select="concat('kp_',@id)"/>
<xsl:choose>
<xsl:when test="@type='text' or @type='textarea' ">
<xsl:call-template name="formInput">
<xsl:with-param name="varname" select="$kparam_id"/>
<xsl:with-param name="tr_label" select="@label"/>
<xsl:with-param name="value" select="/root/orgs/search_terms/kparams/kparam[@key=$kparam_id]/@value"/>
</xsl:call-template>
</xsl:when>
<xsl:when test="@type='dropdown' ">
<li>
<label for="{$kparam_id}"><xsl:value-of select="@label"/></label>
<select name="{$kparam_id}">
<option value=""></option>
<xsl:for-each select="subparams/subparam">
<option value="{@value}">
<xsl:if test="@value=/root/orgs/search_terms/kparams/kparam[@key=$kparam_id]/@value">
<xsl:attribute name="selected">selected</xsl:attribute>
</xsl:if><xsl:value-of select="@value"/>
</option>
</xsl:for-each>
</select>
</li>
</xsl:when>
</xsl:choose>
</xsl:template>


<!-- ###############################
     KEYWORD [COMBOBOX]
     ############################### -->
<xsl:template match="keyword" mode="combobox">
<xsl:param name="parent"/>
<option value="{@id}">
<xsl:if test="@id=/root/orgs/search_terms/@id_k">
<xsl:attribute name="selected">selected</xsl:attribute>
</xsl:if>
<xsl:if test="$parent!=''"><xsl:value-of select="concat($parent,' &gt; ')"/></xsl:if>
<xsl:value-of select="@name"/></option>
<xsl:apply-templates select="keywords/keyword" mode="combobox">
<xsl:with-param name="parent"><xsl:if test="$parent!=''"><xsl:value-of select="concat($parent,' &gt; ')"/></xsl:if><xsl:value-of select="@name"/></xsl:with-param>
</xsl:apply-templates>

</xsl:template>


<!-- ###############################
     ORGS TYPE
     ############################### -->
<xsl:template name="orgsType">
<div id="orgs-type">
<h3><xsl:value-of select="key('label','type')/@tr"/></h3>
<ul>
<xsl:for-each select="/root/orgs/types/type">
<li>
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="."/>
</xsl:call-template>
</li>
</xsl:for-each>
</ul>
</div>
</xsl:template>


</xsl:stylesheet>
