<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="common.xsl" />

<xsl:output method="html" encoding="UTF-8" indent="no" doctype-system="http://www.w3.org/TR/html4/strict.dtd"  doctype-public="-//W3C//DTD HTML 4.01//EN" />

<xsl:include href="common_global.xsl" />

<xsl:variable name="current_page_title" select="/root/admin_user/@name"/>


<!-- ###############################
     LEFT BAR
     ############################### -->
<xsl:template name="leftBar">
<h2><xsl:value-of select="/root/admin_user/@name"/></h2>
<ul class="menu">
<xsl:if test="/root/admin_user/image">
<li>
<img class="user-image" width="{/root/admin_user/image/@width}" alt="{/root/admin_user/@name}">
<xsl:attribute name="src">
<xsl:call-template name="createLinkUrl">
<xsl:with-param name="node" select="/root/admin_user/image"/>
</xsl:call-template>
</xsl:attribute>
</img>
</li>
</xsl:if>
<li>
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="/root/admin_user"/>
<xsl:with-param name="name" select="/root/labels/label[@word='articles']/@tr"/>
</xsl:call-template>
</li>
<xsl:if test="/root/admin_user/translations">
<li>
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="/root/admin_user/translations"/>
<xsl:with-param name="name" select="/root/labels/label[@word='translations']/@tr"/>
</xsl:call-template>
</li>
</xsl:if>
<xsl:if test="/root/admin_user/bio">
<li>
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="/root/admin_user/bio"/>
<xsl:with-param name="name" select="/root/admin_user/bio/@label"/>
</xsl:call-template>
</li>
</xsl:if>
<li>
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="/root/admin_user/contact"/>
<xsl:with-param name="name" select="/root/admin_user/contact/@label"/>
</xsl:call-template>
</li>
</ul>
<xsl:call-template name="leftBottom"/>
</xsl:template>


<!-- ###############################
     CONTENT
     ############################### -->
<xsl:template name="content">
<xsl:variable name="u" select="/root/admin_user"/>
<div class="breadcrumb">
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="$u"/>
<xsl:with-param name="condition" select="$subtype!='user'"/>
</xsl:call-template>
</div>
<xsl:call-template name="feedback"/>
<xsl:choose>
<xsl:when test="$subtype='user'">
<xsl:if test="$u/@email_visible='1'">
<p id="user-email">email: <a href="mailto:{$u/@email}"><xsl:value-of select="$u/@email"/></a></p>
</xsl:if>
<div id="articles-{$subtype}">
<xsl:call-template name="items">
<xsl:with-param name="root" select="/root/admin_user/articles/items"/>
<xsl:with-param name="node" select="/root/admin_user"/>
</xsl:call-template>
</div>
</xsl:when>
<xsl:when test="$subtype='translator'">
<h2><xsl:value-of select="/root/labels/label[@word='translations']/@tr"/></h2>
<div id="articles-{$subtype}">
<xsl:call-template name="items">
<xsl:with-param name="root" select="/root/admin_user/articles/items"/>
<xsl:with-param name="node" select="/root/admin_user"/>
</xsl:call-template>
</div>
</xsl:when>
<xsl:when test="$subtype='bio'">
<p id="user-bio"><xsl:value-of select="$u/bio" disable-output-escaping="yes"/></p>
</xsl:when>
<xsl:when test="$subtype='contact'">
<xsl:if test="$u/@email">
<p id="user-email">email: <a href="mailto:{$u/@email}"><xsl:value-of select="$u/@email"/></a></p>
</xsl:if>
<xsl:call-template name="userContact"/>
</xsl:when>
</xsl:choose>

</xsl:template>


<!-- ###############################
     PAGE TITLE
     ############################### -->
<xsl:template name="pageTitle">
<xsl:if test="$preview=true()">[<xsl:value-of select="/root/labels/label[@word='preview']/@tr"/>] - </xsl:if> <xsl:value-of select="/root/admin_user/@name"/>
</xsl:template>


<!-- ###############################
     CONTACT
     ############################### -->
<xsl:template name="userContact">
<p>Puoi usare il seguente form per inviare un messaggio a <xsl:value-of select="/root/admin_user/@name"/></p>
<xsl:call-template name="javascriptForms"/>
<script type="text/javascript">
$().ready(function() {
	$("#ucontact").validate({
		rules: {
			name: "required",
			email: { required: true, email:	true }
		}
	});
});
</script>
<form action="{/root/site/@base}/tools/actions.php" method="post" name="ucontact" id="ucontact" accept-charset="{/root/site/@encoding}">
<input type="hidden" name="from" value="user_contact"/>
<input type="hidden" name="id_user" value="{/root/admin_user/@id}"/>
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
<xsl:call-template name="formInput">
<xsl:with-param name="varname">comments</xsl:with-param>
<xsl:with-param name="type">textarea</xsl:with-param>
</xsl:call-template>
<xsl:if test="/root/site/@captcha">
<li class="clearfix">
<xsl:call-template name="captchaWrapper"/>
</li>
</xsl:if>
<li class="buttons"><input type="submit" value="Invia"/></li>
</ul>
</form>
</xsl:template>


</xsl:stylesheet>

