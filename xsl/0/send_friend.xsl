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

<xsl:variable name="current_page_title" select="/root/article/headline"/>


<!-- ###############################
     CONTENT
     ############################### -->
<xsl:template name="content">
<xsl:call-template name="breadcrumb" />
<xsl:call-template name="feedback" />
<xsl:call-template name="articleContent"/>
<xsl:call-template name="sendFriendForm"/>
</xsl:template>


<!-- ###############################
     SEND FRIEND FORM
     ############################### -->
<xsl:template name="sendFriendForm">
<xsl:call-template name="javascriptForms"/>
<script type="text/javascript">
$().ready(function() {
	$("#form-friend").validate({
		rules: {
			sender_email: { required: true, email:	true },
			email: { required: true, email:	true }
		}
	});
});
</script>
<div id="sendfriend">
<form action="{/root/site/@base}/tools/actions.php" method="post" id="form-friend" accept-charset="{/root/site/@encoding}">
<input type="hidden" name="id_article" value="{/root/article/@id}"/>
<input type="hidden" name="id_topic" value="{/root/topic/@id}"/>
<input type="hidden" name="id_subtopic" value="{/root/article/@id_subtopic}"/>
<input type="hidden" name="from" value="friend"/>
<fieldset>
<legend><xsl:value-of select="key('label','friend_sender')/@tr"/></legend>
<ul class="form-inputs">
<xsl:call-template name="formInput">
<xsl:with-param name="varname">sender</xsl:with-param>
</xsl:call-template>
<xsl:call-template name="formInput">
<xsl:with-param name="varname">sender_email</xsl:with-param>
<xsl:with-param name="label">email</xsl:with-param>
<xsl:with-param name="required" select="true()"/>
</xsl:call-template>
</ul>
</fieldset>
<fieldset>
<legend><xsl:value-of select="key('label','to_email')/@tr"/></legend>
<ul class="form-inputs">
<xsl:call-template name="formInput">
<xsl:with-param name="varname">email</xsl:with-param>
<xsl:with-param name="required" select="true()"/>
</xsl:call-template>
<xsl:call-template name="formInput">
<xsl:with-param name="varname">message</xsl:with-param>
<xsl:with-param name="type">textarea</xsl:with-param>
</xsl:call-template>
<xsl:if test="/root/site/@captcha">
    <li class="clearfix">
        <xsl:call-template name="captchaWrapper"/>
    </li>
</xsl:if>

<li class="buttons"><input type="submit" value="{key('label','send_to_friend')/@tr}" /></li>
</ul>
</fieldset>
</form>
</div>
</xsl:template>


</xsl:stylesheet>

