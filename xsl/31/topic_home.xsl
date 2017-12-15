<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="../0/topic_home.xsl" />

<xsl:output method="html" encoding="UTF-8" indent="no" doctype-system="http://www.w3.org/TR/html4/strict.dtd"  doctype-public="-//W3C//DTD HTML 4.01//EN" />

<xsl:include href="common.xsl" />

<!-- ###############################
     CONTENT
     ############################### -->
<xsl:template name="content">

<div id="cd-home">
<div id="cd-current"><xsl:call-template name="topicHome"/></div>
<div id="right-bar"><xsl:call-template name="rightBarPck" /></div>
</div>

<div id="cd-boxes">
<div class="cd-box"><xsl:apply-templates select="/root/features/feature[@id=53]"/></div>
<div class="cd-box"><xsl:apply-templates select="/root/features/feature[@id=54]"/></div>
<div class="cd-box"><xsl:apply-templates select="/root/features/feature[@id=55]"/></div>
</div>

<!--


<h2>PRESENTAZIONE</h2>
<div id="fotohome">
<xsl:call-template name="galleryImage">
<xsl:with-param name="i" select="/root/features/feature[@id='70']/items/item"/>
</xsl:call-template>
<div class="description"><xsl:value-of select="/root/features/feature[@id='70']/items/item/@caption"/></div>
</div>
<div class="header"><xsl:apply-templates select="/root/home_header"/></div>

<xsl:apply-templates select="/root/features/feature[@id=25]"/>
<div class="footer"><xsl:apply-templates select="/root/home_footer"/></div>
-->
</xsl:template>



<!-- ###############################
     ROOT
     ############################### -->
<xsl:template name="root">
<html>
<xsl:attribute name="lang">
<xsl:choose>
<xsl:when test="/root/topic"><xsl:value-of select="/root/topic/@lang"/></xsl:when>
<xsl:otherwise><xsl:value-of select="/root/site/@lang"/></xsl:otherwise>
</xsl:choose>
</xsl:attribute>
<head>
<xsl:call-template name="head"/>
</head>
<body class="{/root/publish/@type}" id="id{/root/publish/@id}">
<xsl:if test="/root/preview"><xsl:call-template name="previewToolbar"/></xsl:if>
<div id="main-wrap" >
<div id="top-bar"><xsl:call-template name="topBarPck" /></div>
<div id="top-nav"><xsl:call-template name="topNavPck"/></div>
<div>
<xsl:attribute name="id">
<xsl:choose>
<xsl:when test="/root/topic">main</xsl:when>
<xsl:otherwise>main-global</xsl:otherwise>
</xsl:choose>
</xsl:attribute>
<div id="left-bar"><xsl:call-template name="leftBarPck" /></div>
<div id="center"><xsl:call-template name="content" /></div>
</div>
<div id="bottom-bar"><xsl:call-template name="bottomBarPck" /></div>
</div>
</body>
</html>
</xsl:template>


</xsl:stylesheet>
