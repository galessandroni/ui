<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:include href="root.xsl" />
<xsl:include href="tools.xsl" />


<!-- ###############################
     RIGHT BAR PCK
     ############################### -->
<xsl:template name="rightBarPck">
<xsl:call-template name="searchPck"/>
<xsl:call-template name="tickerPck"/>

<xsl:choose>
<xsl:when test="$pagetype='topic_home'">
<xsl:call-template name="newsPckTopic"/>
</xsl:when>

<xsl:when test="$pagetype='article'">
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
</xsl:when>

<xsl:otherwise>
<div class="pckbox">
<xsl:variable name="f" select="/root/c_features/feature[@id='32']"/>
<h3 class="feature"><xsl:value-of select="$f/@name"/></h3>
<ul class="items">
<xsl:apply-templates select="$f/items" mode="mainlist"/>
</ul>
</div>
</xsl:otherwise>

</xsl:choose>
</xsl:template>



<!-- ###############################
     NEWS PCK TOPIC
     ############################### -->
<xsl:template name="newsPckTopic">
<xsl:if test="/root/features/feature[@id='14']/items">
<div class="pckbox">
<xsl:apply-templates select="/root/features/feature[@id='14']"/>
</div>
</xsl:if>
</xsl:template>



<!-- ###############################
     PRINT
     ############################### -->
<xsl:template name="print">
<li><a target="_blank" title="Prima di stampare questa pagina chiediti se ne puoi fare a meno: l'ambiente ringrazia.">
<xsl:attribute name="href">
<xsl:choose>
<xsl:when test="$preview='1'">preview.php?id_type=14&amp;id=<xsl:value-of select="/root/article/@id"/>&amp;id_topic=<xsl:value-of select="/root/article/topic/@id"/></xsl:when>
<xsl:otherwise><xsl:value-of select="/root/site/@base"/>/tools/print.php?id=<xsl:value-of select="/root/article/@id"/></xsl:otherwise>
</xsl:choose>
</xsl:attribute>
<xsl:value-of select="/root/labels/label[@word='print']/@tr"/></a></li>
</xsl:template>

</xsl:stylesheet>

