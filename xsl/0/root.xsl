<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

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
      <meta name="format-detection" content="telephone=no"/>
      <meta name="geo.placename" content="Taranto, IT"/>
      <meta name="geo.country" content="it"/>
      <meta name="dc.language" content="it"/>
      <meta name="application-name" content="PeaceLink"/>
      <meta name="twitter:card" content="summary" />
      <meta name="twitter:site" content="@peacelink" />
      <script type="application/ld+json">
      {
        "@context": "http://schema.org",
        "@type": "Organization",
        "address": {
          "@type": "PostalAddress",
          "addressLocality": "Taranto, Italy",
          "postalCode": "74100",
          "streetAddress": "CP 2009"
        },
        "name": "PeaceLink",
        "url": "https://www.peacelink.it",
        "logo": "<xsl:value-of select="/root/site/@cdn"/>/graphics/peacelink.png",
        "email": "mailto:info@peacelink.it",
        "image": "<xsl:value-of select="/root/site/@cdn"/>/css/i/peacelink.svg",
        "description": "Telematica per la Pace, associazione di volontariato dell'informazione che dal 1992 offre una alternativa ai grandi gruppi editoriali e televisivi.",
        "sameAs" : [
            "https://www.facebook.com/retepeacelink",
            "https://twitter.com/peacelink",
            "https://www.youtube.com/channel/UC3WwkfbNXH-TxnVFpwSAtSQ"
        ]
      }
      </script>
      <link rel="apple-touch-icon" sizes="180x180" href="/icon/apple-touch-icon.png"/>
      <link rel="icon" type="image/png" sizes="32x32" href="/icon/favicon-32x32.png"/>
      <link rel="icon" type="image/png" sizes="16x16" href="/icon/favicon-16x16.png"/>
      <link rel="manifest" href="/icon/site.webmanifest"/>
      <link rel="mask-icon" href="/icon/safari-pinned-tab.svg" color="#5bbad5"/>
      <link rel="shortcut icon" href="/icon/favicon.ico"/>
      <meta name="msapplication-TileColor" content="#da532c"/>
      <meta name="msapplication-config" content="/icon/browserconfig.xml"/>
      <meta name="theme-color" content="#ffffff"/>
      <xsl:call-template name="googleUniversalAnalytics">
        <xsl:with-param name="ua-id" select="'UA-27168243-1'" />
      </xsl:call-template>
      <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous"/>
    </head>
    <body class="{/root/publish/@type}" id="id{/root/publish/@id}">
      <div id="fb-root"></div>
      <xsl:if test="/root/preview"><xsl:call-template name="previewToolbar"/></xsl:if>
      <div id="main-wrap" >
        <div id="top-nav"><xsl:call-template name="topNavPck"/></div>
        <xsl:choose>
          <xsl:when test="/root/topic">
            <div id="main">
              <xsl:attribute name="class">
                <xsl:call-template name="mapGroups">
                  <xsl:with-param name="string" select="'group'"/>
                  <xsl:with-param name="id" select="/root/topic/@id_group"/>
                </xsl:call-template>
              </xsl:attribute>
              <div id="left-bar"><xsl:call-template name="leftBarPck" /></div>
              <div id="content"><xsl:call-template name="content" /></div>
              <div id="fotonotizia" class="pckbox">
                <xsl:call-template name="fotonotiziaTopic"/>
              </div>
              <div id="right-bar"><xsl:call-template name="rightBarPck" /></div>
            </div>
          </xsl:when>
          <xsl:otherwise>
            <div id="main-global">
              <div id="fotonotizia" class="pckbox">
                <xsl:call-template name="fotonotizia"/>
              </div>
              <div id="content"><xsl:call-template name="content" /></div>
              <div id="right-bar"><xsl:call-template name="rightBarPck" /></div>
            </div>
          </xsl:otherwise>
        </xsl:choose>
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
        <xsl:attribute name="id">
          <xsl:call-template name="mapGroups">
            <xsl:with-param name="string" select="'topic-group'"/>
            <xsl:with-param name="id" select="@id"/>
          </xsl:call-template>
        </xsl:attribute>
        <xsl:if test="(/root/topic/@id_group=@id or /root/topics/group/@id=@id)"><xsl:attribute name="class">selected</xsl:attribute></xsl:if>
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
    <li class="search"><a href="#">Cerca</a></li>
    <li class="user"><xsl:call-template name="userInfo"/></li>
  </ul>
</xsl:template>


<!-- ###############################
     LEFT BAR PCK
     ############################### -->
