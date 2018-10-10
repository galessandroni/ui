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
      <xsl:call-template name="googleUniversalAnalytics">
        <xsl:with-param name="ua-id" select="'UA-27168243-1'" />
      </xsl:call-template>
      <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous"/>
    </head>
    <body class="{/root/publish/@type}" id="id{/root/publish/@id}">
      <xsl:if test="/root/preview"><xsl:call-template name="previewToolbar"/></xsl:if>
      <div id="main-wrap" >
        <div id="top-nav"><xsl:call-template name="topNavPck"/></div>
        <div id="main-global">
          <xsl:if test="/root/topic">
            <xsl:attribute name="id">main</xsl:attribute>
            <div id="left-bar"><xsl:call-template name="leftBarPck" /></div>
          </xsl:if>
          <div id="content"><xsl:call-template name="content" /></div>
          <div id="right-bar"><xsl:call-template name="rightBarPck" /></div>
        </div>
        <div id="bottom-bar"><xsl:call-template name="bottomBarPck" /></div>
      </div>
    </body>
  </html>
</xsl:template>


<!-- ###############################
TOP NAV PCK
############################### -->
<xsl:template name="topNavPck">
  <a id="logo">
    <xsl:attribute name="href">
      <xsl:call-template name="createLinkUrl">
        <xsl:with-param name="node" select="/root/site"/>
      </xsl:call-template>
    </xsl:attribute>
  </a>

  <ul id="pck-links">
    <li>
      <xsl:call-template name="createLink">
        <xsl:with-param name="node" select="/root/c_features/feature[@id='8']/items/topic_full/topic"/>
        <xsl:with-param name="name" select="'Chi siamo'"/>
      </xsl:call-template>
    </li>
    <li>
      <xsl:call-template name="createLink">
        <xsl:with-param name="node" select="/root/c_features/feature[@id='8']/items/topic_full/menu/subtopics//subtopic[@id='911']"/>
        <xsl:with-param name="name" select="'Contattaci'"/>
      </xsl:call-template>
    </li>
    <li>
      <xsl:call-template name="createLink">
        <xsl:with-param name="node" select="/root/c_features/feature[@id='8']/items/topic_full/menu/subtopics//subtopic[@id='2817']"/>
        <xsl:with-param name="name" select="'Sostienici'"/>
      </xsl:call-template>
    </li>
    <li>
      <xsl:call-template name="createLink">
        <xsl:with-param name="node" select="/root/c_features/feature[@id='8']/items/topic_full/menu/subtopics//subtopic[@id='3414']"/>
        <xsl:with-param name="name" select="'Iscriviti'"/>
      </xsl:call-template>
    </li>
    <li>
      <xsl:call-template name="createLink">
        <xsl:with-param name="node" select="/root/c_features/feature[@id='8']/items/topic_full/menu/subtopics//subtopic[@id='1162']"/>
        <xsl:with-param name="name" select="'Partecipa'"/>
      </xsl:call-template>
    </li>
  </ul>
  <xsl:call-template name="bannerGroup">
    <xsl:with-param name="id" select="'35'"/>
  </xsl:call-template>

  <ul id="content-links">
    <xsl:for-each select="/root/c_features/feature[@id=3]/items/item[@id!=6]">
      <li>
        <xsl:if test="position()=1 and (/root/topic/@id_group=1 or /root/topics/group/@id=1) and not(/root/topic/@id=6)"><xsl:attribute name="class">selected</xsl:attribute></xsl:if>
        <xsl:if test="position()=2 and (/root/topic/@id_group=2 or /root/topics/group/@id=2)"><xsl:attribute name="class">selected</xsl:attribute></xsl:if>
        <xsl:call-template name="createLink">
          <xsl:with-param name="node" select="."/>
        </xsl:call-template>
      </li>
    </xsl:for-each>
    <li>
      <xsl:if test="$pagetype='events' and not(/root/topic)"><xsl:attribute name="class">selected</xsl:attribute></xsl:if>
      <xsl:call-template name="createLink">
        <xsl:with-param name="node" select="/root/site/events"/>
        <xsl:with-param name="name" select="/root/site/events/@label"/>
      </xsl:call-template>
    </li>
    <li><a href="#">Cerca</a></li>
    <li><xsl:call-template name="userInfo"/></li>
  </ul>
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
     FACEBOOK
     ############################### -->

