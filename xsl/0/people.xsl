<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html" encoding="UTF-8" indent="no" />

<xsl:include href="common.xsl" />

<xsl:variable name="u" select="/root/user"/>

<xsl:variable name="title1">
<xsl:choose>
<xsl:when test="$u/@id &gt; 0"><xsl:value-of select="$u/@name"/></xsl:when>
<xsl:otherwise><xsl:value-of select="key('label','user')/@tr"/></xsl:otherwise>
</xsl:choose>
</xsl:variable>

<xsl:variable name="title2">
<xsl:choose>
<xsl:when test="$subtype='login'"><xsl:value-of select="/root/site/people/login/@label"/></xsl:when>
<xsl:when test="$subtype='register'"><xsl:value-of select="/root/site/people/register/@label"/></xsl:when>
<xsl:when test="$subtype='reminder'"><xsl:value-of select="key('label','reminder')/@tr"/></xsl:when>
<xsl:when test="$subtype='password'"><xsl:value-of select="/root/site/people/password/@label"/></xsl:when>
<xsl:when test="$subtype='cancel'"><xsl:value-of select="/root/site/people/cancel/@label"/></xsl:when>
<xsl:when test="$subtype='history'"><xsl:value-of select="key('label','person_history')/@tr"/></xsl:when>
<xsl:when test="$subtype='contact'"><xsl:value-of select="/root/user/contact/@label"/></xsl:when>
<xsl:when test="$subtype='data'"><xsl:value-of select="key('label','person_data')/@tr"/></xsl:when>
<xsl:otherwise>Account</xsl:otherwise>
</xsl:choose>
</xsl:variable>

<xsl:variable name="current_page_title" select="concat($title1,' - ',$title2)"/>


<!-- ###############################
     CONTENT
     ############################### -->
<xsl:template name="content">
<xsl:call-template name="peopleBreadcrumb"/>
<div id="user-content">
<xsl:call-template name="feedback"/>
<xsl:choose>
<xsl:when test="$subtype='password' and $u/@auth='1' ">
<xsl:call-template name="peoplePassword"/>
</xsl:when>
<xsl:when test="$subtype='register'">
<xsl:call-template name="peopleRegister"/>
</xsl:when>
<xsl:when test="$subtype='cancel' and $u/@auth='1'">
<xsl:call-template name="peopleCancel"/>
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

<xsl:if test="$u/@name!='' and $subtype!='register' and $subtype!='login' and $subtype!='cancel' ">
<xsl:choose>
<xsl:when test="not($u/@verified='1') ">
<xsl:call-template name="peopleEmailVerificationButton"/>
</xsl:when>
</xsl:choose>
</xsl:if>

</div>
</xsl:template>


<!-- ###############################
     PEOPLE BREADCRUMB
     ############################### -->
<xsl:template name="peopleBreadcrumb">
<div class="breadcrumb">
<xsl:call-template name="createLink">
<xsl:with-param name="name" select="$title1"/>
<xsl:with-param name="node" select="/root/site/people"/>
</xsl:call-template>
<xsl:if test="$title2!=''"><xsl:value-of select="concat(' - ',$title2)"/></xsl:if>
</div>
</xsl:template>


<!-- ###############################
     PEOPLE EMAIL VERIFICATION BUTTON
     ############################### -->
<xsl:template name="peopleEmailVerificationButton">
<div id="verification-info">
<p><strong><xsl:value-of select="key('label','verify_missing')/@tr"/></strong></p>
<xsl:if test="$u/@verified='-1'">
<p><xsl:value-of select="key('label','verify_pending')/@tr"/></p>
</xsl:if>
<p><xsl:value-of select="key('label','verify_submit')/@tr"/></p>
<form action="{/root/site/people/@submit}" method="post" id="people-verify" accept-charset="{/root/site/@encoding}">
<input type="hidden" name="from" value="verify"/>
<xsl:if test="/root/topic">
<input type="hidden" name="id_topic" value="{/root/topic/@id}"/>
</xsl:if>
<ul class="form-inputs">
<li class="buttons"><input type="submit" value="{concat(key('label','verify')/@tr,' ',$u/@email)}" /></li>
</ul>
</form>
</div>
</xsl:template>




<!-- ###############################
     LOGIN LOGOUT
     ############################### -->