<xsl:template name="leftBarPck">
  <xsl:choose>
    <xsl:when test="/root/topic">
      <xsl:call-template name="navigationMenu"/>
      <xsl:call-template name="leftBottom"/>
      <xsl:if test="/root/topic/lists/list">
        <xsl:call-template name="pckList">
          <xsl:with-param name="url" select="/root/topic/lists/list/@feed"/>
          <xsl:with-param name="archive" select="/root/topic/lists/list/@archive"/>
          <xsl:with-param name="name" select="concat('Lista ',/root/topic/lists/list/@name)"/>
          <xsl:with-param name="id_list" select="/root/topic/lists/list/@id"/>
          <xsl:with-param name="id_topic" select="/root/topic/@id"/>
        </xsl:call-template>
      </xsl:if>
      <xsl:if test="/root/topic/@home_type!='3' or $pagetype!='topic_home'">
        <xsl:call-template name="topicLatest"/>
      </xsl:if>
    </xsl:when>
    <xsl:when test="$pagetype='gallery_group' ">
      <xsl:call-template name="leftBar"/>
    </xsl:when>
    <xsl:when test="$pagetype='user' ">
      <xsl:call-template name="leftBar"/>
      <div class="pckbox">
        <xsl:call-template name="randomQuote"/>
      </div>
    </xsl:when>
  </xsl:choose>
</xsl:template>


<!-- ###############################
     RIGHT BAR PCK
     ############################### -->
<xsl:template name="rightBarPck">
  <xsl:choose>
    <xsl:when test="/root/topic">
      <xsl:call-template name="pckTwitter"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:choose>
        <xsl:when test="$pagetype='events'">
          <xsl:call-template name="rightBarCalendar"/>
        </xsl:when>
        <xsl:otherwise>
          <!-- RIGHT BAR generica -->
          <xsl:call-template name="pckTwitter"/>
          <xsl:call-template name="pckFacebook"/>
          <xsl:if test="$pagetype!='error404'">
            <xsl:call-template name="nextEventsPck"/>
          </xsl:if>
          <xsl:call-template name="pckList">
            <xsl:with-param name="url" select="'https://lists.peacelink.it/feed/news/news.rss'"/>
            <xsl:with-param name="archive" select="'https://lists.peacelink.it/news/'"/>
            <xsl:with-param name="name" select="'PeaceLink News'"/>
            <xsl:with-param name="id_list" select="'15'"/>
          </xsl:call-template>
        </xsl:otherwise>
      </xsl:choose>
      <!--
      <xsl:call-template name="pckYoutube"/>
      -->
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>


<!-- ###############################
     TWITTER
     ############################### -->
<xsl:template name="pckTwitter">
  <div id="pck-twitter"><a class="twitter-timeline" data-lang="it" data-height="400" data-theme="light" href="https://twitter.com/peacelink?ref_src=twsrc%5Etfw">Tweets by PeaceLink</a> <script async="true" src="https://platform.twitter.com/widgets.js" charset="utf-8"></script></div>
</xsl:template>


<!-- ###############################
     FACEBOOK
     ############################### -->
<xsl:template name="pckFacebook">
  <div id="pck-facebook" class="pckbox">
    <div class="fb-page" data-href="https://www.facebook.com/retepeacelink/" data-tabs="timeline" data-width="500" data-height="500" data-small-header="true"  data-show-facepile="true">
      <blockquote cite="https://www.facebook.com/retepeacelink/" class="fb-xfbml-parse-ignore"><a href="https://www.facebook.com/retepeacelink/">Pagina Facebook di PeaceLink in caricamento...</a></blockquote>
    </div>
  </div>
</xsl:template>


<!-- ###############################
     NEXT EVENTS PCK
     ############################### -->
<xsl:template name="nextEventsPck">
  <xsl:if test="/root/c_features/feature[@id='7']/items">
    <div id="next-events" class="pckbox">
      <xsl:apply-templates select="/root/c_features/feature[@id='7']">
        <xsl:with-param name="title_class" select="'icon'"/>
      </xsl:apply-templates>
    </div>
  </xsl:if>
</xsl:template>


<!-- ###############################
     FOTONOTIZIA
     ############################### -->
<xsl:template name="fotonotizia">
  <xsl:param name="i" select="/root/c_features/feature[@id='10']/items/item"/>
  <xsl:variable name="src">
    <xsl:call-template name="createLinkUrl">
      <xsl:with-param name="node" select="$i/src"/>
      <xsl:with-param name="cdn" select="/root/site/@cdn!=''"/>
    </xsl:call-template>
  </xsl:variable>
  <xsl:variable name="link">
    <xsl:choose>
      <xsl:when test="$i/@link!=''"><xsl:value-of select="$i/@link"/></xsl:when>
      <xsl:otherwise><xsl:value-of select="/root/site/@url"/></xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <a href="{$link}">
    <img alt="{$i/@caption}" src="{$src}" />
  </a>
  <div class="description">
    <a href="{$link}"><xsl:value-of select="$i/@caption"/></a>
  </div>
</xsl:template>


<!-- ###############################
     FOTONOTIZIA TOPIC
     ############################### -->
<xsl:template name="fotonotiziaTopic">
  <div id="fotonotizia" class="pckbox">
    <script type="text/javascript">
  $(function() {
    htmlLoad('fotonotizia','/js/feature.php?id=10&amp;transform',true)
  });
    </script>
  </div>
</xsl:template>


<!-- ###############################
     mapGroups
     ############################### -->
