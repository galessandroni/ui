<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

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
<div id="top-bar"><xsl:call-template name="topBar" /></div>
<div id="top-nav"><xsl:call-template name="topNav"/></div>
<div>
<xsl:attribute name="id">
<xsl:choose>
<xsl:when test="/root/topic">main</xsl:when>
<xsl:otherwise>main-global</xsl:otherwise>
</xsl:choose>
</xsl:attribute>
<div id="left-bar"><xsl:call-template name="leftBar" /></div>
<div id="right-bar"><xsl:call-template name="rightBar" /></div>
<div id="center">
<xsl:if test="$pagetype='topic_home' ">
<xsl:apply-templates select="/root/features/feature[@id='57']" />
</xsl:if>
<xsl:call-template name="content" /></div>
</div>
<div id="bottom-bar"><xsl:call-template name="bottomBar" /></div>
</div>
</body>
</html>
</xsl:template>


<!-- ###############################
TOP BAR 
############################### -->
<xsl:template name="topBar">
<div id="logo">
<a>
<xsl:attribute name="href">
<xsl:call-template name="createLinkUrl">
<xsl:with-param name="node" select="/root/topic"/>
</xsl:call-template>
</xsl:attribute>
<xsl:call-template name="graphic">
<xsl:with-param name="id" select="256"/>
</xsl:call-template>
</a>
</div>
<div id="bannerhp"><xsl:call-template name="bannerGroup">
<xsl:with-param name="id" select="'4'"/>
</xsl:call-template></div>
<div id="citazione">
<script type="text/javascript" src="http://www.peacelink.it/js/quote.php?id_topic=85"></script>
</div>
</xsl:template>


<!-- ###############################
TOP NAV 
############################### -->
<xsl:template name="topNav">
<h2 class="hidden">Autoconvocata</h2>

<ul id="pck-links">

<li><a href="http://www.peacelink.it">Peacelink</a></li>

<li><a href="http://www.giornalismi.info/mediarom">Giornalisti contro il razzismo</a></li>

<li><a href="http://digiunoastaffetta.blogspot.com/">Digiuno a staffetta</a></li>

<li><a href="http://ilprossimosonoio.blogspot.com/">Il prossimo sono io</a></li>

<li><a href="http://culturaaltra.blogspot.com/">Marcia della convivenza</a></li>



<li>
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="/root/c_features/feature[@id=47]/items/subtopic"/>
</xsl:call-template>
</li>


</ul>

<h2 class="hidden">I contenuti del sito</h2>
<ul id="content-links">

<li><a href="http://www.autoconvocata.org">Home</a></li>

<li><a href="http://www.peacelink.it/calendario/events.php?id_topic=85">Calendario</a></li>

<li><a href="http://www.autoconvocata.org/ac/i/3039.html">Chi siamo</a></li>

<li><a href="http://www.autoconvocata.org/ac/i/3049.html">Mappa del sito</a></li>

<li><a href="http://www.autoconvocata.org/ac/i/3051.html">Contatti</a></li>


</ul>
<div id="search-bar">
<xsl:if test="$pagetype!='error404'">
<xsl:call-template name="userInfo"/>
</xsl:if>
</div>
</xsl:template>


<!-- ###############################
     SUPPORT 
     ############################### 
<xsl:template name="support">
<div class="pckbox" id="support">
<xsl:apply-templates select="/root/c_features/feature[@id='48']"/>
</div>
</xsl:template> -->

<!-- ###############################
     REDAZIONE
     ###############################
<xsl:template name="redazione">
<div class="pckbox" id="redazione">
<xsl:apply-templates select="/root/c_features/feature[@id='49']"/>
</div>
</xsl:template> -->


<!-- ###############################
     RETE
     ############################### -->
<xsl:template name="rete">
<div class="pckbox" id="redazione">
<xsl:apply-templates select="/root/c_features/feature[@id='50']"/>
</div>
</xsl:template>


<!-- ###############################
     LEFT BAR PCK
     ############################### 
<xsl:template name="leftBar">
<xsl:call-template name="navigationMenu"/>
<xsl:call-template name="support"/>
<xsl:call-template name="redazione"/>
<xsl:call-template name="rete"/>
<xsl:apply-templates select="/root/c_features/feature[@id='56']" />
<xsl:call-template name="leftBottom"/>
</xsl:template> -->

<!-- ###############################
     LEFT BAR 
     ############################### 
<xsl:template name="leftBar">
<xsl:call-template name="navigationMenu"/>
<xsl:call-template name="leftBottom"/>
</xsl:template> -->




<!-- ###############################
     LEFT BOTTOM
     ############################### -->
<xsl:template name="leftBottom">
<p>Si ringrazia per l'ospitalita' l'associazione PeaceLink</p>
<div id="logopck">
<a>
<xsl:attribute name="href">
<xsl:call-template name="createLinkUrl">
<xsl:with-param name="node" select="/root/site"/>
</xsl:call-template>
</xsl:attribute>
<xsl:call-template name="graphic">
<xsl:with-param name="id" select="5"/>
<xsl:with-param name="format" select="'gif'"/>
</xsl:call-template>
</a>
</div>
</xsl:template>

<!-- ###############################
     BOTTOM BAR
     ############################### -->

<xsl:template name="bottomBar">

Assemblea Autoconvocata Firenze - <a href="mailto:info@autoconvocata.org">info (at) autoconvocata (dot) org</a> - 

<xsl:call-template name="createLink">
<xsl:with-param name="node" select="/root/c_features/feature[@id='104']/items/subtopic"/>
<xsl:with-param name="name" select="/root/c_features/feature[@id='104']/@name"/>
</xsl:call-template>

 - Sito realizzato con <a href="http://www.phpeace.org">PhPeace <xsl:value-of select="/root/site/@phpeace"/></a>
- Privacy - Accessibilita' - Web standards 

</xsl:template>

</xsl:stylesheet>