<xsl:template name="loginLogout">
<ul id="login-links">
<xsl:choose>
<xsl:when test="$u/@auth='1' ">
<xsl:if test="$u/@auth='1' and $subtype!='password' ">
<li>
<xsl:call-template name="createLink">
<xsl:with-param name="name" select="/root/site/people/password/@label"/>
<xsl:with-param name="node" select="/root/site/people/password"/>
</xsl:call-template>
</li>
</xsl:if>
<xsl:if test="$u/@auth='1' and /root/site/people/cancel and $subtype='data'">
<li>
<xsl:call-template name="createLink">
<xsl:with-param name="name" select="/root/site/people/cancel/@label"/>
<xsl:with-param name="node" select="/root/site/people/cancel"/>
</xsl:call-template>
</li>
</xsl:if>
<li>
<xsl:call-template name="createLink">
<xsl:with-param name="name" select="/root/site/people/logout/@label"/>
<xsl:with-param name="node" select="/root/site/people/logout"/>
</xsl:call-template>
</li>    
</xsl:when>
<xsl:otherwise>
<xsl:choose>
<xsl:when test="$subtype!='login'">
<li>
<xsl:call-template name="createLink">
<xsl:with-param name="name" select="/root/site/people/login/@label"/>
<xsl:with-param name="node" select="/root/site/people/login"/>
</xsl:call-template>
</li>
<xsl:if test="$u/@id &gt; 0">
<li>
<xsl:call-template name="createLink">
<xsl:with-param name="name" select="/root/site/people/logout/@label"/>
<xsl:with-param name="node" select="/root/site/people/logout"/>
</xsl:call-template>
</li>
</xsl:if>
</xsl:when>
<xsl:otherwise>
<li>
<xsl:call-template name="createLink">
<xsl:with-param name="name" select="/root/site/people/register/@label"/>
<xsl:with-param name="node" select="/root/site/people/register"/>
</xsl:call-template>
</li>
<li>
<xsl:call-template name="createLink">
<xsl:with-param name="name" select="key('label','password_remind')/@tr"/>
<xsl:with-param name="node" select="/root/site/people/reminder"/>
</xsl:call-template>
</li>
</xsl:otherwise>
</xsl:choose>
</xsl:otherwise>
</xsl:choose>
</ul>
</xsl:template>


<!-- ###############################
     PEOPLE CONTACT
     ############################### -->
<xsl:template name="peopleContact">
<h2><xsl:value-of select="/root/user/contact/@label"/></h2>
<p><xsl:value-of select="/root/user/contact/@description"/></p>

<form action="{/root/site/people/@submit}" method="post" id="people-contact" accept-charset="{/root/site/@encoding}">
<input type="hidden" name="from" value="contact"/>
<xsl:if test="/root/topic">
<input type="hidden" name="id_topic" value="{/root/topic/@id}"/>
</xsl:if>

<xsl:if test="/root/user/contact/topics">
<fieldset>
<legend>Newsletters</legend>
<ul class="form-inputs">
<xsl:call-template name="contactCheckbox">
<xsl:with-param name="varname" select="'portal'"/>
<xsl:with-param name="tr_label" select="/root/user/contact/portal/@name"/>
<xsl:with-param name="value" select="1"/>
<xsl:with-param name="checked" select="/root/user/contact/portal/@contact='1'"/>
<xsl:with-param name="node" select="/root/user/contact/portal"/>
<xsl:with-param name="description" select="/root/user/contact/portal/@description"/>
</xsl:call-template>
<xsl:for-each select="/root/user/contact/topics/item">
<xsl:call-template name="contactCheckbox">
<xsl:with-param name="varname" select="'topics[]'"/>
<xsl:with-param name="tr_label" select="@name"/>
<xsl:with-param name="value" select="@id"/>
<xsl:with-param name="checked" select="@contact='1'"/>
<xsl:with-param name="node" select="."/>
</xsl:call-template>
</xsl:for-each>
</ul>
</fieldset>
</xsl:if>

<xsl:if test="/root/user/contact/campaigns">
<fieldset>
<legend><xsl:value-of select="/root/user/contact/campaigns/@label"/></legend>
<ul class="form-inputs">
<xsl:for-each select="/root/user/contact/campaigns/item">
<xsl:call-template name="contactCheckbox">
<xsl:with-param name="varname" select="'campaigns[]'"/>
<xsl:with-param name="tr_label" select="@title"/>
<xsl:with-param name="value" select="@id"/>
<xsl:with-param name="checked" select="@contact='1'"/>
<xsl:with-param name="node" select="."/>
</xsl:call-template>
</xsl:for-each>
</ul>
</fieldset>
</xsl:if>

