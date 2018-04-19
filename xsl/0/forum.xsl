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

<xsl:variable name="fo" select="/root/forum"/>

<xsl:variable name="current_page_title" select="concat(/root/topic/@name,' - Forum')"/>


<!-- ###############################
     CONTENT
     ############################### -->
<xsl:template name="content">
<xsl:call-template name="forumBreadcrumb"/>
<xsl:call-template name="feedback"/>
<xsl:choose>
<xsl:when test="$subtype='list'">
<xsl:call-template name="items">
<xsl:with-param name="root" select="/root/forums/items"/>
<xsl:with-param name="node" select="/root/forums"/>
</xsl:call-template>
</xsl:when>
<xsl:otherwise>
<div id="forum-content">
<h1><xsl:value-of select="key('label','forum')/@tr"/>: 
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="$fo"/>
<xsl:with-param name="name" select="$fo/@title"/>
</xsl:call-template>
</h1>
<xsl:choose>
<xsl:when test="$fo/@active &gt; 0">
<xsl:choose>
<xsl:when test="$subtype='info' and $fo/thanks">
<xsl:call-template name="forumThanks"/>
</xsl:when>
<xsl:when test="$subtype='info' and not($fo/thanks)">
<xsl:call-template name="forumInfo"/>
</xsl:when>
<xsl:when test="$subtype='thread_insert' and $fo/@active='1' ">
<xsl:call-template name="forumThreadInsert"/>
</xsl:when>
<xsl:when test="$subtype='thread'">
<xsl:call-template name="forumThread"/>
</xsl:when>
</xsl:choose>
</xsl:when>
<xsl:otherwise>
<p class="over"><xsl:value-of select="key('label','forum_over')/@tr"/></p>
</xsl:otherwise>
</xsl:choose>
</div>
</xsl:otherwise>
</xsl:choose>
</xsl:template>


<!-- ###############################
     FORUM BREADCRUMB
     ############################### -->
<xsl:template name="forumBreadcrumb">
<div class="breadcrumb">
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="/root/forums"/>
<xsl:with-param name="name" select="/root/forums/@label"/>
</xsl:call-template>
<xsl:if test="/root/forum">
<xsl:value-of select="$breadcrumb_separator"/>
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="$fo"/>
<xsl:with-param name="name" select="$fo/@title"/>
</xsl:call-template>
</xsl:if>
<xsl:if test="$subtype='thread_insert'">
<xsl:value-of select="$breadcrumb_separator"/>
<xsl:value-of select="key('label','thread_insert')/@tr"/>
</xsl:if>
<xsl:if test="$subtype='thread'">
<xsl:value-of select="$breadcrumb_separator"/>
<xsl:value-of select="/root/forum/thread/@title"/>
</xsl:if>
</div>
</xsl:template>


<!-- ###############################
     FORUM INFO
     ############################### -->
<xsl:template name="forumInfo">
<xsl:if test="$fo/@active='2'">
<p class="over"><xsl:value-of select="key('label','forum_over')/@tr"/></p>
</xsl:if>

<div class="forum-description"><xsl:value-of select="$fo/description" disable-output-escaping="yes"/></div>
<xsl:if test="$fo/@active &gt; 0">
<xsl:if test="$fo/insert and $fo/@active='1'">
<div class="forum-insert">
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="$fo/insert"/>
<xsl:with-param name="name" select="$fo/insert/@label"/>
</xsl:call-template>
</div>
</xsl:if>
<xsl:call-template name="items">
<xsl:with-param name="root" select="$fo/items"/>
<xsl:with-param name="node" select="$fo"/>
</xsl:call-template>
</xsl:if>
</xsl:template>


<!-- ###############################
     FORUM THREAD INSERT
     ############################### -->
