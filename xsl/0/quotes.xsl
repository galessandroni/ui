<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html" encoding="UTF-8" indent="no" />

<xsl:include href="common.xsl" />

<xsl:variable name="current_page_title" select="key('label','quotes')/@tr"/>


<!-- ###############################
     CONTENT
     ############################### -->
<xsl:template name="content">
<div class="breadcrumb">
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="/root/quotes"/>
<xsl:with-param name="name" select="key('label','quotes')/@tr"/>
</xsl:call-template>
</div>
<xsl:call-template name="feedback"/>
<div id="quotes-content">
<xsl:choose>
<xsl:when test="/root/publish/@subtype='home'">
<xsl:call-template name="quoteMain"/>
</xsl:when>
<xsl:when test="/root/publish/@subtype='list'">
<xsl:call-template name="items">
<xsl:with-param name="root" select="/root/quotes/quotes"/>
<xsl:with-param name="node" select="/root/quotes/list"/>
</xsl:call-template>
</xsl:when>
<xsl:when test="/root/publish/@subtype='insert'">
<xsl:call-template name="quoteInsert"/>
</xsl:when>
</xsl:choose>
</div>
</xsl:template>


<!-- ###############################
     QUOTE MAIN
     ############################### -->
<xsl:template name="quoteMain">
<p>
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="/root/quotes/list"/>
<xsl:with-param name="name" select="concat(/root/quotes/@num,' ',key('label','quotes_total')/@tr)"/>
</xsl:call-template>
 - 
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="/root/quotes/insert"/>
<xsl:with-param name="name" select="key('label','quotes_submit')/@tr"/>
</xsl:call-template>
</p>

<div class="codebox">
<xsl:value-of select="key('label','quotes_script')/@tr"/>
<code>
&lt;script type="text/javascript" src="<xsl:value-of select="/root/site/@base"/>/js/quote.php<xsl:if test="/root/topic">&amp;id_topic=<xsl:value-of select="/root/topic/@id"/>
</xsl:if>"&gt;&lt;/script&gt;
</code></div>

<xsl:call-template name="quoteItem">
<xsl:with-param name="i" select="/root/quotes/quote"/>
</xsl:call-template>

</xsl:template>


<!-- ###############################
     QUOTE INSERT
     ############################### -->
<xsl:template name="quoteInsert">
<xsl:choose>
<xsl:when test="/root/publish/@id &gt; 0">
<p><xsl:value-of select="key('label','insert_thanks')/@tr"/></p>
</xsl:when>
<xsl:otherwise>
<xsl:call-template name="javascriptForms"/>
<script type="text/javascript">
$().ready(function() {
	$("#quote-insert").validate({
		rules: {
			quote: "required",
			author: "required"
		}
	});
});
</script>
<form action="{/root/site/@base}/{/root/site/quotes/@path}/actions.php" method="post" id="quote-insert" accept-charset="{/root/site/@encoding}">
<input type="hidden" name="from" value="quote"/>
<input type="hidden" name="id_topic" value="{/root/topic/@id}"/>
<ul class="form-inputs">
<xsl:call-template name="formInput">
<xsl:with-param name="varname">quote</xsl:with-param>
<xsl:with-param name="type">textarea</xsl:with-param>
<xsl:with-param name="size" select="'large'"/>
<xsl:with-param name="required" select="true()"/>
</xsl:call-template>
<xsl:call-template name="formInput">
<xsl:with-param name="varname">author</xsl:with-param>
<xsl:with-param name="required" select="true()"/>
</xsl:call-template>
<xsl:call-template name="formInput">
<xsl:with-param name="varname">author_notes</xsl:with-param>
<xsl:with-param name="type">textarea</xsl:with-param>
</xsl:call-template>
<xsl:if test="/root/site/@captcha">
<li class="clearfix">
<xsl:call-template name="captchaWrapper"/>
</li>
</xsl:if>
<li class="buttons"><input type="submit" value="{key('label','submit')/@tr}" name="action_sign"/>
<input type="reset" value="{key('label','cancel')/@tr}" name="action_sign"/></li>
</ul>
</form>
</xsl:otherwise>
</xsl:choose>
</xsl:template>


</xsl:stylesheet>