<ul class="form-inputs">
<li class="buttons"><input type="submit" value="{key('label','submit')/@tr}" /></li>
</ul>

</form>
</xsl:template>


<!-- ###############################
     PEOPLE DATA
     ############################### -->
<xsl:template name="peopleData">
<xsl:call-template name="javascriptForms"/>
<script type="text/javascript">
$().ready(function() {
	$("#people-data").validate({
		rules: {
			name: "required",
			email: { required: true, email:	true }
		}
	});
});
</script>
<form action="{/root/site/people/@submit}" method="post" id="people-data" accept-charset="{/root/site/@encoding}">
<input type="hidden" name="from" value="data"/>
<xsl:if test="/root/topic">
<input type="hidden" name="id_topic" value="{/root/topic/@id}"/>
</xsl:if>
<fieldset>
<legend><xsl:value-of select="key('label','person_data')/@tr"/></legend>
<ul class="form-inputs">
<xsl:call-template name="formInput">
<xsl:with-param name="varname">name</xsl:with-param>
<xsl:with-param name="required" select="true()"/>
<xsl:with-param name="value" select="/root/user/@name1"/>
</xsl:call-template>
<xsl:call-template name="formInput">
<xsl:with-param name="varname">surname</xsl:with-param>
<xsl:with-param name="value" select="/root/user/@name2"/>
</xsl:call-template>
<xsl:call-template name="formInput">
<xsl:with-param name="varname">email</xsl:with-param>
<xsl:with-param name="required" select="true()"/>
<xsl:with-param name="value" select="/root/user/@email"/>
</xsl:call-template>
<xsl:call-template name="formInput">
<xsl:with-param name="varname">phone</xsl:with-param>
<xsl:with-param name="value" select="/root/user/@phone"/>
</xsl:call-template>
<xsl:call-template name="formInput">
<xsl:with-param name="varname">address</xsl:with-param>
<xsl:with-param name="value" select="/root/user/@address"/>
<xsl:with-param name="type">textarea</xsl:with-param>
</xsl:call-template>
<xsl:call-template name="formInput">
<xsl:with-param name="varname">address_notes</xsl:with-param>
<xsl:with-param name="value" select="/root/user/@address_notes"/>
<xsl:with-param name="type">textarea</xsl:with-param>
</xsl:call-template>
<xsl:call-template name="formInput">
<xsl:with-param name="varname">postcode</xsl:with-param>
<xsl:with-param name="value" select="/root/user/@postcode"/>
</xsl:call-template>
<xsl:call-template name="formInput">
<xsl:with-param name="varname">town</xsl:with-param>
<xsl:with-param name="value" select="/root/user/@town"/>
</xsl:call-template>
<xsl:call-template name="formInputGeo">
<xsl:with-param name="currentGeo" select="/root/user/@id_geo"/>
</xsl:call-template>
<xsl:if test="/root/user/params">
<xsl:call-template name="peopleDataParams"/>
</xsl:if>
<li class="buttons"><input type="submit" value="{key('label','submit')/@tr}" /></li>
</ul>
</fieldset>
</form>
</xsl:template>


<!-- ###############################
     PEOPLE DATA PARAMS
     ############################### -->
<xsl:template name="peopleDataParams">
<div id="user-params">
<xsl:for-each select="/root/user/params/param">
<xsl:call-template name="formInput">
<xsl:with-param name="tr_label" select="@name"/>
<xsl:with-param name="varname">param_<xsl:value-of select="@name"/></xsl:with-param>
<xsl:with-param name="value" select="@value"/>
</xsl:call-template>
</xsl:for-each>
</div>
</xsl:template>


<!-- ###############################
     PEOPLE CANCEL
     ############################### -->
<xsl:template name="peopleCancel">
<form action="{/root/site/people/@submit}" method="post" id="people-cancel" accept-charset="{/root/site/@encoding}">
<input type="hidden" name="from" value="cancel"/>
<xsl:if test="/root/topic">
<input type="hidden" name="id_topic" value="{/root/topic/@id}"/>
</xsl:if>
<p><xsl:value-of select="/root/site/people/cancel/@confirm"/></p>
<ul class="form-inputs">
<li class="buttons"><input type="submit" name="action_cancel_yes" value="{key('label','yes')/@tr}" />
<input type="submit" name="action_deactivate_no" value="{key('label','no')/@tr}" /></li>
</ul>
</form>
</xsl:template>