<xsl:template name="forumThreadInsert">
<xsl:choose>
<xsl:when test="$fo/login">
<xsl:call-template name="loginFirst">
<xsl:with-param name="node" select="$fo/login"/>
</xsl:call-template>
</xsl:when>
<xsl:otherwise>
<xsl:call-template name="javascriptForms"/>
<script type="text/javascript">
$().ready(function() {
	$("#thread-form-<xsl:value-of select="$fo/@id"/>").validate({
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
<form action="{$fo/@submit}" method="post" id="thread-form-{$fo/@id}" class="thread-form" accept-charset="{/root/site/@encoding}">
<input type="hidden" name="from" value="thread_insert"/>
<input type="hidden" name="id_forum" value="{$fo/@id}"/>
<input type="hidden" name="id_topic" value="{/root/topic/@id}"/>

<xsl:if test="$fo/@approve_threads='1'">
<p class="form-notes"><xsl:value-of select="key('label','thread_approve')/@tr"/></p>
</xsl:if>

<xsl:if test="$fo/@ask_source='1'">
<fieldset>
<legend><xsl:value-of select="key('label','source')/@tr"/></legend>
<ul class="form-inputs">
<xsl:call-template name="formInput">
<xsl:with-param name="varname">source</xsl:with-param>
<xsl:with-param name="type">textarea</xsl:with-param>
<xsl:with-param name="size">small</xsl:with-param>
</xsl:call-template>
</ul>
</fieldset>
</xsl:if>

<fieldset>
<legend><xsl:value-of select="key('label','text')/@tr"/></legend>
<ul class="form-inputs">
<xsl:call-template name="formInput">
<xsl:with-param name="varname">title</xsl:with-param>
<xsl:with-param name="required" select="true()"/>
</xsl:call-template>
<xsl:call-template name="formInput">
<xsl:with-param name="varname">description</xsl:with-param>
<xsl:with-param name="type">textarea</xsl:with-param>
</xsl:call-template>
<xsl:call-template name="formInput">
<xsl:with-param name="varname">description_long</xsl:with-param>
<xsl:with-param name="type">textarea</xsl:with-param>
<xsl:with-param name="size">extralarge</xsl:with-param>
<xsl:with-param name="label">text</xsl:with-param>
</xsl:call-template>
</ul>
</fieldset>

<xsl:if test="$fo/@users_type='3'">
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
<xsl:call-template name="privacyWarning">
<xsl:with-param name="node" select="$fo/privacy_warning"/>
</xsl:call-template>
</ul>
</fieldset>
</xsl:if>

<ul class="form-inputs">
<xsl:if test="/root/site/@captcha">
<li class="clearfix">
<xsl:call-template name="captchaWrapper"/>
</li>
</xsl:if>
<li class="buttons"><input type="submit" value="{key('label','submit')/@tr}" name="action_sign"/></li>
</ul>

</form>
</xsl:otherwise>
</xsl:choose>
</xsl:template>


<!-- ###############################
     FORUM THREAD
     ############################### -->
<xsl:template name="forumThread">
<xsl:variable name="th" select="/root/forum/thread"/>
<xsl:if test="$fo/@active='2'">
<p class="over"><xsl:value-of select="key('label','forum_over')/@tr"/></p>
</xsl:if>

<div class="thread" id="thread-{$th/@id}">
<div class="author"><xsl:value-of select="$th/@insert_date"/>

</div>
<h1><xsl:value-of select="$th/@title"/></h1>
<div class="description"><xsl:value-of select="$th/description" disable-output-escaping="yes"/></div>
<xsl:if test="$th/author"><div class="author"><xsl:value-of select="concat($th/author/@label,': ',$th/author/@name)"/></div></xsl:if>
<xsl:if test="$th/source"><div class="source"><xsl:value-of select="concat($th/source/@label,': ',$th/source)" disable-output-escaping="yes"/></div></xsl:if>
<xsl:call-template name="articleContentComments">
<xsl:with-param name="a" select="$th"/>
</xsl:call-template>
<div class="description-long"><xsl:value-of select="$th/description_long" disable-output-escaping="yes"/></div>
</div>
</xsl:template>


</xsl:stylesheet>
