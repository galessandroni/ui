<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!--
<xsl:variable name="show_widgets" select="/root/publish/@widgets and /root/user/group/@id=3"/>
-->
<xsl:variable name="show_widgets" select="false()"/>

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
<xsl:if test="/root/publish/@global=1 and /root/publish/@id_type=0 and $show_widgets=true()">
<link type="text/css" rel="stylesheet" href="{$css_url}/0/custom_6.css{/root/publish/@css_version}" media="screen"/>
</xsl:if>
<xsl:call-template name="googleUniversalAnalytics">
<xsl:with-param name="ua-id" select="'UA-27168243-1'" />
</xsl:call-template>
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
<xsl:choose>
<xsl:when test="$show_widgets=true()">
<xsl:attribute name="class">widgets-home</xsl:attribute></xsl:when>
<xsl:otherwise>
<div id="left-bar"><xsl:call-template name="leftBarPck" /></div>
<div id="right-bar"><xsl:call-template name="rightBarPck" /></div>
</xsl:otherwise>
</xsl:choose>
<div id="center"><xsl:call-template name="content" /></div>
</div>
<div id="bottom-bar"><xsl:call-template name="bottomBarPck" /></div>
</div>
</body>
</html>
</xsl:template>


<!-- ###############################
     TOP BAR PCK
     ############################### -->
<xsl:template name="topBarPck">
<div id="logo">
<a>
<xsl:attribute name="href">
<xsl:call-template name="createLinkUrl">
<xsl:with-param name="node" select="/root/site"/>
</xsl:call-template>
</xsl:attribute>
<xsl:call-template name="graphic">
<xsl:with-param name="id" select="'1'"/>
<xsl:with-param name="format" select="'gif'"/>
</xsl:call-template>
</a>
</div>
<xsl:call-template name="bannerGroup">
<xsl:with-param name="id" select="'8'"/>
</xsl:call-template>
<xsl:call-template name="bannerGroup">
<xsl:with-param name="id" select="'4'"/>
</xsl:call-template>
</xsl:template>


<!-- ###############################
TOP NAV PCK
############################### -->
<xsl:template name="topNavPck">
<h2 class="hidden">Associazione PeaceLink</h2>
<ul id="pck-links">
<li>
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="/root/c_features/feature[@id=34]/items/subtopic"/>
</xsl:call-template>
</li>
<li>
<li><a href="https://www.peacelink.it/editoriale/a/32934.html">Donazioni</a></li>
</li>
<li>
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="/root/c_features/feature[@id=71]/items/subtopic"/>
</xsl:call-template>
</li>
<li>
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="/root/c_features/feature[@id=36]/items/subtopic"/>
</xsl:call-template>
</li>
</ul>

<h2 class="hidden">I contenuti del sito</h2>
<ul id="content-links">
<xsl:for-each select="/root/c_features/feature[@id=3]/items/item[@id!=6 and @id!=10]">
<li>
<xsl:if test="position()=1 and (/root/topic/@id_group=1 or /root/topics/group/@id=1) and not(/root/topic/@id=6)"><xsl:attribute name="class">selected</xsl:attribute></xsl:if>
<xsl:if test="position()=2 and (/root/topic/@id_group=2 or /root/topics/group/@id=2)"><xsl:attribute name="class">selected</xsl:attribute></xsl:if>
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="."/>
</xsl:call-template>
</li>
</xsl:for-each>
<li>
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="/root/site/lists"/>
<xsl:with-param name="name" select="'Mailing Lists'"/>
</xsl:call-template>
</li>
<li>
<xsl:if test="$pagetype='events' and not(/root/topic)"><xsl:attribute name="class">selected</xsl:attribute></xsl:if>
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="/root/site/events"/>
<xsl:with-param name="name" select="/root/site/events/@label"/>
</xsl:call-template>
</li>
<li>
<xsl:if test="$pagetype='gallery_group' and not(/root/topic)"><xsl:attribute name="class">selected</xsl:attribute></xsl:if>
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="/root/site/galleries"/>
</xsl:call-template>
</li>
<li>
<xsl:if test="$pagetype='books' and not(/root/topic)"><xsl:attribute name="class">selected</xsl:attribute></xsl:if>
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="/root/site/books"/>
<xsl:with-param name="name" select="/root/labels/label[@word='books']/@tr"/>
</xsl:call-template>
</li>
<li>
<xsl:if test="/root/topic/@id=6"><xsl:attribute name="class">selected</xsl:attribute></xsl:if>
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="/root/c_features/feature[@id=9]/items/topic_full/topic"/>
</xsl:call-template>
</li>
<li>
<xsl:if test="$pagetype='map' and not(/root/topic) and /root/publish/@id=0"><xsl:attribute name="class">selected</xsl:attribute></xsl:if>
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="/root/site/map"/>
<xsl:with-param name="name" select="/root/site/map/@label"/>
</xsl:call-template>
</li>
<li>
<xsl:if test="$pagetype='feeds'"><xsl:attribute name="class">selected</xsl:attribute></xsl:if>
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="/root/site/feeds"/>
<xsl:with-param name="name" select="'RSS'"/>
</xsl:call-template>
</li>
</ul>
<div id="search-bar">
<xsl:if test="$pagetype!='error404'">
<xsl:call-template name="userInfo"/>
</xsl:if>
</div>
</xsl:template>