<!-- ###############################
     PEOPLE HISTORY
     ############################### -->
<xsl:template name="peopleHistory">
<ul id="user-history">
<xsl:if test="/root/user/history/campaigns">
<li><h2><xsl:value-of select="key('label','campaigns')/@tr"/></h2>
<ul class="hitems">
<xsl:apply-templates mode="mainlist" select="/root/user/history/campaigns"/>
</ul>
</li>
</xsl:if>
<xsl:if test="/root/user/history/signatures">
<li><h2><xsl:value-of select="/root/user/history/signatures/@label"/></h2>
<ul class="hitems">
<xsl:apply-templates mode="mainlist" select="/root/user/history/signatures"/>
</ul>
</li>
</xsl:if>
<xsl:if test="/root/user/history/polls">
<li><h2><xsl:value-of select="/root/user/history/polls/@label"/></h2>
<ul class="hitems">
<xsl:apply-templates mode="mainlist" select="/root/user/history/polls"/>
</ul>
</li>
</xsl:if>
<xsl:if test="/root/user/history/comments">
<li><h2><xsl:value-of select="/root/user/history/comments/@label"/></h2>
<ul class="hitems">
<xsl:apply-templates mode="mainlist" select="/root/user/history/comments"/>
</ul>
</li>
</xsl:if>
<xsl:if test="/root/user/history/events">
<li><h2><xsl:value-of select="key('label','events')/@tr"/></h2>
<ul class="hitems">
<xsl:apply-templates mode="mainlist" select="/root/user/history/events"/>
</ul>
</li>
</xsl:if>
<xsl:if test="/root/user/history/reviews">
<li><h2><xsl:value-of select="/root/user/history/reviews/@label"/></h2>
<ul class="hitems">
<xsl:apply-templates mode="mainlist" select="/root/user/history/reviews"/>
</ul>
</li>
</xsl:if>
<xsl:if test="/root/user/history/assos">
<li><h2><xsl:value-of select="key('label','associations')/@tr"/></h2>
<ul class="hitems">
<xsl:apply-templates mode="mainlist" select="/root/user/history/assos"/>
</ul>
</li>
</xsl:if>
<xsl:if test="/root/user/history/payments">
<li><h2><xsl:value-of select="/root/user/history/payments/@label"/></h2>
<ul class="hitems">
<xsl:apply-templates mode="mainlist" select="/root/user/history/payments"/>
</ul>
</li>
</xsl:if>
</ul>
</xsl:template>


<!-- ###############################
     PEOPLE INFO
     ############################### -->
<xsl:template name="peopleInfo">
<ul id="user-details">
<xsl:comment>id: <xsl:value-of select="$u/@id"/></xsl:comment>
<li><xsl:value-of select="key('label','email')/@tr"/>: <xsl:value-of select="$u/@email"/></li>
<xsl:if test="$u/@name!=''">
<li>Status: <xsl:if test="$u/@auth='1'"><xsl:value-of select="key('label','authenticated')/@tr"/> - </xsl:if>
<xsl:choose>
<xsl:when test="$u/@verified='1'"><xsl:value-of select="key('label','verified')/@tr"/></xsl:when>
<xsl:when test="$u/@verified='-1'"><xsl:value-of select="key('label','verified_pending')/@tr"/></xsl:when>
<xsl:otherwise>
<xsl:value-of select="key('label','verified_no')/@tr"/>
</xsl:otherwise>
</xsl:choose>
</li>
</xsl:if>

<xsl:if test="$u/@auth='1'">

<li id="contact-options">
<h3>
<xsl:call-template name="createLink">
<xsl:with-param name="name" select="/root/site/people/contact/@label"/>
<xsl:with-param name="node" select="/root/site/people/contact"/>
</xsl:call-template>
</h3>
<div><xsl:value-of select="/root/site/people/contact/@description"/></div>
</li>
<xsl:if test="$u/@history &gt; 0">
<li id="history">
<h3>
<xsl:call-template name="createLink">
<xsl:with-param name="name" select="key('label','person_history')/@tr"/>
<xsl:with-param name="node" select="/root/site/people/history"/>
</xsl:call-template>
</h3>
<div><xsl:value-of select="key('label','person_history_desc')/@tr"/></div>
</li>
</xsl:if>
<li id="data">
<h3>
<xsl:call-template name="createLink">
<xsl:with-param name="name" select="/root/site/people/data/@label"/>
<xsl:with-param name="node" select="/root/site/people/data"/>
</xsl:call-template>
</h3>
</li>

