<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html" encoding="UTF-8" indent="no" />

<xsl:include href="common.xsl" />

<xsl:variable name="current_page_title" select="concat(/root/comments/@title,' - ',key('label','comments')/@tr)"/>


<!-- ###############################
     CONTENT
     ############################### -->
<xsl:template name="content">
<xsl:call-template name="commentBreadcrumb" />
<xsl:call-template name="feedback"/>
<xsl:call-template name="articleItem" >
<xsl:with-param name="a" select="/root/comments/article"/>
</xsl:call-template>
<h2>
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="/root/comments"/>
<xsl:with-param name="name" select="key('label','comments')/@tr"/>
<xsl:with-param name="condition" select="$subtype!='browse'"/>
</xsl:call-template>
</h2>
<xsl:choose>
<xsl:when test="$subtype='comment'">
<xsl:apply-templates select="/root/comments/comment" />
</xsl:when>
<xsl:when test="$subtype='insert' ">
<xsl:call-template name="commentInsert"/>
</xsl:when>
<xsl:when test="$subtype='browse' ">
<ul class="thread">
<xsl:apply-templates select="/root/comments/tree" mode="treeitem"/>
</ul>

<xsl:if test="/root/comments/@active='1' and /root/comments/insert">
<div class="comments">
<xsl:call-template name="createLink">
<xsl:with-param name="name" select="/root/comments/insert/@label"/>
<xsl:with-param name="node" select="/root/comments/insert"/>
</xsl:call-template>
</div>
</xsl:if>

</xsl:when>
</xsl:choose>
</xsl:template>


<!-- ###############################
     COMMENT BREADCRUMB
     ############################### -->
<xsl:template name="commentBreadcrumb">
<div class="breadcrumb">
<xsl:choose>
<xsl:when test="/root/comments/@id_type='5'">
<xsl:apply-templates select="/root/comments/article/breadcrumb" mode="breadcrumb"/>
</xsl:when>
<xsl:when test="/root/comments/@id_type='10'">
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="/root/comments/forum"/>
<xsl:with-param name="name" select="/root/comments/forum/@title"/>
</xsl:call-template>
<xsl:value-of select="$breadcrumb_separator"/>
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="/root/comments/thread"/>
<xsl:with-param name="name" select="/root/comments/thread/@title"/>
</xsl:call-template>
</xsl:when>
<xsl:when test="/root/comments/@id_type='20'">
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="/root/comments/poll"/>
<xsl:with-param name="name" select="/root/comments/poll/@title"/>
</xsl:call-template>
<xsl:value-of select="$breadcrumb_separator"/>
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="/root/comments/question"/>
<xsl:with-param name="name" select="/root/comments/question/@question"/>
</xsl:call-template>
</xsl:when>
</xsl:choose>
<xsl:if test="$subtype='browse' or $subtype='comment' or $subtype='insert'">
<xsl:value-of select="$breadcrumb_separator"/>
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="/root/comments"/>
<xsl:with-param name="name" select="key('label','comments')/@tr"/>
<xsl:with-param name="condition" select="$subtype!='browse'"/>
</xsl:call-template>
</xsl:if>
</div>
</xsl:template>


<!-- ###############################
     COMMENT [TREEITEM]
     ############################### -->
<xsl:template match="comment" mode="treeitem">
<li class="comment-item">
<div class="author"><xsl:value-of select="@author"/> - <xsl:value-of select="@date"/></div>
<h3>
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="."/>
<xsl:with-param name="name" select="@title"/>
</xsl:call-template>
</h3>
<xsl:if test="comments">
<ul>
<xsl:apply-templates select="comments" mode="treeitem"/>
</ul>
</xsl:if>
</li>
</xsl:template>


<!-- ###############################
     COMMENT
     ############################### -->
<xsl:template match="comment">
<div id="comment">
<h2><xsl:value-of select="@title"/></h2>
<div class="author"><xsl:value-of select="@author"/> - <xsl:value-of select="@date"/></div>
<div class="comment-text"><xsl:value-of select="text" disable-output-escaping="yes"/>
</div>