<!-- ###############################
     EDITORIAL PCK
     ############################### -->
<xsl:template name="editorialPck">
<div class="pckbox">
<xsl:apply-templates select="/root/c_features/feature[@id='13']"/>
</div>
</xsl:template>

<!-- ###############################
     EDITORIALE ALTRO PCK
     ############################### -->
<xsl:template name="editorialeAltroPck">
<div class="pckbox">
<xsl:apply-templates select="/root/c_features/feature[@id='37']"/>
</div>
</xsl:template>

<!-- ###############################
     ARTICOLO IN EVIDENZA
     ############################### -->
<xsl:template name="articoloinevidenzaPck">
<div class="pckbox2">
<xsl:apply-templates select="/root/features/feature[@id='185']" />
</div>
</xsl:template>

<!-- ###############################
     NEWS PCK
     ############################### -->
<xsl:template name="newsPck">
<div class="pckbox">
<xsl:apply-templates select="/root/c_features/feature[@id='14']"/>
</div>
</xsl:template>


<!-- ###############################
     DOSSIER PCK
     ############################### -->
<xsl:template name="dossierPck">
<div class="pckbox">
<xsl:apply-templates select="/root/c_features/feature[@id='16']"/>
</div>
</xsl:template>


<!-- ###############################
     MEDIA NEWS
     ############################### -->
<xsl:template name="giornalismi">
<div id="giornalismi" class="pckbox">
<xsl:apply-templates select="/root/features/feature[@id='123']" />
</div>
</xsl:template>

<!-- ###############################
     MAMMA.AM
     ############################### -->
<xsl:template name="mamma">
<div id="mamma" class="pckbox">
<xsl:apply-templates select="/root/features/feature[@id='129']" />
</div>
</xsl:template>

<!-- ###############################
     BOOKS PCK
     ############################### -->
<xsl:template name="booksPck">
<div class="pckbox">
</div>
</xsl:template>

<!-- ###############################
     SUPPORT PCK
     ############################### -->
<xsl:template name="supportPck">
<div class="pckbox" id="support">
<xsl:apply-templates select="/root/c_features/feature[@id='17']"/>
</div>
</xsl:template>

<!-- ###############################
     NEXT EVENTS PCK
     ############################### -->
<xsl:template name="nextEventsPck">
<xsl:if test="/root/c_features/feature[@id='7']/items">
<div class="pckbox2">
<xsl:apply-templates select="/root/c_features/feature[@id='7']"/>
</div>
</xsl:if>
</xsl:template>


<!-- ###############################
     GALLERIE
     ############################### -->
<xsl:template name="gallerie">
<div class="pckbox2" id="gallerie">
<h3 class="feature">
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="/root/site/galleries"/>
<xsl:with-param name="name" select="'Gallerie Fotografiche'"/>
</xsl:call-template>
</h3>
<xsl:call-template name="bannerGallery">
<xsl:with-param name="id_group" select="1"/>
</xsl:call-template>
</div>
</xsl:template>


<!-- ###############################
     VIGNETTE
     ############################### -->

