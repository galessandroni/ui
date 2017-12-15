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
<div id="top-bar"><xsl:call-template name="topBarCB" /></div>
<div id="top-nav"><xsl:call-template name="topNavCB"/></div>
<div>
<xsl:attribute name="id">
<xsl:choose>
<xsl:when test="/root/topic">main</xsl:when>
<xsl:otherwise>main-global</xsl:otherwise>
</xsl:choose>
</xsl:attribute>
<div id="left-bar"><xsl:call-template name="leftBarCB" /></div>
<div id="right-bar"><xsl:call-template name="rightBarCB" /></div>
<div id="center">
<xsl:if test="$pagetype='topic_home' ">
<xsl:apply-templates select="/root/features/feature[@id='57']" />
</xsl:if>
<xsl:call-template name="content" /></div>
</div>
<div id="bottom-bar"><xsl:call-template name="bottomBarCB" /></div>
</div>
</body>
</html>
</xsl:template>


<!-- ###############################
TOP BAR CASABLANCA
############################### -->
<xsl:template name="topBarCB">
<div id="logo">
<a>
<xsl:attribute name="href">
<xsl:call-template name="createLinkUrl">
<xsl:with-param name="node" select="/root/topic"/>
</xsl:call-template>
</xsl:attribute>
<xsl:call-template name="graphic">
<xsl:with-param name="id" select="224"/>
</xsl:call-template>
</a>
</div>
<div id="bannerhp"><xsl:call-template name="bannerGroup">
<xsl:with-param name="id" select="'20'"/>
</xsl:call-template></div>
<div id="citazione">
<script type="text/javascript" src="http://www.peacelink.it/js/quote.php?id_topic=71"></script>
</div>
</xsl:template>


<!-- ###############################
TOP NAV CASABLANCA
############################### -->
<xsl:template name="topNavCB">
<h2 class="hidden">Casablanca</h2>

<ul id="pck-links">

<li><a href="http://www.peacelink.it/casablanca/a/25097.html">Abbonamenti</a></li>

<li><a href="http://www.peacelink.it/casablanca/a/25098.html">Redazione</a></li>

<li><a href="http://www.peacelink.it/casablanca/a/25099.html">Chi siamo</a></li>

<li><a href="http://www.peacelink.it/casablanca/i/2769.html">Links</a></li>

<li><a href="http://www.peacelink.it/sanlibero/index.html">La Catena di San Libero</a></li>


<li>
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="/root/c_features/feature[@id=47]/items/subtopic"/>
</xsl:call-template>
</li>


</ul>

<h2 class="hidden">I contenuti del sito</h2>
<ul id="content-links">

<li><a href="http://www.peacelink.it/casablanca/i/2831.html">Sicilia</a></li>

<li><a href="http://www.peacelink.it/casablanca/i/2834.html">Inchieste</a></li>

<li><a href="http://www.peacelink.it/casablanca/i/2837.html">Societa'</a></li>

<li><a href="http://www.peacelink.it/casablanca/i/2832.html">Le Siciliane</a></li>

<li><a href="http://www.peacelink.it/casablanca/i/2833.html">Altri Sud</a></li>

<li><a href="http://www.peacelink.it/casablanca/i/2836.html">Idee</a></li>

<li><a href="http://www.peacelink.it/casablanca/i/2835.html">Culture</a></li>

<li><a href="http://www.peacelink.it/casablanca/i/2764.html">Movimenti</a></li>

<li><a href="http://www.peacelink.it/casablanca/i/2763.html">Rassegna stampa</a></li>


</ul>
<div id="search-bar">
<xsl:if test="$pagetype!='error404'">
<xsl:call-template name="userInfo"/>
</xsl:if>
</div>
</xsl:template>


<!-- ###############################
     SUPPORT CASABLANCA
     ############################### -->
<xsl:template name="supportCB">
<div class="pckbox" id="support">
<xsl:apply-templates select="/root/c_features/feature[@id='48']"/>
</div>
</xsl:template>

<!-- ###############################
     REDAZIONE CASABLANCA
     ############################### -->
<xsl:template name="redazioneCB">
<div class="pckbox" id="redazione">
<xsl:apply-templates select="/root/c_features/feature[@id='49']"/>
</div>
</xsl:template>


<!-- ###############################
     RETE CASABLANCA
     ############################### -->
<xsl:template name="reteCB">
<div class="pckbox" id="redazione">
<xsl:apply-templates select="/root/c_features/feature[@id='50']"/>
</div>
</xsl:template>


<!-- ###############################
     LEFT BAR CASABLANCA
     ############################### -->
<xsl:template name="leftBarCB">
<xsl:call-template name="navigationMenu"/>
<xsl:call-template name="supportCB"/>
<xsl:call-template name="redazioneCB"/>
<xsl:call-template name="reteCB"/>
<xsl:apply-templates select="/root/c_features/feature[@id='56']" />
<xsl:call-template name="leftBottom"/>
</xsl:template>


<!-- ###############################
     LEFT BOTTOM
     ############################### -->
<xsl:template name="leftBottom">
Si ringrazia per l'ospitalita' l'associazione PeaceLink
</xsl:template>


<!-- ###############################
     RIGHT BAR CASABLANCA
     ############################### -->
<xsl:template name="rightBarCB">

<!--  <div id="work-in-progress">
<h3>AVVISO DI SERVIZIO</h3>
Il sito di Casablanca e' in fase di ristrutturazione, ci scusiamo per eventuali disguidi
</div> -->

<xsl:apply-templates select="/root/c_features/feature[@id='61']" />
<xsl:apply-templates select="/root/c_features/feature[@id='60']" />
<xsl:apply-templates select="/root/c_features/feature[@id='62']" />
<xsl:apply-templates select="/root/c_features/feature[@id='52']" />

<!-- <xsl:call-template name="rssTicker">
<xsl:with-param name="url">http://www.peacelink.it/feeds/sanlibero.rss</xsl:with-param>
<xsl:with-param name="title">La Catena di San Libero</xsl:with-param>
</xsl:call-template> -->

</xsl:template>


<!-- ###############################
     BOTTOM BAR CASABLANCA
     ############################### -->

<xsl:template name="bottomBarCB">

Bottom bar di Casablanca - TESTO DA DEFINIRE

<!-- 
PeaceLink C.P. 2009 - 74100 Taranto (Italy) - CCP 13403746 - 
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="/root/c_features/feature[@id='18']/items/subtopic"/>
<xsl:with-param name="name" select="/root/c_features/feature[@id='18']/@name"/>
</xsl:call-template> -->

 - Portale realizzato con <a href="http://www.phpeace.org">PhPeace <xsl:value-of select="/root/site/@phpeace"/></a>
Privacy - Accessibilita - Web standards - 


</xsl:template>

</xsl:stylesheet>
