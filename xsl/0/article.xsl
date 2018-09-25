<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html" encoding="UTF-8" indent="no" />

<xsl:include href="common.xsl" />

<xsl:variable name="current_page_title" select="/root/article/headline"/>


<!-- ###############################
     CONTENT
     ############################### -->
<xsl:template name="content">
<xsl:call-template name="breadcrumb" />
<xsl:choose>
<xsl:when test="$subtype='thanks' ">
<xsl:call-template name="feedback"/>
<xsl:call-template name="articleItem" >
<xsl:with-param name="a" select="/root/article"/>
</xsl:call-template>
</xsl:when>
<xsl:when test="/root/article/login">
<p>
<xsl:call-template name="createLink">
<xsl:with-param name="name" select="/root/article/login/@label"/>
<xsl:with-param name="node" select="/root/article/login"/>
</xsl:call-template>
</p>
</xsl:when>
<xsl:when test="/root/article/available=0 and /root/topic/@protected=2 and /root/user/@topic_auth=0">
<p>User not authorized</p>
</xsl:when>
<xsl:otherwise>
<xsl:call-template name="toolBar" />
<xsl:call-template name="articleContent" />
</xsl:otherwise>
</xsl:choose>
</xsl:template>


</xsl:stylesheet>