<!-- <xsl:template name="vignette">
<div class="pckbox2" id="vignette">
<xsl:apply-templates select="/root/features/feature[@id='127']" />
</div>
</xsl:template> -->

 <xsl:template name="vignette">
<div class="pckbox2" id="vignette">
<h3 class="feature">Vignette</h3>
<xsl:call-template name="galleryImage">
<xsl:with-param name="i" select="/root/c_features/feature[@id=19]/items/item"/>
</xsl:call-template>
</div>
</xsl:template>

<!-- ###############################
     FACEBOOK
     ############################### -->

<xsl:template name="facebook">
<div class="pckbox2" id="facebook">
<xsl:apply-templates select="/root/features/feature[@id='152']" />
</div>
</xsl:template>


<!-- ###############################
     PEACELINK GAZA FACEBOOK PAGE
     ############################### -->

<xsl:template name="pckGaza">
<div id="pck-gaza">
<iframe src="//www.facebook.com/plugins/likebox.php?href=https%3A%2F%2Fwww.facebook.com%2Fpeacelinkgaza&amp;width=315&amp;height=495&amp;colorscheme=light&amp;show_faces=false&amp;header=false&amp;stream=true&amp;show_border=true" scrolling="no" frameborder="0" style="border:none; overflow:hidden; width:315px; height:495px;" allowTransparency="true"></iframe>
</div>
</xsl:template>



<!-- ###############################
     LEFT BAR PCK
     ############################### -->
<xsl:template name="leftBarPck">
<xsl:choose>
<xsl:when test="/root/topic">
<xsl:call-template name="navigationMenu"/>
<xsl:call-template name="mailingListPck"/>
<xsl:call-template name="leftBottom"/>
<xsl:call-template name="supportPck"/>
</xsl:when>
<xsl:when test="$pagetype='gallery_group' ">
<xsl:call-template name="leftBar"/>
</xsl:when>
<xsl:when test="$pagetype='user' ">
<xsl:call-template name="leftBar"/>
<xsl:call-template name="supportPck"/>
<xsl:call-template name="newsPck"/>
<div class="pckbox">
<xsl:call-template name="randomQuote"/>
</div>
</xsl:when>
<xsl:otherwise>
<!--
<xsl:call-template name="pckGaza"/>
-->
<xsl:call-template name="editorialPck"/>
<div class="pckbox">
<xsl:apply-templates select="/root/c_features/feature[@id='189']" />
</div>
<xsl:call-template name="pckYoutube"/>
<!-- <xsl:call-template name="pckLive"/> -->
<xsl:call-template name="articoloinevidenzaPck"/>
<xsl:call-template name="newsPck"/>
<xsl:call-template name="supportPck"/>
<xsl:call-template name="vignette"/>
<xsl:call-template name="dossierPck"/>
<!--
<xsl:call-template name="booksPck"/>
-->
<div class="pckbox">
<xsl:call-template name="randomQuote"/>
</div>
</xsl:otherwise>
</xsl:choose>
</xsl:template>


<!-- ###############################
     LEFT BOTTOM
     ############################### -->
<xsl:template name="leftBottom">
</xsl:template>


<!-- ###############################
      PEACELINK LIVE
      ############################### -->
<xsl:template name="pckLive">
<div class="pckbox">
<iframe width="313" height="202" src="https://cdn.livestream.com/embed/peacelinkonair?layout=4&amp;color=0x000000&amp;autoPlay=false&amp;mute=false&amp;iconColorOver=0xe7e7e7&amp;iconColor=0xcccccc&amp;allowchat=true&amp;height=202&amp;width=313" style="border:0;outline:0" frameborder="0" scrolling="no"></iframe>
</div>
</xsl:template>


<!-- ###############################
      PEACELINK YOUTUBE
      ############################### -->
<xsl:template name="pckYoutube">
<div class="pckbox">
<h3 class="feature"><a href="https://www.youtube.com/user/peacelinkvideo" title="Canale YouTube di PeaceLink">Canale YouTube di PeaceLink</a></h3>
<iframe src="https://www.youtube.com/embed/?listType=user_uploads&amp;list=peacelinkvideo" width="315" height="262"></iframe></div>
</xsl:template>


<!-- ###############################
     MAILING LIST PCK
     ############################### -->