</xsl:if>
</ul>
</xsl:template>


<!-- ###############################
     PEOPLE LOGIN
     ############################### -->
<xsl:template name="peopleLogin">
<xsl:choose>
<xsl:when test="$u/@auth='1'">
<p><xsl:value-of select="concat(key('label','already_auth')/@tr,' ',$u/@name)"/></p>
<p>
<xsl:call-template name="createLink">
<xsl:with-param name="name" select="/root/site/people/logout/@label"/>
<xsl:with-param name="node" select="/root/site/people/logout"/>
</xsl:call-template>
</p>
</xsl:when>
<xsl:otherwise>
<xsl:choose>
<xsl:when test="$u/@verification_required='1' and $u/@id_p &gt; 0 and $u/@verified!='1'">
<xsl:call-template name="peopleEmailVerificationButton"/>
</xsl:when>
<xsl:otherwise>
<xsl:call-template name="javascriptForms"/>
<script type="text/javascript">
$().ready(function() {
	$("#people-login").validate({
		rules: {
			password: "required",
			email: { required: true, email:	true }
		}
	});
});
</script>
<form action="{/root/site/people/@submit}" method="post" id="people-login" accept-charset="{/root/site/@encoding}">
<input type="hidden" name="from" value="login"/>
<xsl:if test="/root/topic">
<input type="hidden" name="id_topic" value="{/root/topic/@id}"/>
</xsl:if>
<ul class="form-inputs">
<xsl:call-template name="formInput">
<xsl:with-param name="varname">email</xsl:with-param>
<xsl:with-param name="required" select="true()"/>
<xsl:with-param name="value" select="$u/@email"/>
</xsl:call-template>
<xsl:call-template name="formInput">
<xsl:with-param name="varname">password</xsl:with-param>
<xsl:with-param name="type">password</xsl:with-param>
<xsl:with-param name="required" select="true()"/>
<xsl:with-param name="autocomplete" select="false()"/>
</xsl:call-template>
</ul>
<xsl:if test="/root/site/@captcha and /root/user/@login_counter &gt; 3">
    <li class="clearfix">
        <xsl:call-template name="peopleCaptcha"/>
    </li>
</xsl:if>
<xsl:call-template name="peopleSecurity"/>
<ul class="form-inputs">
<li class="buttons"><input type="submit" value="{key('label','submit')/@tr}" /></li>
</ul>
</form>
<xsl:if test="/root/user/@email!='' ">
<script type="text/javascript">
$(document).ready(function(){
  $("#password").focus();
});
</script>
</xsl:if>
</xsl:otherwise>
</xsl:choose>

</xsl:otherwise>
</xsl:choose>
</xsl:template>


<!-- ###############################
     PEOPLE PASSWORD
     ############################### -->
<xsl:template name="peoplePassword">
<xsl:call-template name="javascriptForms"/>
<script type="text/javascript">
$().ready(function() {
	$("#people-password").validate({
		rules: {
			password_old: "required",
			password_new: {	required: true,	minlength: 6 },
			password_verify: { required: true, minlength: 6, equalTo: "#password_new" }
		}
	});
});
</script>
<form action="{/root/site/people/@submit}" method="post" id="people-password" accept-charset="{/root/site/@encoding}">
<input type="hidden" name="from" value="password"/>
<xsl:if test="/root/topic">
<input type="hidden" name="id_topic" value="{/root/topic/@id}"/>
</xsl:if>
<ul class="form-inputs">
<xsl:call-template name="formInput">
<xsl:with-param name="varname">password_old</xsl:with-param>
<xsl:with-param name="type">password</xsl:with-param>
<xsl:with-param name="required" select="true()"/>
<xsl:with-param name="autocomplete" select="false()"/>
</xsl:call-template>
<xsl:call-template name="formInput">
<xsl:with-param name="varname">password_new</xsl:with-param>
<xsl:with-param name="type">password</xsl:with-param>
<xsl:with-param name="required" select="true()"/>
<xsl:with-param name="autocomplete" select="false()"/>
</xsl:call-template>
<xsl:call-template name="formInput">
<xsl:with-param name="varname">password_verify</xsl:with-param>
<xsl:with-param name="type">password</xsl:with-param>
<xsl:with-param name="required" select="true()"/>
<xsl:with-param name="autocomplete" select="false()"/>
</xsl:call-template>
<li class="buttons"><input type="submit" value="{key('label','submit')/@tr}" /></li>
</ul>
</form>
</xsl:template>