<xsl:if test="/root/comments/@active='1'">
<div class="comments">
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="reply"/>
<xsl:with-param name="name" select="key('label','reply')/@tr"/>
</xsl:call-template>
-
<xsl:if test="/root/comments/insert">
<xsl:call-template name="createLink">
<xsl:with-param name="name" select="/root/comments/insert/@label"/>
<xsl:with-param name="node" select="/root/comments/insert"/>
</xsl:call-template>
</xsl:if>

</div>
</xsl:if>

<ul class="thread">
<xsl:apply-templates select="/root/comments/tree" mode="treeitem"/>
</ul>

</div>
</xsl:template>


<!-- ###############################
     COMMENT INSERT
     ############################### -->
<xsl:template name="commentInsert">
<xsl:choose>
<xsl:when test="not(/root/comments/insert)">
<p><xsl:value-of select="key('label','comments_not_allowed')/@tr"/></p>
</xsl:when>
<xsl:when test="/root/comments/login">
<xsl:call-template name="loginFirst">
<xsl:with-param name="node" select="/root/comments/login"/>
</xsl:call-template>
</xsl:when>
<xsl:otherwise><xsl:call-template name="commentInsertForm"/></xsl:otherwise>
</xsl:choose>
</xsl:template>


<!-- ###############################
     COMMENT INSERT FORM
     ############################### -->
<xsl:template name="commentInsertForm">
<xsl:call-template name="javascriptForms"/>
<script type="text/javascript">
$().ready(function() {
	$("#comment-insert").validate({
		rules: {
			title: "required",
			comment: "required"
		}
	});
});
</script>
<form action="{/root/site/@base}/tools/actions.php" method="post" id="comment-insert" accept-charset="{/root/site/@encoding}">
<input type="hidden" name="from" value="comment"/>
<xsl:if test="/root/topic">
<input type="hidden" name="id_topic" value="{/root/topic/@id}"/>
<input type="hidden" name="id_r" value="{/root/comments/@id_type}"/>
<input type="hidden" name="id_item" value="{/root/comments/@id_item}"/>
<input type="hidden" name="id_parent" value="{/root/comments/parent/@id}"/>
</xsl:if>
<fieldset>
<legend><xsl:value-of select="/root/comments/insert/@label"/></legend>
<ul class="form-inputs">
<xsl:call-template name="formInput">
<xsl:with-param name="varname">title</xsl:with-param>
<xsl:with-param name="required" select="true()"/>
<xsl:with-param name="size">large</xsl:with-param>
<xsl:with-param name="value" select="/root/comments/parent/@reply_title"/>
</xsl:call-template>
<xsl:call-template name="formInput">
<xsl:with-param name="varname">comment</xsl:with-param>
<xsl:with-param name="required" select="true()"/>
<xsl:with-param name="type">textarea</xsl:with-param>
<xsl:with-param name="size">extralarge</xsl:with-param>
</xsl:call-template>
<xsl:choose>
<xsl:when test="/root/user/@id &gt; 0">
<p><xsl:value-of select="key('label','author')/@tr"/>: <xsl:value-of select="/root/user/@name"/></p>
</xsl:when>
<xsl:otherwise>
<xsl:call-template name="formInput">
<xsl:with-param name="varname">name</xsl:with-param>
<xsl:with-param name="label">name</xsl:with-param>
<xsl:with-param name="required" select="true()"/>
</xsl:call-template>
<xsl:call-template name="formInput">
<xsl:with-param name="varname">email</xsl:with-param>
<xsl:with-param name="label">email</xsl:with-param>
<xsl:with-param name="required" select="true()"/>
</xsl:call-template>
<xsl:call-template name="privacyWarning">
<xsl:with-param name="node" select="/root/comments/privacy_warning"/>
</xsl:call-template>
</xsl:otherwise>
</xsl:choose>
<xsl:if test="/root/site/@captcha">
    <li class="clearfix">
        <xsl:call-template name="captchaWrapper"/>
    </li>
</xsl:if>
</ul>
</fieldset>
<ul class="form-inputs">
<li class="buttons"><input type="submit" value="{key('label','submit')/@tr}"/></li>
</ul>
</form>
</xsl:template>


</xsl:stylesheet>