<xsl:template name="mailingListPck">
<xsl:if test="/root/topic/lists/list">
<div id="mailing-list" class="pckbox">
<h3>Mailing-list <xsl:value-of select="/root/topic/lists/list/@name"/></h3>
<form action="{/root/site/@base}/liste/actions.php" method="post" id="list-mini-ops" accept-charset="UTF-8">
<input type="hidden" name="from" value="list"/>
<input type="hidden" name="id_list" value="{/root/topic/lists/list/@id}"/>
<input type="hidden" name="id_topic" value="{/root/topic/@id}"/>
<label for="email" class="required">email</label><input type="text" id="email" name="email" onFocus='this.value=""' value="email"/>
<input type="submit" name="action_subscribe" value="Iscrizione"/>
</form>
<div>
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="/root/topic/lists/list"/>
<xsl:with-param name="name" select="'&lt; Altre opzioni e info &gt;'"/>
</xsl:call-template>
</div>
</div>
</xsl:if>
</xsl:template>


<!-- ###############################
     RIGHT BAR PCK
     ############################### -->
<xsl:template name="rightBarPck">
<xsl:call-template name="searchPck"/>
<xsl:call-template name="facebookLike">
  <xsl:with-param name="action">recommend</xsl:with-param>
  <xsl:with-param name="layout">button_count</xsl:with-param>
</xsl:call-template>
<xsl:choose>
  <xsl:when test="$pagetype='events'">
    <xsl:call-template name="rightBarCalendar"/>
  </xsl:when>
  <xsl:otherwise>
    <!-- RIGHT BAR generica -->
    <xsl:if test="$pagetype!='error404'">

      <xsl:if test="not(/root/topic) and /root/c_features/feature[@id=125]/items/item">
        <div id="ricorrenze" class="pckbox">
          <h3 class="feature">
            <xsl:value-of select="/root/site/events/@today"/>
          </h3>
          <xsl:apply-templates select="/root/c_features/feature[@id=125]" />
        </div>
      </xsl:if>
      <xsl:call-template name="geoSearchPck"/>
      <xsl:call-template name="tickerPck"/>
      <xsl:call-template name="editorialeAltroPck"/>
      <xsl:call-template name="nextEventsPck"/>

      <xsl:if test="/root/features/feature[@id='6']">
        <div id="tematiche" class="pckbox2">
          <xsl:apply-templates select="/root/features/feature[@id='6']" />
        </div>
        <xsl:call-template name="bannerGroup">
          <xsl:with-param name="id" select="'19'"/>
        </xsl:call-template>
      </xsl:if>

      <xsl:if test="not(/root/topic)">
        <xsl:call-template name="libroTemp"/>
      </xsl:if>
      <xsl:call-template name="gallerie"/>
      <xsl:call-template name="share"/>

    </xsl:if>
    <!--
    <xsl:call-template name="listsPck"/>
    <xsl:call-template name="linksPck"/>
    -->
  </xsl:otherwise>
</xsl:choose>
</xsl:template>


<!-- ###############################
     LIBRO TEMP
     ############################### -->
<xsl:template name="libroTemp">
<div class="pckbox2" id="libri">
<h3 class="feature">LIBRI</h3>
<xsl:call-template name="bannerGallery">
<xsl:with-param name="id_image" select="10593"/>
</xsl:call-template>
</div>
</xsl:template>



<!-- ###############################
     RSS TICKER PCK
     ############################### -->
<xsl:template name="tickerPck">
<xsl:choose>
<xsl:when test="/root/topic/lists/list/@feed!=''">
<xsl:call-template name="rssTicker">
<xsl:with-param name="url" select="/root/topic/lists/list/@feed"/>
<xsl:with-param name="title" select="concat('Lista ',/root/topic/lists/list/@name)"/>
<xsl:with-param name="title_link" select="/root/topic/lists/list/@url"/>
</xsl:call-template>
</xsl:when>
<xsl:otherwise>
<xsl:call-template name="rssTicker">
<xsl:with-param name="url">https://lists.peacelink.it/feed/news/news.rss</xsl:with-param>
<xsl:with-param name="title">PeaceLink News</xsl:with-param>
<xsl:with-param name="title_link">https://www.peacelink.it/liste/index.php?id=15</xsl:with-param>
</xsl:call-template>
</xsl:otherwise>
</xsl:choose>
</xsl:template>
	  
	  
	  