<xsl:template name="mapGroups">
  <xsl:param name="string"/>
  <xsl:param name="id"/>
  <xsl:param name="group">
    <xsl:choose>
      <xsl:when test="$id='1'">pace</xsl:when>
      <xsl:when test="$id='3'">cult</xsl:when>
      <xsl:when test="$id='11'">eco</xsl:when>
      <xsl:when test="$id='12'">sol</xsl:when>
      <xsl:when test="$id='13'">citt</xsl:when>
      <xsl:when test="$id='6'">pck</xsl:when>
      <xsl:when test="$id='2'">osp</xsl:when>
    </xsl:choose>
  </xsl:param>
  <xsl:value-of select="concat($string,'-',$group)"/>
</xsl:template>


<!-- ###############################
     PCK LIST RSS TICKER
     ############################### -->
<xsl:template name="pckList">
  <xsl:param name="url"/>
  <xsl:param name="archive"/>
  <xsl:param name="name"/>
  <xsl:param name="id_list"/>
  <xsl:param name="id_topic" select="'0'"/>
  <div id="mailing-list" class="pckbox">
    <h3><a href="{$archive}" class="icon"><xsl:value-of select="$name"/></a></h3>
    <form action="{/root/site/@base}/liste/actions.php" method="post" id="list-mini-ops" accept-charset="UTF-8">
      <input type="hidden" name="from" value="list"/>
      <input type="hidden" name="id_list" value="{$id_list}"/>
      <input type="hidden" name="id_topic" value="{$id_topic}"/>
      <input type="text" id="email" name="email" placeholder="email"/>
      <input type="submit" name="action_subscribe" value="Iscrizione"/>
    </form>
    <xsl:if test="$url!=''">
      <h4><a href="{$archive}">Archivio pubblico</a></h4>
      <xsl:call-template name="rssTicker">
        <xsl:with-param name="url" select="$url"/>
      </xsl:call-template>
    </xsl:if>
  </div>
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
  PeaceLink C.P. 2009 - 74100 Taranto (Italy) - CCP 13403746 - Sito realizzato con 
  <a href="https://www.phpeace.org">PhPeace <xsl:value-of select="/root/site/@phpeace"/></a> - 
  <xsl:call-template name="createLink">
    <xsl:with-param name="node" select="/root/c_features/feature[@id='8']/items/topic_full/menu/subtopics//subtopic[@id='2074']"/>
  <xsl:with-param name="name" select="'Informativa sulla Privacy'"/>
  </xsl:call-template>
  - 
  <a href="https://www.peacelink.it/peacelink/a/41776.html">Informativa sui cookies</a> - 
  <a href="https://www.peacelink.it/peacelink/diritto-di-replica">Diritto di replica</a> - 
  <a href="mailto:associazione.peacelink@pec.it" title="Posta Elettronica Certificata">Posta elettronica certificata (PEC)</a>
  <xsl:if test="$preview=false()">
    <script type="text/javascript" src="/cookie-bar/cookiebar-latest.min.js?forceLang=it&amp;tracking=1&amp;thirdparty=1&amp;noGeoIp=1&amp;remember=90&amp;scrolling=1&amp;privacyPage=https%3A%2F%2Fwww.peacelink.it%2Fpeacelink%2Fa%2F44843.html"></script>
  </xsl:if>
</xsl:template>




<!-- ARCHIVIO -->

<!-- ###############################
     RICORRENZE
     ############################### -->
<xsl:template name="ricorrenze">
  <xsl:if test="not(/root/topic) and /root/c_features/feature[@id=125]/items/item">
    <div id="ricorrenze" class="pckbox">
      <h3 class="feature">
        <xsl:value-of select="/root/site/events/@today"/>
      </h3>
      <xsl:apply-templates select="/root/c_features/feature[@id=125]" />
    </div>
  </xsl:if>
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
      PEACELINK YOUTUBE
      ############################### -->
<xsl:template name="pckYoutube">
  <div class="pckbox" id="youtube">
    <h3><a href="https://www.youtube.com/user/peacelinkvideo" title="Canale YouTube di PeaceLink">Canale YouTube di PeaceLink</a></h3>
    <iframe src="https://www.youtube.com/embed/?listType=user_uploads&amp;list=peacelinkvideo" width="400" height="332"></iframe>
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
     NEWS PCK
     ############################### -->
<xsl:template name="newsPck">
  <div class="pckbox">
    <xsl:apply-templates select="/root/c_features/feature[@id='14']"/>
  </div>
</xsl:template>


<!-- PLACEHOLDERS -->

<!-- ###############################
     CSS CUSTOM
     ############################### -->
<xsl:template name="cssCustom">
</xsl:template>


<!-- ###############################
 JAVASCRIPT CUSTOM
 ############################### -->
<xsl:template name="javascriptCustom">
</xsl:template>


<!-- ###############################
     LEFT BOTTOM
     ############################### -->
<xsl:template name="leftBottom">
</xsl:template>


</xsl:stylesheet>