<!-- ###############################
     PEOPLE PAYMENT
     ############################### -->
<xsl:template name="peoplePayment">
</xsl:template>

  
<!-- ###############################
     PEOPLE PRIVACY
     ############################### -->
<xsl:template name="peoplePrivacy">
<xsl:call-template name="privacyWarning">
<xsl:with-param name="node" select="/root/privacy_warning"/>
</xsl:call-template>
</xsl:template>


<!-- ###############################
     PEOPLE REGISTER
     ############################### -->
<xsl:template name="peopleRegister">
<xsl:call-template name="javascriptForms"/>
<script type="text/javascript">
$().ready(function() {
	$("#people-register").validate({
		rules: {
			name: "required",
			email: { required: true, email:	true },
			password: {	required: true,	minlength: 6 },
			password_verify: { required: true, minlength: 6, equalTo: "#password" }
		}
	});
});
</script>
<form action="{/root/site/people/@submit}" method="post" id="people-register" accept-charset="{/root/site/@encoding}">
<input type="hidden" name="from" value="register"/>
<xsl:if test="/root/topic">
<input type="hidden" name="id_topic" value="{/root/topic/@id}"/>
</xsl:if>
<ul class="form-inputs">
<xsl:call-template name="formInput">
<xsl:with-param name="varname">name</xsl:with-param>
<xsl:with-param name="required" select="true()"/>
</xsl:call-template>
<xsl:call-template name="formInput">
<xsl:with-param name="varname">surname</xsl:with-param>
<xsl:with-param name="required" select="true()"/>
</xsl:call-template>
<xsl:call-template name="formInput">
<xsl:with-param name="varname">email</xsl:with-param>
<xsl:with-param name="required" select="true()"/>
<xsl:with-param name="autocomplete" select="false()"/>
</xsl:call-template>
<xsl:call-template name="formInput">
<xsl:with-param name="varname">password</xsl:with-param>
<xsl:with-param name="type">password</xsl:with-param>
<xsl:with-param name="required" select="true()"/>
<xsl:with-param name="autocomplete" select="false()"/>
</xsl:call-template>
<xsl:call-template name="formInput">
<xsl:with-param name="varname">password_verify</xsl:with-param>
<xsl:with-param name="type">password</xsl:with-param>
<xsl:with-param name="required" select="true()"/>
</xsl:call-template>
<xsl:call-template name="peopleRegisterCustom"/>
<xsl:if test="/root/site/@captcha">
<li class="clearfix">
<xsl:call-template name="peopleCaptcha"/>
</li>
</xsl:if>
<xsl:call-template name="peopleSubscribe"/>
<xsl:call-template name="peopleSubscribeGroup"/>
<xsl:call-template name="peoplePrivacy"/>
</ul>
<xsl:call-template name="peopleSecurity"/>
<ul class="form-inputs">
<li class="buttons"><input type="submit" value="{key('label','submit')/@tr}" /></li>
</ul>
</form>
</xsl:template>


<!-- ###############################
     PEOPLE REGISTER CUSTOM
     ############################### -->
<xsl:template name="peopleRegisterCustom">
<!-- 
<xsl:call-template name="formInput">
<xsl:with-param name="varname">param_phone</xsl:with-param>
<xsl:with-param name="label">phone</xsl:with-param>
</xsl:call-template>
 -->
</xsl:template>


<!-- ###############################
     PEOPLE REMINDER
     ############################### -->
