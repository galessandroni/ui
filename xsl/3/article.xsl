<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="../0/article.xsl" />

<xsl:output method="html" encoding="UTF-8" indent="no" />

<xsl:include href="common.xsl" />

<!-- ###############################
     RIGHT BAR PCK
     ############################### -->
<xsl:template name="rightBarPck2">
<xsl:call-template name="searchPck"/>
<xsl:call-template name="tickerPck"/>

<xsl:variable name="f1" select="/root/features/feature[@id='33']"/>
<xsl:variable name="f2" select="/root/c_features/feature[@id='32']"/>
<div class="pckbox" id="similar">
<xsl:choose>
<xsl:when test="$f1/items">
<h3 class="feature"><xsl:value-of select="$f1/@name"/></h3>
<ul class="items">
<xsl:for-each select="$f1/items/item">
<li>
<div class="item-breadcrumb">
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="topic"/>
<xsl:with-param name="name" select="topic/@name"/>
</xsl:call-template>
</div>
<xsl:call-template name="articleItem">
<xsl:with-param name="a" select="."/>
</xsl:call-template>
</li>
</xsl:for-each>
</ul>
</xsl:when>
<xsl:otherwise>
<h3 class="feature"><xsl:value-of select="$f2/@name"/></h3>
<ul class="items">
<xsl:apply-templates select="$f2/items" mode="mainlist"/>
</ul>
</xsl:otherwise>
</xsl:choose>
</div>

</xsl:template>

</xsl:stylesheet>
