<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="../0/lists.xsl" />

<xsl:output method="html" encoding="UTF-8" indent="no" doctype-system="http://www.w3.org/TR/html4/strict.dtd"  doctype-public="-//W3C//DTD HTML 4.01//EN" />

<xsl:include href="common.xsl" />



<!-- ###############################
     CONTENT
     ############################### -->
<xsl:template name="content">
<div class="linea">
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
</div></div>
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

</xsl:stylesheet>