<xsl:template name="facebook">
<div class="pckbox2" id="facebook">
<xsl:apply-templates select="/root/features/feature[@id='152']" />
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
</xsl:when>
<xsl:when test="$pagetype='gallery_group' ">
<xsl:call-template name="leftBar"/>
</xsl:when>
<xsl:when test="$pagetype='user' ">
<xsl:call-template name="leftBar"/>
<xsl:call-template name="newsPck"/>
<div class="pckbox">
<xsl:call-template name="randomQuote"/>
</div>
</xsl:when>
<xsl:otherwise>
<xsl:call-template name="editorialPck"/>
<div class="pckbox">
<xsl:apply-templates select="/root/c_features/feature[@id='189']" />
</div>
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
      PEACELINK YOUTUBE
      ############################### -->
<xsl:template name="pckYoutube">
  <div class="pckbox">
    <h3><a href="https://www.youtube.com/user/peacelinkvideo" title="Canale YouTube di PeaceLink">Canale YouTube di PeaceLink</a></h3>
    <iframe src="https://www.youtube.com/embed/?listType=user_uploads&amp;list=peacelinkvideo" width="400" height="332"></iframe>
  </div>
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
  <xsl:call-template name="fotonotizia"/>
  <xsl:call-template name="pckYoutube"/>
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
      <xsl:call-template name="tickerPck"/>
      <xsl:call-template name="nextEventsPck"/>

    </xsl:if>
  </xsl:otherwise>
</xsl:choose>
</xsl:template>


<!-- ###############################
     FOTONOTIZIA
     ############################### -->
<xsl:template name="fotonotizia">
  <xsl:if test="/root/c_features/feature[@id='10']">
    <div id="fotonotizia" class="pckbox">
      <xsl:call-template name="galleryImage">
        <xsl:with-param name="i" select="/root/c_features/feature[@id='10']/items/item"/>
      </xsl:call-template>
      <div class="description">
        <a href="{/root/c_features/feature[@id='10']/items/item/@link}"><xsl:value-of select="/root/c_features/feature[@id='10']/items/item/@caption"/></a>
      </div>
    </div>
  </xsl:if>
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
     BOTTOM BAR PCK
     ############################### -->
<xsl:template name="bottomBarPck">
PeaceLink C.P. 2009 - 74100 Taranto (Italy) - CCP 13403746 -  Sito realizzato con <a href="https://www.phpeace.org">PhPeace <xsl:value-of select="/root/site/@phpeace"/></a>
 - <xsl:call-template name="createLink">
<xsl:with-param name="node" select="/root/c_features/feature[@id='8']/items/topic_full/menu/subtopics//subtopic[@id='2074']"/>
<xsl:with-param name="name" select="'Informativa sulla Privacy'"/>
</xsl:call-template>
- <a href="https://www.peacelink.it/peacelink/a/41776.html">Informativa sui cookies</a>
- <a href="https://www.peacelink.it/peacelink/diritto-di-replica">Diritto di replica</a>
- <a href="mailto:associazione.peacelink@pec.it" title="Posta Elettronica Certificata">Posta elettronica certificata (PEC)</a>
<xsl:if test="$preview=false()">
<script type="text/javascript" src="/cookie-bar/cookiebar-latest.min.js?forceLang=it&amp;tracking=1&amp;thirdparty=1&amp;noGeoIp=1&amp;remember=90&amp;scrolling=1&amp;privacyPage=https%3A%2F%2Fwww.peacelink.it%2Fpeacelink%2Fa%2F44843.html"></script>
</xsl:if>
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