<!-- ###############################
     SEARCH PCK
    ############################### -->
<xsl:template name="searchPck">
<form method="get" id="search-form-pck" accept-charset="{/root/site/@encoding}">
<xsl:attribute name="action">
<xsl:call-template name="createLinkUrl">
<xsl:with-param name="node" select="/root/site/search"/>
</xsl:call-template>
</xsl:attribute>
<fieldset>
<legend><xsl:value-of select="/root/site/search/@label"/></legend>
<xsl:if test="$preview='1'"><input type="hidden" name="id_type" value="18"/></xsl:if>
<xsl:if test="/root/topic">
in <select name="id_topic">
<option value="{/root/topic/@id}"><xsl:value-of select="/root/topic/@name"/></option>
<option value="0">peacelink.it</option>
</select>
</xsl:if>
<input type="text" name="q" value="{/root/search/@q}" class="search-input"/>
<input type="submit" value="{/root/site/search/@name}" class="search-submit"/>
</fieldset>
</form>
</xsl:template>
	  
	  
<!-- ###############################
     GEO SEARCH PCK
    ############################### -->
<xsl:template name="geoSearchPck">
<script type="text/javascript"><![CDATA[
var geoimgs = new Array(3); 
geoimgs[0] = "https://www.peacelink.it/images/235.gif"; 
geoimgs[1] = "https://www.peacelink.it/images/236.gif"; 
geoimgs[2] = "https://www.peacelink.it/images/237.gif"; 
geoimgs[3] = "https://www.peacelink.it/images/238.gif"; 
geoimgs[4] = "https://www.peacelink.it/images/239.gif"; 
geoimgs[5] = "https://www.peacelink.it/images/240.gif"; 
geoimgs[6] = "https://www.peacelink.it/images/241.gif"; 

function preload() {
   var tmp = null; 
   for (var j = 0; j < geoimgs.length; j++) { 
     tmp = geoimgs[j]; 
     geoimgs[j] = new Image(); 
     geoimgs[j].src = tmp; 
   }
}

void(preload());

function geoImgSwap(swap) {
	document.getElementById('geomap').src = geoimgs[swap].src; 
}
]]></script>
<div id="geo-search">
<h3>
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="/root/site/geosearch"/>
</xsl:call-template>
</h3>
<img id="geomap" src="https://www.peacelink.it/images/235.gif" usemap="#worldpeters" style="background: url(https://www.peacelink.it/images/235.gif);" alt="The world according to Peters"/>
<map name="worldpeters">
<area shape="poly" alt="Asia / Oceania" href="https://www.peacelink.it/cerca/geo.php?id=550" title="Asia / Oceania" coords="93,0,169,3,140,36,165,88,155,96,126,82,110,31,103,18,93,18" onmouseover="geoImgSwap(2);" onmouseout="geoImgSwap(0);"/>
<area shape="poly" alt="Medio Oriente" href="https://www.peacelink.it/cerca/geo.php?id=280" title="Medio Oriente" coords="93,18,103,18,111,33,101,43,93,22" onmouseover="geoImgSwap(4);" onmouseout="geoImgSwap(0);" />
<area shape="poly" alt="Europa" href="https://www.peacelink.it/cerca/geo.php?id=300" title="Europa" coords="76,0,66,7,72,9,74,22,93,22,93,0" onmouseover="geoImgSwap(3);" onmouseout="geoImgSwap(0);" />
<area shape="poly" alt="Africa" href="https://www.peacelink.it/cerca/geo.php?id=70" title="Africa" coords="68,22,93,22,101,43,106,43,102,86,80,85" onmouseover="geoImgSwap(1);" onmouseout="geoImgSwap(0);" />
<area shape="rect" alt="America Latina" href="https://www.peacelink.it/cerca/geo.php?id=473" title="America Latina" coords="29,33,64,98" onmouseover="geoImgSwap(6);" onmouseout="geoImgSwap(0);" />
<area shape="poly" alt="Nord America" href="https://www.peacelink.it/cerca/geo.php?id=3861" title="Nord America" coords="1,0,46,0,60,16,43,33,23,33,1,9" onmouseover="geoImgSwap(5);" onmouseout="geoImgSwap(0);" />
</map>
</div>