<xsl:template name="peopleReminder">
<xsl:call-template name="javascriptForms"/>
<script type="text/javascript">
$().ready(function() {
	$("#people-reminder").validate({
		rules: {
			email: {
				required: true,
				email:	true
			}
		}
	});
});
</script>
<form action="{/root/site/people/@submit}" method="post" id="people-reminder" accept-charset="{/root/site/@encoding}">
<input type="hidden" name="from" value="reminder"/>
<xsl:if test="/root/topic">
<input type="hidden" name="id_topic" value="{/root/topic/@id}"/>
</xsl:if>
<ul class="form-inputs">
<xsl:call-template name="formInput">
<xsl:with-param name="varname">email</xsl:with-param>
<xsl:with-param name="required" select="true()"/>
<xsl:with-param name="value" select="/root/user/@email"/>
</xsl:call-template>
<xsl:if test="/root/site/@captcha">
<li class="clearfix">
<xsl:call-template name="captchaWrapper"/>
</li>
</xsl:if>
<li class="buttons"><input type="submit" value="{key('label','submit')/@tr}" /></li>
</ul>
</form>
</xsl:template>


<!-- ###############################
     PEOPLE SECURITY
     ############################### -->
<xsl:template name="peopleSecurity">
<fieldset id="security">
<legend><xsl:value-of select="key('label','security')/@tr"/></legend>
<ul class="form-inputs">
<xsl:call-template name="formInput">
<xsl:with-param name="varname">security</xsl:with-param>
<xsl:with-param name="type">radio</xsl:with-param>
<xsl:with-param name="value" select="0"/>
<xsl:with-param name="box_value"><xsl:if test="not(/root/user/@id)">0</xsl:if></xsl:with-param>
<xsl:with-param name="label" select="'computer_public'"/>
</xsl:call-template>
<xsl:call-template name="formInput">
<xsl:with-param name="varname">security</xsl:with-param>
<xsl:with-param name="type">radio</xsl:with-param>
<xsl:with-param name="box_value"><xsl:if test="/root/user/@id">1</xsl:if></xsl:with-param>
<xsl:with-param name="value" select="1"/>
<xsl:with-param name="label" select="'computer_private'"/>
</xsl:call-template>
</ul>
</fieldset>
</xsl:template>


<!-- ###############################
     PEOPLE SUBSCRIBE
     ############################### -->
<xsl:template name="peopleSubscribe">
<xsl:call-template name="formInput">
<xsl:with-param name="varname">subscribe</xsl:with-param>
<xsl:with-param name="type">checkbox</xsl:with-param>
<xsl:with-param name="value" select="true()"/>
<xsl:with-param name="tr_label" select="/root/privacy_warning/@subscribe"/>
</xsl:call-template>
</xsl:template>


<!-- ###############################
     PEOPLE SUBSCRIBE GROUP
     ############################### -->
<xsl:template name="peopleSubscribeGroup">
<!-- Example
<xsl:call-template name="formInput">
<xsl:with-param name="varname" select="'id_pt_groups[]'" />
<xsl:with-param name="type">checkbox</xsl:with-param>
<xsl:with-param name="value" select="false()"/>
<xsl:with-param name="tr_label">Subscribe to GroupName</xsl:with-param>
<xsl:with-param name="box_value" select="1234"/>
</xsl:call-template>
-->
</xsl:template>


<!-- ###############################
     CONTACT CHECKBOX
     ############################### -->
<xsl:template name="contactCheckbox">
<xsl:param name="varname" />
<xsl:param name="tr_label"  />
<xsl:param name="disabled" select="false()" />
<xsl:param name="size" select="'med'" />
<xsl:param name="value" />
<xsl:param name="node" />
<xsl:param name="checked" />
<xsl:param name="description" select="$node/description"/>
<li>
<input type="checkbox" id="{$varname}" name="{$varname}" value="{$value}">
<xsl:if test="$checked=true()">
<xsl:attribute name="checked">checked</xsl:attribute>
</xsl:if>
<xsl:if test="$disabled=true()">
<xsl:attribute name="disabled">disabled</xsl:attribute>
</xsl:if>
</input>
<label for="{$varname}" class="checkbox">
<xsl:value-of select="$tr_label"/>
<div class="newsletter-info">
<xsl:if test="$description!=''"><div><xsl:value-of select="$description"/></div></xsl:if>
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="$node"/>
<xsl:with-param name="name" select="$node/@url"/>
</xsl:call-template>
</div>
</label>
</li>
</xsl:template>


<!-- ###############################
PEOPLE CAPTCHA
############################### -->
<xsl:template name="peopleCaptcha">
<xsl:call-template name="captchaWrapper"/>
</xsl:template>
    
 
</xsl:stylesheet>

