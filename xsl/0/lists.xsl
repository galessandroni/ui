<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!--********************************************************************
Questo XSL e' stato modificato a mano per PeaceLink
********************************************************************-->

<xsl:output method="html" encoding="UTF-8" indent="no" doctype-system="http://www.w3.org/TR/html4/strict.dtd"  doctype-public="-//W3C//DTD HTML 4.01//EN" />

<xsl:include href="common.xsl" />

<xsl:variable name="ml" select="/root/mailing_lists"/>

<xsl:variable name="title">
<xsl:value-of select="/root/labels/label[@word='mailing_lists']/@tr"/>
<xsl:if test="$subtype='group' ">
<xsl:value-of select="concat($breadcrumb_separator,$ml/group/@name)"/>
</xsl:if>
<xsl:if test="$subtype='list'">
<xsl:value-of select="concat($breadcrumb_separator,$ml/group/lists/list/@name)"/>
</xsl:if>
</xsl:variable>


<xsl:variable name="current_page_title" select="$title"/>


<!-- ###############################
     CONTENT
     ############################### -->
<xsl:template name="content">
<div class="breadcrumb">
<xsl:call-template name="createLink">
<xsl:with-param name="name" select="/root/labels/label[@word='mailing_lists']/@tr"/>
<xsl:with-param name="node" select="$ml"/>
</xsl:call-template>
<xsl:if test="$subtype='group'">
<xsl:value-of select="$breadcrumb_separator"/>
<xsl:call-template name="createLink">
<xsl:with-param name="name" select="$ml/group/@name"/>
<xsl:with-param name="node" select="$ml/group"/>
</xsl:call-template>
</xsl:if>
<xsl:if test="$subtype='list'">
<xsl:value-of select="$breadcrumb_separator"/>
<xsl:call-template name="createLink">
<xsl:with-param name="name" select="$ml/group/lists/list/@name"/>
<xsl:with-param name="node" select="$ml/group/lists/list"/>
</xsl:call-template>
</xsl:if>
</div>
<xsl:call-template name="feedback"/>
<div id="lists-content">
<xsl:choose>
<xsl:when test="$subtype='group'">
<p>Questo e' l'elenco delle mailing list di <em><xsl:value-of select="$ml/group/@name"/></em>. Cliccando sul nome della lista si accede al relativo modulo di iscrizione o cancellazione.</p>
<xsl:apply-templates select="$ml/group" mode="lists"/>
</xsl:when>
<xsl:when test="$subtype='list'">
<xsl:call-template name="mailingListForm">
<xsl:with-param name="node" select="$ml/group/lists/list"/>
</xsl:call-template>
<xsl:if test="$ml/group/lists/list/feed/rss">
<xsl:call-template name="rssParse">
<xsl:with-param name="node" select="$ml/group/lists/list/feed/rss/rss"/>
</xsl:call-template>
</xsl:if>
</xsl:when>
<xsl:otherwise>
<xsl:choose>
<xsl:when test="/root/topic"><xsl:call-template name="mailingListTopic"/></xsl:when>
<xsl:otherwise><xsl:call-template name="mailingListHome"/></xsl:otherwise>
</xsl:choose>
</xsl:otherwise>
</xsl:choose>
</div>
</xsl:template>


<!-- ###############################
     MAILING LISTS GROUP
     ############################### -->
<xsl:template match="group" mode="lists">
<xsl:if test="lists">
<ul id="ml-lists">
<xsl:apply-templates select="lists/list" mode="lists"/>
</ul>
</xsl:if>
</xsl:template>


<!-- ###############################
     MAILING LISTS HOME
     ############################### -->
<xsl:template name="mailingListHome">
<p>Questo e' l'elenco delle mailing list disponibili. Cliccando sul nome della lista si accede al relativo modulo di iscrizione o cancellazione.</p>
<ul id="ml-groups">
<xsl:for-each select="$ml/group">
<li>
<xsl:call-template name="createLink">
<xsl:with-param name="name" select="@name"/>
<xsl:with-param name="node" select="."/>
</xsl:call-template>
<xsl:apply-templates select="." mode="lists"/>
</li>
</xsl:for-each>
</ul>
</xsl:template>


<!-- ###############################
     MAILING LISTS LIST
     ############################### -->
<xsl:template match="list" mode="lists">
<li>
<xsl:call-template name="createLink">
<xsl:with-param name="name" select="@name"/>
<xsl:with-param name="node" select="."/>
</xsl:call-template> - <xsl:value-of select="@email"/>
<xsl:if test="description">
<div class="list-description"><xsl:value-of select="description" disable-output-escaping="yes"/></div>
</xsl:if>
</li>
</xsl:template>


<!-- ###############################
     MAILING LISTS TOPIC
     ############################### -->
<xsl:template name="mailingListTopic">
<ul id="ml-lists">
<xsl:apply-templates select="$ml/group/lists/list" mode="lists"/>
</ul>
</xsl:template>


<!-- ###############################
     MAILING LIST FORM
     ############################### -->
<xsl:template name="mailingListForm">
<xsl:param name="node"/>
<h1><xsl:value-of select="$node/@name"/></h1>
<p><strong><xsl:value-of select="$node/@email"/></strong></p>
<p><em><xsl:value-of select="$node/description" disable-output-escaping="yes"/></em></p>
<xsl:if test="$node/archive">
<div><xsl:value-of select="concat($node/archive/@label,': ')"/><a href="{$node/archive/@url}"><xsl:value-of select="$node/archive/@url"/></a></div>
</xsl:if>
<xsl:if test="$node/feed">
<div><xsl:value-of select="concat($node/feed/@label,': ')"/><a href="{$node/feed/@url}"><xsl:value-of select="$node/feed/@url"/></a></div>
</xsl:if>
<p><xsl:value-of select="$node/form_info" disable-output-escaping="yes"/></p>
<xsl:call-template name="javascriptForms"/>
<script type="text/javascript">
$().ready(function() {
    $("#list-ops").validate({
        rules: {
            email: {
                required: true,
                email:    true
            }
        }
    });
});
</script>
<form action="{/root/mailing_lists/@submit}" method="post" id="list-ops" accept-charset="{/root/site/@encoding}">
<input type="hidden" name="from" value="list"/>
<input type="hidden" name="id_list" value="{$node/@id}"/>
<xsl:if test="/root/topic">
<input type="hidden" name="id_topic" value="{/root/topic/@id}"/>
</xsl:if>
<ul class="form-inputs">
<xsl:call-template name="formInput">
<xsl:with-param name="varname">email</xsl:with-param>
<xsl:with-param name="required" select="true()"/>
</xsl:call-template>
<li class="buttons"><input type="submit" name="action_subscribe" value="{/root/labels/label[@word='subscribe']/@tr}"/>
<input type="submit" name="action_unsubscribe" value="{/root/labels/label[@word='unsubscribe']/@tr}"/>
</li>
</ul>
</form>
</xsl:template>


<!-- ###############################
     PAGE TITLE
     ############################### -->
<xsl:template name="pageTitle">
<xsl:if test="$preview=true()">[<xsl:value-of select="/root/labels/label[@word='preview']/@tr"/>] - </xsl:if>
<xsl:value-of select="$title"/>
</xsl:template>


</xsl:stylesheet>