<xsl:if test="/root/geosearch/geokeyword">
<script type="text/javascript">
<xsl:if test="/root/geosearch/geokeyword/path/geokeyword[position()=2]/@id=550">
geoImgSwap(2);
</xsl:if>
<xsl:if test="/root/geosearch/geokeyword/path/geokeyword[position()=2]/@id=280">
geoImgSwap(4);
</xsl:if>
<xsl:if test="/root/geosearch/geokeyword/path/geokeyword[position()=2]/@id=300">
geoImgSwap(3);
</xsl:if>
<xsl:if test="/root/geosearch/geokeyword/path/geokeyword[position()=2]/@id=70">
geoImgSwap(1);
</xsl:if>
<xsl:if test="/root/geosearch/geokeyword/path/geokeyword[position()=2]/@id=473">
geoImgSwap(6);
</xsl:if>
<xsl:if test="/root/geosearch/geokeyword/path/geokeyword[position()=2]/@id=3861">
geoImgSwap(5);
</xsl:if>
</script>
</xsl:if>

</xsl:template>
	  

<!-- ###############################
     BOTTOM BAR PCK
     ############################### -->
<xsl:template name="bottomBarPck">
PeaceLink C.P. 2009 - 74100 Taranto (Italy) - CCP 13403746 -  Sito realizzato con <a href="https://www.phpeace.org">PhPeace <xsl:value-of select="/root/site/@phpeace"/></a>
 - <xsl:call-template name="createLink">
<xsl:with-param name="node" select="/root/c_features/feature[@id='18']/items/subtopic"/>
<xsl:with-param name="name" select="/root/c_features/feature[@id='18']/@name"/>
</xsl:call-template>
- <a href="https://www.peacelink.it/peacelink/a/41776.html">Informativa sui cookies</a>
- <a href="mailto:associazione.peacelink@pec.it" title="Posta Elettronica Certificata">Posta elettronica certificata (PEC)</a>
<xsl:if test="$preview=false()">
<script type="text/javascript" src="/cookie-bar/cookiebar-latest.min.js?forceLang=it&amp;tracking=1&amp;thirdparty=1&amp;noGeoIp=1&amp;remember=90&amp;scrolling=1&amp;privacyPage=https%3A%2F%2Fwww.peacelink.it%2Fpeacelink%2Fa%2F44843.html"></script>
</xsl:if>
</xsl:template>


<!-- ###############################
PAYPAL PCK
############################### -->
<xsl:template name="paypalPck">
<xsl:param name="amount"/>
<xsl:param name="description" select="'Donazioni per Associazione PeaceLink'"/>
<div id="donation">
<form name="_xclick" action="https://www.paypal.com/cgi-bin/webscr" method="post">
<fieldset>
<input type="hidden" name="cmd" value="_xclick"/>
<input type="hidden" name="business" value="donazioni@peacelink.it"/>
<input type="hidden" name="item_name" value="{$description}"/>
<input type="hidden" name="currency_code" value="EUR"/>
<input type="hidden" name="lc" value="IT"/>
<xsl:if test="$amount!=''">
<input type="hidden" name="amount" value="{$amount}"/>
</xsl:if>
<input type="image" src="https://www.paypal.com/en_US/i/btn/x-click-butcc-donate.gif" name="submit" alt="Donazioni con PayPal. un sistema rapido, gratuito e sicuro."/>
</fieldset>
</form>
</div>
</xsl:template>


<!-- ###############################
     CSS CUSTOM
     ############################### -->
<xsl:template name="cssCustom">
<xsl:comment><![CDATA[[if lt IE 8]><link rel="stylesheet" type="text/css" media="screen" href="]]><xsl:value-of select="$css_url"/><![CDATA[/0/custom_4.css" /><![endif]]]></xsl:comment>
<xsl:comment><![CDATA[[if lt IE 7]><link rel="stylesheet" type="text/css" media="screen" href="]]><xsl:value-of select="$css_url"/><![CDATA[/0/custom_1.css" /><![endif]]]></xsl:comment>
</xsl:template>


<!-- ###############################
 JAVASCRIPT CUSTOM
 ############################### -->
<xsl:template name="javascriptCustom">
</xsl:template>


</xsl:stylesheet>