<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:variable name="menudepth" select="/root/menu/@depth"/>
<xsl:variable name="preview" select="boolean(/root/publish/@preview='1')"/>
<xsl:variable name="async_js" select="not(boolean(/root/topic/@domain and /root/publish/@static='1' and /root/publish/@rewrite='0'))"/>
<xsl:variable name="pagetype" select="/root/publish/@type"/>
<xsl:variable name="subtype" select="/root/publish/@subtype"/>
<xsl:variable name="id_type" select="/root/publish/@id_type"/>

<xsl:key name="graphic" match="/root/graphics/graphic" use="@id"/>
<xsl:key name="label" match="/root/labels/label" use="@word"/>

<xsl:variable name="assets_url" select="/root/site/@assets_domain"/>
<xsl:variable name="css_url" select="concat($assets_url,'/css/0/css')"/>
<xsl:variable name="css_version" select="/root/publish/@css_version"/>
<xsl:variable name="js_version" select="/root/publish/@js_version"/>

<xsl:include href="root.xsl" />
<xsl:include href="tools.xsl" />

<xsl:variable name="breadcrumb_separator"><xsl:text> > </xsl:text></xsl:variable>

<xsl:variable name="current_lang">
<xsl:choose>
<xsl:when test="/root/topic/@lang!=/root/site/@lang">
<xsl:value-of select="/root/topic/@lang"/>
</xsl:when>
<xsl:otherwise>
<xsl:value-of select="/root/site/@lang"/>
</xsl:otherwise>
</xsl:choose>
</xsl:variable>

<xsl:variable name="current_site_name">
<xsl:choose>
<xsl:when test="/root/topic">
<xsl:value-of select="/root/topic/@name"/>
</xsl:when>
<xsl:otherwise>
<xsl:value-of select="/root/site/@title"/>
</xsl:otherwise>
</xsl:choose>
</xsl:variable>

<!-- ###############################
     ROOT MATCH
     ############################### -->
<xsl:template match="/">
<xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;</xsl:text>
<xsl:call-template name="root"/>
</xsl:template>


<!-- ###############################
     ARTICLE BOOKS
     ############################### -->
<xsl:template name="articleBooks">
<xsl:param name="node"/>
<ul class="items" id="article-books">
<xsl:apply-templates select="$node" mode="mainlist"/>
</ul>
</xsl:template>


<!-- ###############################
     ARTICLE BOX NODE
     ############################### -->
<xsl:template name="articleBoxNode">
<xsl:param name="id"/>
<xsl:param name="node"/>
<div id="abox-{$node/@id}">
<xsl:attribute name="class">article-box abox-type<xsl:value-of select="$node/@id_type"/> align<xsl:value-of select="$node/@align"/> <xsl:if test="$node/@id_width &lt; 4"> width<xsl:value-of select="$node/@id_width"/></xsl:if></xsl:attribute>
<xsl:choose>
<xsl:when test="$node/@popup='1'">
<div class="title">
<a target="_blank" onclick="open_popup(this,{$node/@z_width},{$node/@z_height}); return false" title="{$node/@title}">
<xsl:attribute name="href">
<xsl:call-template name="createLinkUrl">
<xsl:with-param name="node" select="$node"/>
</xsl:call-template>
</xsl:attribute>
<xsl:attribute name="title"><xsl:value-of select="concat($node/@title,' (',$node/@label,')')"/></xsl:attribute>
<xsl:value-of select="$node/@title"/>
</a>
</div>
</xsl:when>
<xsl:otherwise>
<xsl:if test="$node/@show_title='1'"><div class="title"><xsl:value-of select="$node/@title"/></div></xsl:if>
<div class="content">
<xsl:apply-templates select="$node/content">
<xsl:with-param name="article" select="false()"/>
</xsl:apply-templates>
</div>
<xsl:if test="$node/notes!=''"><div class="abox-notes"><xsl:value-of select="$node/notes" disable-output-escaping="yes"/></div></xsl:if>
</xsl:otherwise>
</xsl:choose>
</div>
</xsl:template>


<!-- ###############################
     ARTICLE CONTENT
     ############################### -->
<xsl:template name="articleContent">
<xsl:param name="a" select="/root/article"/>
<div id="article-content" data-ts="{$a/@ts}">
<xsl:attribute name="class">text-<xsl:value-of select="$a/@text-align"/> clearfix</xsl:attribute>

<xsl:choose>
<xsl:when test="$a/@id_template">
<div class="article-template{$a/@id_template}">
<xsl:call-template name="articleTemplate">
<xsl:with-param name="a" select="$a"/>
<xsl:with-param name="id_template" select="$a/@id_template"/>
</xsl:call-template>
</div>
</xsl:when>
<xsl:otherwise>

<xsl:call-template name="articleContentHeadings">
<xsl:with-param name="a" select="$a"/>
</xsl:call-template>

<xsl:call-template name="articleContentComments">
<xsl:with-param name="a" select="$a"/>
</xsl:call-template>

<xsl:if test="$a/translations">
<xsl:call-template name="articleContentTranslations">
<xsl:with-param name="a" select="$a"/>
</xsl:call-template>
</xsl:if>

<div id="article-text"><xsl:apply-templates select="$a/content"/></div>

<xsl:call-template name="articleContentNotes">
<xsl:with-param name="a" select="$a"/>
</xsl:call-template>

<xsl:if test="$a/@id_template">
<xsl:call-template name="articleTemplate">
<xsl:with-param name="a" select="$a"/>
</xsl:call-template>
</xsl:if>

<xsl:if test="$a/translation">
<xsl:call-template name="articleTranslation">
<xsl:with-param name="a" select="$a/translation"/>
</xsl:call-template>
</xsl:if>

<xsl:if test="$a/docs">
<xsl:call-template name="articleDocs">
<xsl:with-param name="docs" select="$a/docs"/>
</xsl:call-template>
</xsl:if>

<xsl:if test="$a/related">
<xsl:call-template name="related">
<xsl:with-param name="items" select="$a/related"/>
<xsl:with-param name="title" select="key('label','seealso')/@tr"/>
</xsl:call-template>
</xsl:if>

<xsl:if test="$a/books">
<xsl:call-template name="articleBooks">
<xsl:with-param name="node" select="$a/books"/>
</xsl:call-template>
</xsl:if>

<xsl:call-template name="licence">
<xsl:with-param name="i" select="$a"/>
</xsl:call-template>

<xsl:call-template name="articleFooter">
<xsl:with-param name="i" select="$a"/>
</xsl:call-template>

</xsl:otherwise>
</xsl:choose>
</div>
</xsl:template>


<!-- ###############################
     ARTICLE CONTENT HEADINGS
     ############################### -->
<xsl:template name="articleContentHeadings">
<xsl:param name="a"/>
<div class="headings">
<xsl:if test="$a/@headline_visible='1' or $pagetype='send_friend'">

<xsl:call-template name="articleContentHeadingsHalftitle">
<xsl:with-param name="a" select="$a"/>
</xsl:call-template>

<xsl:call-template name="articleContentHeadingsHeadline">
<xsl:with-param name="a" select="$a"/>
</xsl:call-template>

<xsl:call-template name="articleContentHeadingsSubhead">
<xsl:with-param name="a" select="$a"/>
</xsl:call-template>

</xsl:if>

<xsl:call-template name="articleContentHeadingsNotes">
<xsl:with-param name="a" select="$a"/>
</xsl:call-template>

<xsl:call-template name="articleContentHeadingsSource">
<xsl:with-param name="a" select="$a"/>
</xsl:call-template>

</div>
</xsl:template>


<!-- ###############################
     ARTICLE CONTENT HEADINGS HALFTITLE
     ############################### -->
<xsl:template name="articleContentHeadingsHalftitle">
<xsl:param name="a"/>
<xsl:if test="$a/halftitle!=''"><div class="halftitle"><xsl:value-of select="$a/halftitle" disable-output-escaping="yes"/></div></xsl:if>
</xsl:template>


<!-- ###############################
     ARTICLE CONTENT HEADINGS HEADLINE
     ############################### -->
<xsl:template name="articleContentHeadingsHeadline">
<xsl:param name="a"/>
<h1><xsl:value-of select="$a/headline" disable-output-escaping="yes"/></h1>
</xsl:template>


<!-- ###############################
     ARTICLE CONTENT HEADINGS SUBHEAD
     ############################### -->
<xsl:template name="articleContentHeadingsSubhead">
<xsl:param name="a"/>
<xsl:if test="$a/subhead!=''"><div class="subhead"><xsl:value-of select="$a/subhead" disable-output-escaping="yes"/></div></xsl:if>
</xsl:template>


<!-- ###############################
     ARTICLE CONTENT HEADINGS NOTES
     date and author
     ############################### -->
<xsl:template name="articleContentHeadingsNotes">
<xsl:param name="a"/>
<div class="notes">
<xsl:if test="$a/author/image">
<img class="user-image" width="{$a/author/image/@width}" alt="{$a/author/@name}">
<xsl:attribute name="src">
<xsl:call-template name="createLinkUrl">
<xsl:with-param name="node" select="$a/author/image"/>
<xsl:with-param name="cdn" select="/root/site/@cdn!=''"/>
</xsl:call-template>
</xsl:attribute>
</img>
</xsl:if>

<xsl:if test="$a/@show_date='1' and $a/@display_date"><xsl:value-of select="$a/@display_date"/></xsl:if>
<xsl:if test="$a/@show_author='1' and $a/author/@name!=''">
<xsl:if test="$a/@show_date='1' and $a/@display_date"> - </xsl:if>
<xsl:choose>
<xsl:when test="$a/author/@email and $pagetype!='ebook'">
<a href="mailto:{$a/author/@email}"><xsl:value-of select="$a/author/@name"/></a>
</xsl:when>
<xsl:when test="$a/author/@user_show='1' and $pagetype!='ebook'">
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="$a/author"/>
</xsl:call-template>
</xsl:when>
<xsl:otherwise>
<xsl:value-of select="$a/author/@name"/>
</xsl:otherwise>
</xsl:choose>
<xsl:if test="$a/author/@notes!=''"> (<xsl:value-of select="$a/author/@notes"/>)</xsl:if>
</xsl:if>
</div>
</xsl:template>


<!-- ###############################
     ARTICLE CONTENT HEADINGS SOURCE
     ############################### -->
<xsl:template name="articleContentHeadingsSource">
<xsl:param name="a"/>
<xsl:if test="$a/source/@show='1' and $a/source/description!=''">
<div class="source"><xsl:value-of select="key('label','source')/@tr"/>: <xsl:value-of select="$a/source/description" disable-output-escaping="yes"/>
<xsl:if test="$a/source/@date"> - <xsl:value-of select="$a/source/@date"/></xsl:if>
</div>
</xsl:if>
</xsl:template>


<!-- ###############################
     ARTICLE CONTENT NOTES
     ############################### -->
<xsl:template name="articleContentNotes">
<xsl:param name="a"/>
<xsl:if test="string-length($a/notes) &gt; 9">
<div class="article-notes"><xsl:value-of select="key('label','notes')/@tr"/>: <xsl:value-of select="$a/notes" disable-output-escaping="yes"/></div>
</xsl:if>
</xsl:template>


<!-- ###############################
     ARTICLE CONTENT COMMENTS
     ############################### -->
<xsl:template name="articleContentComments">
<xsl:param name="a"/>
<xsl:if test="$a/comments/@active='1'">
<div class="comments">
<h3><xsl:value-of select="key('label','comments')/@tr"/></h3>
<xsl:if test="$a/comments/insert">
<xsl:call-template name="createLink">
<xsl:with-param name="name" select="$a/comments/insert/@label"/>
<xsl:with-param name="node" select="$a/comments/insert"/>
</xsl:call-template>
</xsl:if>
<xsl:if test="$a/comments/insert and $a/comments/@num &gt; 0">
<xsl:text> - </xsl:text>
</xsl:if>
<xsl:if test="$a/comments/@num &gt; 0">
<xsl:call-template name="createLink">
<xsl:with-param name="name" select="concat($a/comments/@num,' ' ,key('label','comments_num')/@tr)"/>
<xsl:with-param name="node" select="$a/comments"/>
</xsl:call-template>
</xsl:if>
</div>
</xsl:if>

</xsl:template>


<!-- ###############################
     ARTICLE CONTENT TEMPLATE
     ############################### -->
<xsl:template name="articleContentTemplate">
<xsl:param name="a"/>
<xsl:if test="count($a/template_values/tvalue[@public=1])&gt;0"> 
<ul class="tvalues">
<xsl:for-each select="$a/template_values/tvalue[@public=1]">
<li id="tvalue{@id}"><xsl:value-of select="concat(@label,': ',@value)" disable-output-escaping="yes" /></li>
</xsl:for-each>
</ul>
</xsl:if>
</xsl:template>


<!-- ###############################
     ARTICLE CONTENT TRANSLATIONS
     ############################### -->
<xsl:template name="articleContentTranslations">
<xsl:param name="a"/>
<div id="art-translations">
<h3><xsl:value-of select="$a/translations/@label"/></h3>
<ul class="items">
<xsl:for-each select="$a/translations/article">
<li class="article-item">
<xsl:call-template name="articleItem">
<xsl:with-param name="a" select="."/>
<xsl:with-param name="show_topic" select="true()"/>
<xsl:with-param name="show_image" select="false()"/>
<xsl:with-param name="show_halftitle" select="false()"/>
<xsl:with-param name="show_trad_language" select="true()"/>
</xsl:call-template>
</li>
</xsl:for-each>
</ul>
</div>
</xsl:template>


<!-- ###############################
     ARTICLE DOCS
     ############################### -->
<xsl:template name="articleDocs">
<xsl:param name="docs"/>
<div id="article-docs">
<h3><xsl:value-of select="key('label','attachments')/@tr"/></h3>
<ul class="article-docs">
<xsl:for-each select="$docs/doc">
<li>
<xsl:if test="cover">
<xsl:variable name="src">
<xsl:call-template name="createLinkUrl">
<xsl:with-param name="node" select="cover"/>
<xsl:with-param name="cdn" select="/root/site/@cdn!=''"/>
</xsl:call-template>
</xsl:variable>
<a title="{@title}">
<xsl:attribute name="href">
<xsl:choose>
<xsl:when test="subtopic">
<xsl:call-template name="createLinkUrl">
<xsl:with-param name="node" select="subtopic"/>
</xsl:call-template>
</xsl:when>
<xsl:otherwise>
<xsl:call-template name="createLinkUrl">
<xsl:with-param name="node" select="."/>
</xsl:call-template>
</xsl:otherwise>
</xsl:choose>
</xsl:attribute>
<img width="{cover/@width}" alt="{@title}" src="{$src}" class="left">
</img>
</a>
</xsl:if>
<div class="title">
<xsl:choose>
<xsl:when test="subtopic">
<xsl:call-template name="createLink">
<xsl:with-param name="name" select="@title"/>
<xsl:with-param name="node" select="subtopic"/>
</xsl:call-template>
</xsl:when>
<xsl:otherwise>
<xsl:call-template name="createLink">
<xsl:with-param name="name" select="@title"/>
<xsl:with-param name="node" select="."/>
</xsl:call-template>
</xsl:otherwise>
</xsl:choose>
(<xsl:value-of select="concat(file_info/@kb,' Kb - ',key('label','format')/@tr,' ',file_info/@format,')')"/>
</div>
<xsl:if test="@author!='' or source!=''"><div class="notes"><xsl:value-of select="@author"/>
<xsl:if test="source!=''"><xsl:value-of select="concat(' - ',key('label','source')/@tr,': ')"/><xsl:value-of select="source" disable-output-escaping="yes"/></xsl:if></div></xsl:if>
<xsl:if test="description!=''"><div><xsl:value-of select="description" disable-output-escaping="yes"/></div></xsl:if>
<xsl:call-template name="licenceInfo">
<xsl:with-param name="i" select="."/>
</xsl:call-template>
<xsl:if test="file_info/format_info">
<div class="format-info"><xsl:value-of select="file_info/format_info" disable-output-escaping="yes"/></div>
</xsl:if>
</li>
</xsl:for-each>
</ul>
</div>
</xsl:template>


<!-- ###############################
     ARTICLE FOOTER
     ############################### -->
<xsl:template name="articleFooter">
<xsl:param name="a"/>
</xsl:template>


<!-- ###############################
     ARTICLE ITEM
     ############################### -->
<xsl:template name="articleItem">
  <xsl:param name="a"/>
  <xsl:param name="show_topic" select="false()"/>
  <xsl:param name="show_image" select="true()"/>
  <xsl:param name="show_halftitle" select="true()"/>
  <xsl:param name="show_path" select="false()"/>
  <xsl:param name="show_trad_language" select="false()"/>
  <div>
    <xsl:attribute name="class">article-item <xsl:if test="$a/@id_template &gt; 0"> article-template<xsl:value-of select="$a/@id_template"/></xsl:if><xsl:if test="$a/@id_language = 6"> lang-rtl</xsl:if><xsl:if test="$a/@available=0"> protected</xsl:if><xsl:if test="$a/@highlight=1"> highlight</xsl:if></xsl:attribute>
    <xsl:if test="$a/image and $show_image=true()">
      <xsl:variable name="i" select="$a/image"/>
      <xsl:variable name="src">
        <xsl:call-template name="createLinkUrl">
          <xsl:with-param name="node" select="$i"/>
          <xsl:with-param name="cdn" select="/root/site/@cdn!=''"/>
        </xsl:call-template>
      </xsl:variable>
      <xsl:variable name="src2">
        <xsl:call-template name="stringReplace">
          <xsl:with-param name="string" select="$src"/>
          <xsl:with-param name="find" select="concat('w=',$i/@width,'&amp;resize=aspectfit')"/>
          <xsl:with-param name="replace" select="'w=100&amp;h=100&amp;resize=entropy'"/>
        </xsl:call-template>
      </xsl:variable>
      <a title="{$a/headline}">
        <xsl:attribute name="href">
          <xsl:call-template name="createLinkUrl">
            <xsl:with-param name="node" select="$a"/>
          </xsl:call-template>
        </xsl:attribute>
        <xsl:choose>
          <xsl:when test="$a/@highlight=1">
            <img width="{$i/@width}" height="{$i/@height}" alt="{$a/headline}" src="{$src}">
            <xsl:attribute name="class">
              <xsl:choose>
                <xsl:when test="$i/@align='0'">right</xsl:when>
                <xsl:when test="$i/@align='1'">left</xsl:when>
                <xsl:when test="$i/@align='2'">standalone</xsl:when>
              </xsl:choose>
            </xsl:attribute>
            </img>
          </xsl:when>
          <xsl:otherwise>
            <picture>
              <source media="(max-width: 799px)" srcset="{$src2}"/>
              <source media="(min-width: 800px)" srcset="{$src}"/>
              <img alt="{$a/@headline}" src="{$src}">
                <xsl:attribute name="class">
                  <xsl:choose>
                    <xsl:when test="$i/@align='0'">right</xsl:when>
                    <xsl:when test="$i/@align='1'">left</xsl:when>
                    <xsl:when test="$i/@align='2'">standalone</xsl:when>
                  </xsl:choose>
                </xsl:attribute>
              </img>
            </picture>
          </xsl:otherwise>
        </xsl:choose>
      </a>
    </xsl:if>
    <xsl:if test="$show_path=true()">
      <div class="breadcrumb icon">
        <xsl:if test="topic and not(/root/topic/@id &gt; 0)">
          <xsl:call-template name="createLink">
            <xsl:with-param name="node" select="topic"/>
            <xsl:with-param name="name" select="topic/@name"/>
          </xsl:call-template>
          <xsl:value-of select="$breadcrumb_separator"/>
        </xsl:if>
        <xsl:apply-templates select="breadcrumb" mode="breadcrumb"/>
      </div>
    </xsl:if>
    <xsl:if test="$show_topic=true()">
      <div class="article-topic"><xsl:value-of select="$a/topic/@name"/></div>
    </xsl:if>
    <xsl:if test="$a/halftitle!=''">
      <div class="halftitle"><xsl:value-of select="$a/halftitle" disable-output-escaping="yes"/></div>
    </xsl:if>
    <h3>
      <xsl:if test="$show_trad_language=true()"><xsl:value-of select="concat('[',$a/@tr_language,'] ')"/></xsl:if>
      <xsl:call-template name="createLink">
        <xsl:with-param name="name"><xsl:value-of select="$a/headline" disable-output-escaping="yes"/></xsl:with-param>
        <xsl:with-param name="node" select="$a"/>
      </xsl:call-template>
    </h3>
    <div class="subhead"><xsl:value-of select="$a/subhead" disable-output-escaping="yes"/></div>
    <div class="notes">
      <xsl:if test="$a/@show_date='1' and $a/@display_date"><xsl:value-of select="$a/@display_date"/></xsl:if>
      <xsl:if test="$a/@show_author='1' and $a/author/@name!=''">
        <xsl:if test="$a/@show_date='1' and $a/@display_date"> - </xsl:if>
        <xsl:value-of select="$a/author/@name"/>
        <xsl:if test="$a/author/@notes!=''"> (<xsl:value-of select="$a/author/@notes"/>)</xsl:if>
      </xsl:if>
    </div>
  </div>
</xsl:template>


<!-- ###############################
     ARTICLE RANDOM
     ############################### -->
<xsl:template name="articleRandom">
<xsl:param name="id_keyword"/>
<xsl:if test="$pagetype!='error404'">
<xsl:variable name="id_div" select="concat('art-rd-k',$id_keyword)"/>
<xsl:choose>
<xsl:when test="$async_js=true()">
<div class="random-article" id="{$id_div}"></div>
<script type="text/javascript">
getHttpContent('/js/article.php?id_k=<xsl:value-of select="$id_keyword"/><xsl:text disable-output-escaping="yes">&amp;</xsl:text>id_topic=<xsl:value-of select="/root/topic/@id"/><xsl:text disable-output-escaping="yes">&amp;</xsl:text>a=1','art-rd-k<xsl:value-of select="$id_keyword"/>')
</script>
</xsl:when>
<xsl:otherwise>
<div class="random-article" id="{$id_div}">
<script type="text/javascript" src="{/root/site/@base}/js/article.php?id_k={$id_keyword}&amp;id_topic={/root/topic/@id}&amp;div={$id_div}">
</script>
</div>
</xsl:otherwise>
</xsl:choose>
</xsl:if>
</xsl:template>


<!-- ###############################
     ARTICLE TEMPLATE
     ############################### -->
<xsl:template name="articleTemplate">
<xsl:param name="a" select="/root/article"/>
<xsl:param name="id_template" select="/root/article/@id_template"/>

<xsl:call-template name="articleContentHeadings">
<xsl:with-param name="a" select="$a"/>
</xsl:call-template>

<xsl:call-template name="articleContentComments">
<xsl:with-param name="a" select="$a"/>
</xsl:call-template>

<xsl:if test="$a/translations">
<xsl:call-template name="articleContentTranslations">
<xsl:with-param name="a" select="$a"/>
</xsl:call-template>
</xsl:if>

<div id="article-text"><xsl:apply-templates select="$a/content"/></div>

<xsl:call-template name="articleContentNotes">
<xsl:with-param name="a" select="$a"/>
</xsl:call-template>

<xsl:if test="$a/@id_template">
<xsl:call-template name="articleContentTemplate">
<xsl:with-param name="a" select="$a"/>
</xsl:call-template>
</xsl:if>

<xsl:if test="$a/translation">
<xsl:call-template name="articleTranslation">
<xsl:with-param name="a" select="$a/translation"/>
</xsl:call-template>
</xsl:if>

<xsl:if test="$a/docs">
<xsl:call-template name="articleDocs">
<xsl:with-param name="docs" select="$a/docs"/>
</xsl:call-template>
</xsl:if>

<xsl:if test="$a/related">
<xsl:call-template name="related">
<xsl:with-param name="items" select="$a/related"/>
<xsl:with-param name="title" select="key('label','seealso')/@tr"/>
</xsl:call-template>
</xsl:if>

<xsl:if test="$a/books">
<xsl:call-template name="articleBooks">
<xsl:with-param name="node" select="$a/books"/>
</xsl:call-template>
</xsl:if>

<xsl:call-template name="licence">
<xsl:with-param name="i" select="$a"/>
</xsl:call-template>

<xsl:call-template name="articleFooter">
<xsl:with-param name="i" select="$a"/>
</xsl:call-template>

</xsl:template>


<!-- ###############################
     ARTICLE TRANSLATION
     ############################### -->
<xsl:template name="articleTranslation">
<xsl:param name="a"/>
<div id="article-trad">
<div class="trad-author"><xsl:value-of select="$a/disclaimer" disable-output-escaping="yes"/></div>
<xsl:if test="$a/original">
<div class="trad-original">
<xsl:value-of select="$a/original/@label"/> 
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="$a/original"/>
</xsl:call-template>
</div>
</xsl:if>
<xsl:if test="$a/comments">
<div class="trad-comments">
<xsl:value-of select="$a/comments/@label"/>: <xsl:value-of select="$a/comments" disable-output-escaping="yes"/>
</div>
</xsl:if>
</div>
</xsl:template>


<!-- ###############################
     ASSO ITEM
     ############################### -->
<xsl:template name="assoItem">
<xsl:param name="i"/>
<xsl:if test="$i/thumb">
<a>
<xsl:attribute name="href">
<xsl:call-template name="createLinkUrl">
<xsl:with-param name="node" select="$i"/>
</xsl:call-template>
</xsl:attribute>
<img width="{$i/thumb/@width}" class="left" alt="$i/@name">
<xsl:attribute name="src">
<xsl:call-template name="createLinkUrl">
<xsl:with-param name="node" select="$i/thumb"/>
<xsl:with-param name="cdn" select="/root/site/@cdn!=''"/>
</xsl:call-template>
</xsl:attribute>
</img>
</a>
</xsl:if>
<div><xsl:value-of select="$i/@asso_type"/></div>
<h3>
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="$i"/>
</xsl:call-template>
</h3>
<xsl:if test="$i/@name2!=''"><div class="name2"><xsl:value-of select="$i/@name2"/></div></xsl:if>
<xsl:if test="$i/@address!=''"><div class="org-address"><xsl:value-of select="$i/@address"/></div></xsl:if>
<div class="org-town"><xsl:if test="$i/@postcode!=''"><xsl:value-of select="$i/@postcode"/> - </xsl:if><xsl:value-of select="concat($i/@town,' (',$i/@geo_name,')')"/></div>
<xsl:if test="$i/params">
<ul class="kparams">
<xsl:for-each select="$i/params/param">
<li><xsl:value-of select="concat(@name,': ',@value)"/></li>
</xsl:for-each>
</ul>
</xsl:if>
</xsl:template>


<!-- ###############################
     AUDIO ITEM
     ############################### -->
<xsl:template name="audioItem">
<xsl:param name="i"/>
<xsl:if test="$i/thumb">
<a>
<xsl:attribute name="href">
<xsl:call-template name="createLinkUrl">
<xsl:with-param name="node" select="$i"/>
</xsl:call-template>
</xsl:attribute>
</a>
</xsl:if>
<div class="item-date"><xsl:value-of select="$i/@date"/></div>
<h3>
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="$i"/>
<xsl:with-param name="name" select="$i/@title"/>
</xsl:call-template>
</h3>
<xsl:if test="$i/@author"><div class="item-author"><xsl:value-of select="$i/@author"/></div></xsl:if>
<xsl:if test="$i/@length"><div class="item-length"><xsl:value-of select="$i/@length"/></div></xsl:if>
</xsl:template>


<!-- ###############################
     AUDIO NODE
     ############################### -->
<xsl:template name="audioNode">
<xsl:param name="node"/>
<xsl:param name="autostart" select="$node/@auto_start='1'"/>
<xsl:param name="player_width" select="250"/>
<xsl:param name="player_height" select="60"/>
<xsl:param name="download" select="$node/@download='1'"/>
<xsl:if test="$node/@hash">
<xsl:variable name="audio_xml">
<xsl:call-template name="createLinkUrl">
<xsl:with-param name="node" select="$node/xml"/>
</xsl:call-template>
</xsl:variable>
<xsl:variable name="mediaplayer"><xsl:if test="/root/topic/@domain and /root/publish/@static='1' and $preview=false()"><xsl:value-of select="/root/site/@base"/></xsl:if>/tools/mediaplayer.swf</xsl:variable>
<div class="audio-box" id="audio-{$node/@id}">
<div id="aud-{$node/@id}" class="audio-player"><p class="flash-warning"><xsl:value-of select="key('label','flash_warning')/@tr" disable-output-escaping="yes"/></p></div>
<script type="text/javascript">
var flashvars = {};
flashvars.file = encodeURIComponent('<xsl:value-of select="$audio_xml"/>');
<xsl:if test="$node/@link">
flashvars.link = encodeURIComponent('<xsl:value-of select="$node/@link"/>');
flashvars.linkfromdisplay = 'true';
</xsl:if>
<xsl:if test="$autostart=true()">
flashvars.autostart = 'true';
</xsl:if>
<xsl:if test="$download=true()">
flashvars.showdownload = 'true';
</xsl:if>
var params = {};
params.allowfullscreen = 'false';
//params.wmode = "opaque";
var attributes = {};
attributes.id = 'aud-<xsl:value-of select="$node/@id"/>';
swfobject.embedSWF('<xsl:value-of select="$mediaplayer"/>','aud-<xsl:value-of select="$node/@id"/>','<xsl:value-of select="$player_width"/>','<xsl:value-of select="$player_height"/>','<xsl:value-of select="/root/publish/@flash_version"/>',false,flashvars,params,attributes);
</script>
</div>
</xsl:if>
</xsl:template>


<!-- ###############################
     BANNER
     ############################### -->
<xsl:template name="banner">
<xsl:param name="id"/>
<xsl:if test="$pagetype!='error404'">
<xsl:variable name="id_div" select="concat('banner-b',$id)"/>
<xsl:choose>
<xsl:when test="$async_js=true()">
<div class="banner" id="{$id_div}"></div>
<script type="text/javascript">
getHttpContent('/js/banner.php?id=<xsl:value-of select="$id"/><xsl:text disable-output-escaping="yes">&amp;</xsl:text>a=1','<xsl:value-of select="$id_div"/>')
</script>
</xsl:when>
<xsl:otherwise>
<div class="banner" id="{$id_div}">
<script type="text/javascript" src="{/root/site/@base}/js/banner.php?id={$id}&amp;div={$id_div}">
</script>
</div>
</xsl:otherwise>
</xsl:choose>
</xsl:if>
</xsl:template>


<!-- ###############################
     BANNER GALLERY
     ############################### -->
<xsl:template name="bannerGallery">
<xsl:param name="id_image" select="0"/>
<xsl:param name="id_gallery"/>
<xsl:param name="id_group"/>
<xsl:param name="width"/>
<xsl:param name="random"/>
<xsl:param name="jump_to_link" select="1"/>
<xsl:if test="$pagetype!='error404'">
<xsl:variable name="id_div" select="concat('bgal',$id_gallery,$id_group,'i',$id_image)"/>
<div class="banner-gallery" id="{$id_div}">
<script type="text/javascript">
<xsl:choose>
<xsl:when test="$async_js=true()">
getHttpContent('/js/gallery.php?id=<xsl:value-of select="$id_gallery"/><xsl:text disable-output-escaping="yes">&amp;</xsl:text>id_g=<xsl:value-of select="$id_group"/><xsl:text disable-output-escaping="yes">&amp;</xsl:text>img=<xsl:value-of select="$id_image"/><xsl:text disable-output-escaping="yes">&amp;</xsl:text>w=<xsl:value-of select="$width"/><xsl:text disable-output-escaping="yes">&amp;</xsl:text>r=<xsl:value-of select="$random"/><xsl:text disable-output-escaping="yes">&amp;</xsl:text>j=<xsl:value-of select="$jump_to_link"/><xsl:text disable-output-escaping="yes">&amp;</xsl:text>a=1','<xsl:value-of select="$id_div"/>')
</xsl:when>
<xsl:otherwise>
<xsl:attribute name="src"><xsl:value-of select="/root/site/@base"/>/js/gallery.php?id=<xsl:value-of select="$id_gallery"/>&amp;id_g=<xsl:value-of select="$id_group"/>&amp;img=<xsl:value-of select="$id_image"/>&amp;w=<xsl:value-of select="$width"/>&amp;r=<xsl:value-of select="$random"/>&amp;j=<xsl:value-of select="$jump_to_link"/>&amp;div=<xsl:value-of select="$id_div"/>
</xsl:attribute>
</xsl:otherwise>
</xsl:choose>
</script>
<noscript>
<div><xsl:call-template name="createLink">
<xsl:with-param name="node" select="/root/site/galleries"/>
</xsl:call-template></div>
</noscript>
</div>
</xsl:if>
</xsl:template>


<!-- ###############################
     BANNER GROUP
     ############################### -->
<xsl:template name="bannerGroup">
  <xsl:param name="id"/>
  <xsl:if test="$pagetype!='error404'">
    <xsl:variable name="id_div" select="concat('banner-g',$id)"/>
    <xsl:choose>
      <xsl:when test="$async_js=true()">
        <div class="banner" id="{$id_div}"></div>
        <script type="text/javascript">
$(function() {
  $.ajax({
    url : '/js/banner.php?id_g=<xsl:value-of select="$id"/><xsl:text disable-output-escaping="yes">&amp;</xsl:text>json',
    type : "GET",
    cache : false,
    success : function(data) {
      if(data.id_banner) {
        $('#<xsl:value-of select="$id_div"/>').html('<a href="'+data.link+'" title="'+data.alt_text+'"><img width="'+data.width+'" height="'+data.height+'" src="'+data.src+'" alt="'+data.alt_text+'"/></a>');
      } else {
        console.log('No banner')
      }
    },
    error: function(XMLHttpRequest, textStatus, errorThrown) { 
      console.log("Response: " + XMLHttpRequest.responseText + ' - ' + errorThrown);
    }
  });
});
        </script>
      </xsl:when>
      <xsl:otherwise>
        <div class="banner" id="{$id_div}">
          <script type="text/javascript" src="{/root/site/@base}/js/banner.php?id_g={$id}&amp;div={$id_div}">
          </script>
        </div>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:if>
</xsl:template>


<!-- ###############################
     BOOK ITEM
     ############################### -->
<xsl:template name="bookItem">
<xsl:param name="b"/>
<xsl:param name="img_align" select="'left'"/>
<xsl:if test="$b/thumb">
<a>
<xsl:attribute name="href">
<xsl:call-template name="createLinkUrl">
<xsl:with-param name="node" select="$b"/>
</xsl:call-template>
</xsl:attribute>
<img width="{$b/thumb/@width}" class="{$img_align}">
<xsl:attribute name="src">
<xsl:call-template name="createLinkUrl">
<xsl:with-param name="node" select="$b/thumb"/>
<xsl:with-param name="cdn" select="/root/site/@cdn!=''"/>
</xsl:call-template>
</xsl:attribute>
</img>
</a>
</xsl:if>
<div class="book-info">
<div class="author"><xsl:value-of select="$b/@author"/></div>
<h3>
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="$b"/>
<xsl:with-param name="name" select="$b/@title"/>
</xsl:call-template>
</h3>
<div><xsl:value-of select="$b/summary" disable-output-escaping="yes"/></div>
<xsl:if test="$b/publisher">
<div class="publisher">
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="$b/publisher"/>
</xsl:call-template> / <xsl:call-template name="createLink">
<xsl:with-param name="node" select="$b/publisher/category"/>
</xsl:call-template>
</div>
</xsl:if>
<xsl:if test="$b/@year!='' ">
<div class="pubdate"><xsl:value-of select="concat($b/@month,' ',$b/@year)"/></div>
</xsl:if>
<xsl:if test="$b/@price &gt; 0">
<div class="price"><xsl:value-of select="$b/@price_format"/></div>
</xsl:if>
</div>
</xsl:template>


<!-- ###############################
     BOOK ITEM BIG
     ############################### -->
<xsl:template name="bookItemBig">
<xsl:param name="b"/>
<xsl:variable name="src">
<xsl:call-template name="createLinkUrl">
<xsl:with-param name="node" select="$b"/>
<xsl:with-param name="cdn" select="/root/site/@cdn!=''"/>
</xsl:call-template>
</xsl:variable>
<div class="blockbooktitle">
<xsl:if test="$b/image">
<a href="{$src}">
<img alt="Cover - {$b/@title}">
<xsl:attribute name="src">
<xsl:call-template name="createLinkUrl">
<xsl:with-param name="node" select="$b/image"/>
<xsl:with-param name="cdn" select="/root/site/@cdn!=''"/>
</xsl:call-template>
</xsl:attribute>
</img>
</a>
</xsl:if>
<div><xsl:value-of select="$b/@author"/></div>
<h3><a href="{$src}"><xsl:value-of select="$b/@title"/></a></h3>
<div><xsl:value-of select="$b/summary" disable-output-escaping="yes"/></div>
<p><xsl:value-of select="$b/description" disable-output-escaping="yes"/></p>
<div><xsl:value-of select="$b/@price_format"/></div>
</div>
</xsl:template>


<!-- ###############################
     BOOK RANDOM
     ############################### -->
<xsl:template name="bookRandom">
<xsl:param name="id_publisher"/>
<xsl:param name="id_category"/>
<xsl:param name="id_keyword"/>
<xsl:param name="size" select="0"/>
<xsl:if test="$pagetype!='error404'">
<xsl:variable name="id_div" select="concat('bkrp',$id_publisher,'c',$id_category,'k',$id_keyword)"/>
<div class="random-book" id="{$id_div}"></div>
<xsl:choose>
<xsl:when test="$async_js=true()">
<script type="text/javascript">
getHttpContent('/js/book.php?id_p=<xsl:value-of select="$id_publisher"/><xsl:text disable-output-escaping="yes">&amp;</xsl:text>id_c=<xsl:value-of select="$id_category"/><xsl:text disable-output-escaping="yes">&amp;</xsl:text>id_k=<xsl:value-of select="$id_keyword"/><xsl:text disable-output-escaping="yes">&amp;</xsl:text>size=<xsl:value-of select="$size"/><xsl:text disable-output-escaping="yes">&amp;</xsl:text>a=1','<xsl:value-of select="$id_div"/>')
</script>
</xsl:when>
<xsl:otherwise>
<div class="random-book" id="{$id_div}">
<script type="text/javascript" src="{/root/site/@base}/js/book.php?id_p={$id_publisher}&amp;id_c={$id_category}&amp;id_k={$id_keyword}&amp;size={$size}&amp;div={$id_div}">
</script>
</div>
</xsl:otherwise>
</xsl:choose>
</xsl:if>
</xsl:template>


<!-- ###############################
     BOTTOM BAR
     ############################### -->
<xsl:template name="bottomBar">
<xsl:if test="/root/topic/page_footer"><div id="page-footer"><xsl:apply-templates select="/root/topic/page_footer"/></div></xsl:if>
<div id="phpeace">Powered by <a href="https://www.phpeace.org">PhPeace <xsl:value-of select="/root/site/@phpeace"/></a></div>
</xsl:template>


<!-- ###############################
     BREADCRUMB
     ############################### -->
<xsl:template name="breadcrumb">
<div class="breadcrumb">
<xsl:choose>
<xsl:when test="$pagetype='subtopic'">
<xsl:apply-templates select="/root/subtopic/breadcrumb" mode="breadcrumb"/>
</xsl:when>
<xsl:when test="$pagetype='article' or $pagetype='send_friend'">
<xsl:apply-templates select="/root/article/breadcrumb" mode="breadcrumb"/>
</xsl:when>
<xsl:when test="$pagetype='map'">
<xsl:call-template name="createLink">
<xsl:with-param name="name" select="key('label','map')/@tr"/>
<xsl:with-param name="node" select="/root/site/map"/>
</xsl:call-template>
<xsl:if test="/root/publish/@id &gt; 0">
<xsl:value-of select="$breadcrumb_separator"/>
<xsl:apply-templates select="/root/topics/group/breadcrumb" mode="breadcrumb"/>
</xsl:if>
</xsl:when>
<xsl:when test="$pagetype='gallery_group'">
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="/root/tree"/>
</xsl:call-template>
<xsl:if test="/root/publish/@id &gt; 0">
<xsl:value-of select="$breadcrumb_separator"/>
<xsl:apply-templates select="/root/group/breadcrumb" mode="breadcrumb"/>
</xsl:if>
<xsl:if test="$subtype!='group' ">
<xsl:value-of select="$breadcrumb_separator"/>
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="/root/gallery"/>
</xsl:call-template>
</xsl:if>
</xsl:when>
<xsl:when test="$pagetype='feeds'">Feeds</xsl:when>
<xsl:otherwise>
<xsl:apply-templates select="/root/subtopic/breadcrumb" mode="breadcrumb"/>
</xsl:otherwise>
</xsl:choose>
</div>
</xsl:template>


<!-- ###############################
     CAMPAIGN ITEM
     ############################### -->
<xsl:template name="campaignItem">
<xsl:param name="i"/>
<xsl:if test="$i/@topic"><div><xsl:value-of select="$i/@topic"/></div></xsl:if>
<h3>
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="$i"/>
<xsl:with-param name="name" select="$i/@title"/>
</xsl:call-template>
</h3>
<xsl:if test="$i/@active='2'"><div class="notes">(<xsl:value-of select="key('label','campaign_over')/@tr"/>)</div></xsl:if>
<xsl:if test="$i/stats">
<div>
<xsl:value-of select="key('label','signatures_since')/@tr"/>
<xsl:value-of select="$i/@start_date"/>: 
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="$i/signatures/person"/>
<xsl:with-param name="name" select="concat($i/stats/@persons,' ',key('label','persons')/@tr)"/>
<xsl:with-param name="condition" select="$i/stats/@persons &gt; 0"/>
</xsl:call-template>
, 
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="$i/signatures/org"/>
<xsl:with-param name="name" select="concat($i/stats/@orgs,' ',key('label','orgs')/@tr)"/>
<xsl:with-param name="condition" select="$i/stats/@orgs &gt; 0"/>
</xsl:call-template>
</div>
</xsl:if>
</xsl:template>


<!-- ###############################
     CREATE LINK
     ############################### -->
<xsl:template name="createLink">
<xsl:param name="node"/>
<xsl:param name="name" select="$node/@name"/>
<xsl:param name="condition" select="true()"/>
<xsl:param name="p"/>
<xsl:param name="target" select="''"/>
<xsl:param name="class" select="''"/>
<xsl:param name="follow" select="true()"/>
<xsl:param name="link_title" select="$node/@name"/>
<xsl:param name="additional_params" select="''"/>

<xsl:choose>
<xsl:when test="$condition=true()">
<a>
<xsl:attribute name="href">
<xsl:call-template name="createLinkUrl">
<xsl:with-param name="node" select="$node"/>
<xsl:with-param name="p" select="$p"/>
<xsl:with-param name="additional_params" select="$additional_params"/>
</xsl:call-template>
</xsl:attribute>
<xsl:if test="$target!=''">
<xsl:attribute name="target"><xsl:value-of select="$target"/></xsl:attribute>
</xsl:if>
<xsl:if test="$node/@jumping='1'">
<xsl:attribute name="target">_blank</xsl:attribute>
</xsl:if>
<xsl:attribute name="title"><xsl:value-of select="$link_title"/></xsl:attribute>
<xsl:if test="$class!=''">
<xsl:attribute name="class"><xsl:value-of select="$class"/></xsl:attribute>
</xsl:if>
<xsl:if test="$follow=false()">
<xsl:attribute name="rel">nofollow</xsl:attribute>
</xsl:if>
<xsl:value-of select="$name"/></a>
</xsl:when>
<xsl:otherwise><xsl:value-of select="$name"/></xsl:otherwise>
</xsl:choose>
</xsl:template>


<!-- ###############################
     CREATE LINK URL
     ############################### -->
<xsl:template name="createLinkUrl">
<xsl:param name="node"/>
<xsl:param name="p"/>
<xsl:param name="additional_params" select="''"/>
<xsl:param name="cdn" select="false()"/>
<xsl:choose>
<xsl:when test="$preview=true() and $node/@qs and not($cdn=true())"><xsl:value-of select="$node/@qs"/><xsl:if test="$p!=''">&amp;p=<xsl:value-of select="$p"/></xsl:if></xsl:when>
<xsl:otherwise>
<xsl:choose>
<xsl:when test="$p &gt; 1">
<xsl:choose>
<xsl:when test="local-name($node)='subtopic'">
<xsl:call-template name="stringInsert">
<xsl:with-param name="string" select="$node/@url"/>
<xsl:with-param name="before" select="'.html'" />
<xsl:with-param name="value" select="concat('_',(($p)-1))" />
</xsl:call-template>
</xsl:when>
<xsl:otherwise><xsl:value-of select="$node/@url"/>&amp;p=<xsl:value-of select="$p"/></xsl:otherwise>
</xsl:choose>
</xsl:when>
<xsl:otherwise><xsl:value-of select="$node/@url"/></xsl:otherwise>
</xsl:choose>
</xsl:otherwise>
</xsl:choose>
<xsl:if test="$additional_params!=''">&amp;<xsl:value-of select="$additional_params"/></xsl:if>
</xsl:template>


<!-- ###############################
     CSS
     ############################### -->
<xsl:template name="css">
<xsl:if test="/root/preview">
	<link type="text/css" rel="stylesheet" href="{/root/site/@admin}/include/css/preview.css{$css_version}" media="screen"/>
</xsl:if>
<link type="text/css" rel="stylesheet" href="{$css_url}/0/common.css{$css_version}" media="screen"/>
<xsl:if test="not(/root/publish/@global='1') and /root/publish/@style &gt; 0">
	<link type="text/css" rel="stylesheet" href="{$css_url}/{/root/publish/@style}/common.css{$css_version}" media="screen"/>
</xsl:if>
<link type="text/css" rel="stylesheet" href="{$css_url}/0/print.css{$css_version}" media="print"/>
<xsl:call-template name="cssCustom"/>
</xsl:template>


<!-- ###############################
     EVENT ITEM
     ############################### -->
<xsl:template mode="mainlist" match="event">
<li>
<xsl:call-template name="eventItem">
<xsl:with-param name="e" select="."/>
</xsl:call-template>
</li>
</xsl:template>


<!-- ###############################
     EVENT ITEM
     ############################### -->
<xsl:template name="eventItem">
<xsl:param name="e"/>
<xsl:param name="showDate" select="true()"/>
<xsl:if test="$showDate=true()">
<div><xsl:value-of select="$e/@start_date"/>
<xsl:if test="$e/@end_ts &gt; $e/@start_ts"> - <xsl:value-of select="$e/@end_date"/>
</xsl:if>
</div>
</xsl:if>
<div class="event-type"><xsl:value-of select="$e/@event_type"/></div>
<h3>
<xsl:call-template name="createLink">
<xsl:with-param name="name"><xsl:value-of select="$e/@title" disable-output-escaping="yes"/></xsl:with-param>
<xsl:with-param name="node" select="$e"/>
</xsl:call-template>
</h3>
<div class="notes"><xsl:value-of select="$e/@place"/><xsl:if test="$e/@geo_name!=''"><xsl:value-of select="concat(' (',$e/@geo_name,')')"/></xsl:if></div>
</xsl:template>


<!-- ###############################
     EVENTS
     ############################### -->
<xsl:template name="events">
<xsl:param name="root"/>
<ul class="events">
<xsl:apply-templates mode="mainlist" select="$root"/>
</ul>
</xsl:template>


<!-- ###############################
     FAVICON
     ############################### -->
<xsl:template name="favicon">
<xsl:variable name="favicon_url">
<xsl:choose>
<xsl:when test="/root/topic/@domain!=''"><xsl:value-of select="/root/topic/@domain"/>/favicon.ico</xsl:when>
<xsl:otherwise><xsl:value-of select="/root/site/@base"/>/favicon.ico</xsl:otherwise>
</xsl:choose>
</xsl:variable>
<link rel="icon" href="{$favicon_url}" type="image/x-icon" />
<link rel="shortcut icon" href="{$favicon_url}" type="image/x-icon" />
</xsl:template>


<!-- ###############################
     FEATURE
     ############################### -->
<xsl:template match="feature">
<xsl:if test="@name !=''">
<h3 class="feature"><xsl:value-of select="@name"/></h3>
</xsl:if>
<xsl:choose>
<xsl:when test="@id_function='1' or @id_function='2' or @id_function='27'">
<ul class="items">
<xsl:choose>
<xsl:when test="params/@with_content='1'">
<xsl:for-each select="items/item">
<li class="{@type}-item">
<xsl:call-template name="articleContent">
<xsl:with-param name="a" select="."/>
</xsl:call-template>
</li>
</xsl:for-each>
</xsl:when>
<xsl:otherwise>
<xsl:apply-templates select="items" mode="mainlist"/>
</xsl:otherwise>
</xsl:choose>
</ul>
</xsl:when>
<xsl:when test="@id_function='3'">
<ul class="topics">
<xsl:apply-templates mode="mainlist" select="items"/>
</ul>
</xsl:when>
<xsl:when test="@id_function='6'">
<xsl:choose>
<xsl:when test="params/@with_content='1'">
<xsl:call-template name="articleContent">
<xsl:with-param name="a" select="items/item"/>
</xsl:call-template>
</xsl:when>
<xsl:otherwise>
<xsl:call-template name="articleItem">
<xsl:with-param name="a" select="items/item"/>
</xsl:call-template>
</xsl:otherwise>
</xsl:choose>
</xsl:when>
<xsl:when test="@id_function='7'">
<xsl:call-template name="subtopicItem">
<xsl:with-param name="s" select="items/subtopic"/>
<xsl:with-param name="with_children" select="params/@with_children='1'"/>
<xsl:with-param name="with_tags" select="true()"/>
</xsl:call-template>
</xsl:when>
<xsl:when test="@id_function='8'">
<ul class="items">
<xsl:apply-templates mode="mainlist" select="items"/>
</ul>
</xsl:when>
<xsl:when test="@id_function='11'">
<xsl:call-template name="rssParse">
<xsl:with-param name="node" select="items/rss/rss"/>
</xsl:call-template>
</xsl:when>
<xsl:when test="@id_function='12'">
<div id="gtext-{items/item/@id}" class="generic-text">
<xsl:value-of select="items/item/content" disable-output-escaping="yes"/>
</div>
</xsl:when>
<xsl:when test="@id_function='13' or @id_function='14'">
<ul class="groups">
<xsl:apply-templates select="items" mode="mainlist"/>
</ul>
</xsl:when>
<xsl:when test="@id_function='15'">
<h4><xsl:call-template name="createLink">
<xsl:with-param name="node" select="items/topic_full/topic"/>
</xsl:call-template></h4>
<xsl:if test="params/@with_menu='1'">
<xsl:apply-templates select="items/topic_full/menu/subtopics"/>
</xsl:if>
</xsl:when>
<xsl:when test="@id_function='22'">
<xsl:call-template name="videoNode">
<xsl:with-param name="node" select="items/video"/>
</xsl:call-template>
</xsl:when>
<xsl:when test="@id_function='23'">
<xsl:call-template name="slideshow">
<xsl:with-param name="id" select="items/item/@id"/>
<xsl:with-param name="width" select="items/item/@width"/>
<xsl:with-param name="height" select="items/item/@height"/>
<xsl:with-param name="images" select="items/item/@xml"/>
<xsl:with-param name="watermark"><xsl:if test="items/item/@watermark"><xsl:value-of select="items/item/@watermark"/></xsl:if></xsl:with-param>
<xsl:with-param name="audio"><xsl:if test="items/item/@audio!=''"><xsl:value-of select="items/item/@audio"/></xsl:if></xsl:with-param>
<xsl:with-param name="shuffle" select="items/item/@shuffle"/>
<xsl:with-param name="bgcolor" select="'0x000000'"/>
<xsl:with-param name="jscaptions" select="items/item/@show_captions='1'"/>
</xsl:call-template>
<xsl:if test="items/item/@show_captions='1'">
<div id="slide-caption-{items/item/@id}" class="gallery-image slide-caption"></div>
</xsl:if>
</xsl:when>
<xsl:when test="@id_function='25'">
<xsl:choose>
<xsl:when test="items/xml/feature_group">
<ul class="items">
<xsl:apply-templates select="items/xml/feature_group/items" mode="mainlist"/>
</ul>
</xsl:when>
<xsl:when test="items/xml/rss">
<xsl:call-template name="rssParse">
<xsl:with-param name="node" select="items/xml/rss"/>
</xsl:call-template>
</xsl:when>
</xsl:choose>
</xsl:when>
<xsl:when test="@id_function='30'">
<xsl:call-template name="tagCloud">
<xsl:with-param name="node" select="."/>
</xsl:call-template>
</xsl:when>
<xsl:otherwise>
<ul class="items">
<xsl:apply-templates select="items" mode="mainlist"/>
</ul>
</xsl:otherwise>
</xsl:choose>
</xsl:template>


<!-- ###############################
     TAG CLOUD
     ############################### -->
<xsl:template name="tagCloud">
<xsl:param name="node"/>
<script type="text/javascript" src="{/root/site/@base}/js/jquery/jquery.tagcloud.js"></script>
<script type="text/javascript">
$.fn.tagcloud.defaults = {
  size: {start: 10, end: 18, unit: 'pt'},
  color: {start: '#5555ee', end: '#555599'}
};
$(function () {
  $('#tag-cloud-<xsl:value-of select="@id"/> a').tagcloud();
});
</script>
<div id="tag-cloud-{@id}" class="tagcloud">
<xsl:for-each select="$node/items/item">
<a rel="{@occurr}">
<xsl:attribute name="href">
<xsl:call-template name="createLinkUrl">
<xsl:with-param name="node" select="."/>
</xsl:call-template>
</xsl:attribute>
<xsl:value-of select="@name"/></a>
</xsl:for-each>
</div>
</xsl:template>


<!-- ###############################
     FEEDBACK
     ############################### -->
<xsl:template name="feedback">
<xsl:if test="/root/feedback">
<xsl:for-each select="/root/feedback/message">
<div class="{@type}-msg"><xsl:value-of select="@text" disable-output-escaping="yes"/></div>
</xsl:for-each>
</xsl:if>
</xsl:template>


<!-- ###############################
     FORUM ITEM
     ############################### -->
<xsl:template name="forumItem">
<xsl:param name="i"/>
<xsl:if test="$i/@topic"><div><xsl:value-of select="$i/@topic"/></div></xsl:if>
<h3>
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="$i"/>
<xsl:with-param name="name" select="$i/@title"/>
</xsl:call-template>
</h3>
<xsl:if test="$i/@active='2'"><div class="notes">(<xsl:value-of select="key('label','forum_over')/@tr"/>)</div></xsl:if>
<div class="forum-description"><xsl:value-of select="$i/description" disable-output-escaping="yes"/></div>
<xsl:if test="$i/stats">
<div>
<xsl:value-of select="key('label','signatures_since')/@tr"/>
<xsl:value-of select="$i/@start_date"/>: 
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="$i/signatures/person"/>
<xsl:with-param name="name" select="concat($i/stats/@persons,' ',key('label','persons')/@tr)"/>
<xsl:with-param name="condition" select="$i/stats/@persons &gt; 0"/>
</xsl:call-template>
, 
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="$i/signatures/org"/>
<xsl:with-param name="name" select="concat($i/stats/@orgs,' ',key('label','orgs')/@tr)"/>
<xsl:with-param name="condition" select="$i/stats/@orgs &gt; 0"/>
</xsl:call-template>
</div>
</xsl:if>
</xsl:template>


<!-- ###############################
     FRAGMENTS
     ############################### -->
<xsl:template match="fragment">
<xsl:param name="article" select="true()"/>
<xsl:param name="ebook" select="$pagetype='ebook'"/>
<xsl:choose>
<xsl:when test="@type='text'"><xsl:value-of select="." disable-output-escaping="yes"/>
</xsl:when>
<xsl:when test="@type='img' and $ebook=true()">
<xsl:variable name="id_image" select="@id"/>
<xsl:call-template name="imageNodeEbook">
<xsl:with-param name="id" select="@id"/>
<xsl:with-param name="id_article" select="../../images/@id_article"/>
<xsl:with-param name="node" select="../../images/image[@id=$id_image]"/>
</xsl:call-template>
</xsl:when>
<xsl:when test="@type='img' and $article=true() and $ebook=false()">
<xsl:variable name="id_image" select="@id"/>
<xsl:call-template name="imageNode">
<xsl:with-param name="id" select="@id"/>
<xsl:with-param name="node" select="../../images/image[@id=$id_image]"/>
</xsl:call-template>
</xsl:when>
<xsl:when test="@type='img' and $article=false() and $ebook=false()">
<xsl:variable name="id_image" select="@id"/>
<xsl:call-template name="imageNode">
<xsl:with-param name="id" select="@id"/>
<xsl:with-param name="node" select="../../../../images/image[@id=$id_image]"/>
</xsl:call-template>
</xsl:when>
<xsl:when test="@type='box' and $article=true()">
<xsl:variable name="id_box" select="@id"/>
<xsl:call-template name="articleBoxNode">
<xsl:with-param name="id" select="@id"/>
<xsl:with-param name="node" select="../../boxes/box[@id=$id_box]"/>
</xsl:call-template>
</xsl:when>
<xsl:when test="@type='box' and $article=false()">
<xsl:variable name="id_box" select="@id"/>
<xsl:call-template name="articleBoxNode">
<xsl:with-param name="id" select="@id"/>
<xsl:with-param name="node" select="../../../../boxes/box[@id=$id_box]"/>
</xsl:call-template>
</xsl:when>
<xsl:when test="@type='gra'">
<xsl:call-template name="graphic">
<xsl:with-param name="id" select="@id"/>
</xsl:call-template>
</xsl:when>
<xsl:when test="@type='aud'">
<xsl:call-template name="audioNode">
<xsl:with-param name="node" select="audio"/>
</xsl:call-template>
</xsl:when>
<xsl:when test="@type='vid'">
<xsl:call-template name="videoNode">
<xsl:with-param name="node" select="video"/>
</xsl:call-template>
</xsl:when>
<xsl:when test="@type='vth'">
<xsl:call-template name="videoBox">
<xsl:with-param name="i" select="video"/>
</xsl:call-template>
</xsl:when>
</xsl:choose>
</xsl:template>


<!-- ###############################
     FUNDING
     ############################### -->
<xsl:template name="funding">
<xsl:param name="node"/>
<li class="funding">
<label for="amount"><xsl:value-of select="$node/@label"/></label>

<!-- amounts -->
<xsl:choose>
<xsl:when test="count($node/amounts/amount) &gt; 1">
<select name="amount">
<xsl:for-each select="$node/amounts/amount">
<option value="{@value}">
<xsl:if test="@selected='1'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>
<xsl:value-of select="@value"/></option>
</xsl:for-each>
</select>
<xsl:if test="$node/amounts/@editable='1'">
<span class="currency"><xsl:value-of select="concat(' ',$node/amounts/amount/@currency,' ',$node/amounts/@or)"/></span><input type="text" name="amount2" class="small" value=""/>
</xsl:if>
</xsl:when>
<xsl:otherwise>
<xsl:choose>
<xsl:when test="$node/amounts/@editable='1'">
<input type="text" name="amount" size="5" value="{$node/amounts/amount/@value}"/>
</xsl:when>
<xsl:otherwise>
<input type="hidden" name="amount" value="{$node/amounts/amount/@value}"/>
<span class="amount"><xsl:value-of select="$node/amounts/amount/@value"/></span></xsl:otherwise>
</xsl:choose>
</xsl:otherwise>
</xsl:choose>

<xsl:choose>
<xsl:when test="$node/amounts/amount/@currency"><span class="currency"><xsl:value-of select="concat(' ',$node/amounts/amount/@currency)"/></span><input type="hidden" name="currency" value="{$node/amounts/amount/@currency}"/></xsl:when>
<xsl:otherwise>
<xsl:choose>
<xsl:when test="count($node/accounts/account/currencies/currency) &gt; 1">
<select name="currency">
<xsl:for-each select="$node/accounts/account/currencies/currency">
<option value="{@code}">
<xsl:if test="@default"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>
<xsl:value-of select="@code"/></option>
</xsl:for-each>
</select>
</xsl:when>
<xsl:otherwise>
<span class="currency"><xsl:value-of select="concat(' ',$node/accounts/account/currencies/currency/@code)"/></span><input type="hidden" name="currency" value="{$node/accounts/account/currencies/currency/@code}"/>
</xsl:otherwise>
</xsl:choose>

</xsl:otherwise>
</xsl:choose>

<!-- account -->
<span class="account"><xsl:value-of select="concat($node/accounts/@using,' ')"/></span>
<xsl:choose>
<xsl:when test="count($node/accounts/account) &gt; 1">
<select name="id_account">
<xsl:for-each select="$node/accounts/account">
<option value="{@id_account}"><xsl:value-of select="@type"/></option>
</xsl:for-each>
</select>
</xsl:when>
<xsl:otherwise>
<strong><xsl:value-of select="$node/accounts/account/@type"/></strong>
<input type="hidden" name="id_account" value="{$node/accounts/account/@id_account}"/>
</xsl:otherwise>
</xsl:choose>
</li>
<xsl:if test="$node/@delete_subscription">
<li id="paypal-unsubscribe"><xsl:value-of select="$node/@delete_subscription" disable-output-escaping="yes"/></li>
</xsl:if>

</xsl:template>


<!-- ###############################
     GALLERY IMAGE
     ############################### -->
<xsl:template name="galleryImage">
<xsl:param name="i"/>
<xsl:param name="jump_to_link" select="true()"/>
<xsl:variable name="src">
<xsl:call-template name="createLinkUrl">
<xsl:with-param name="node" select="$i/src"/>
<xsl:with-param name="cdn" select="/root/site/@cdn!=''"/>
</xsl:call-template>
</xsl:variable>
<xsl:choose>
<xsl:when test="$jump_to_link and $i/@link!=''">
<a href="{$i/@link}">
<img width="{$i/@width}" height="{$i/@height}" alt="{$i/@caption}" src="{$src}"/>
</a>
</xsl:when>
<xsl:otherwise>
<a>
<xsl:attribute name="href">
<xsl:call-template name="createLinkUrl">
<xsl:with-param name="node" select="$i/gallery"/>
</xsl:call-template>
</xsl:attribute>
<img width="{$i/@width}" height="{$i/@height}" alt="{$i/@caption}" src="{$src}"/>
</a>
</xsl:otherwise>
</xsl:choose>
</xsl:template>


<!-- ###############################
     GALLERY IMAGE ITEM
     ############################### -->
<xsl:template name="galleryImageItem">
<xsl:param name="i"/>
<xsl:variable name="src">
<xsl:call-template name="createLinkUrl">
<xsl:with-param name="node" select="$i/src"/>
<xsl:with-param name="cdn" select="/root/site/@cdn!=''"/>
</xsl:call-template>
</xsl:variable>
<div class="gallery-image">
<xsl:choose>
<xsl:when test="$i/@link!='' ">
<a href="{$i/@link}"><img width="{$i/@width}" height="{$i/@height}" alt="{$i/@caption}" src="{$src}"/></a>
</xsl:when>
<xsl:otherwise>
<img width="{$i/@width}" height="{$i/@height}" alt="{$i/@caption}" src="{$src}"/>
</xsl:otherwise>
</xsl:choose>
<div class="image-info">
<div id="prev-next">
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="$i/prev"/>
<xsl:with-param name="name" select="$i/prev/@label"/>
<xsl:with-param name="condition" select="$i/prev/@id &gt; 0"/>
</xsl:call-template> - 
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="$i/next"/>
<xsl:with-param name="name" select="$i/next/@label"/>
<xsl:with-param name="condition" select="$i/next/@id &gt; 0"/>
</xsl:call-template>
</div>
<xsl:call-template name="galleryImageItemNotes">
<xsl:with-param name="i" select="$i"/>
</xsl:call-template>
</div>
<xsl:call-template name="licence">
<xsl:with-param name="i" select="$i"/>
</xsl:call-template>
</div>
</xsl:template>


<!-- ###############################
     GALLERY IMAGE ITEM NOTES
     ############################### -->
<xsl:template name="galleryImageItemNotes">
<xsl:param name="i"/>
<div class="caption"><xsl:value-of select="$i/@caption_html"  disable-output-escaping="yes"/></div>
<xsl:if test="$i/@author!=''">
<div class="author">
<xsl:value-of select="concat(key('label','author')/@tr,': ',$i/@author)"/>
</div>
</xsl:if>
<xsl:if test="$i/@date!=''">
<div class="image-date">
<xsl:value-of select="concat(key('label','date')/@tr,': ',$i/@date)"/>
</div>
</xsl:if>
<xsl:if test="$i/@source!=''">
<div class="source">
<xsl:value-of select="concat(key('label','source')/@tr,': ',$i/@source)"/>
</div>
</xsl:if>
<xsl:if test="$i/file">
<div class="orig">
<div><xsl:call-template name="createLink">
<xsl:with-param name="node" select="$i/file"/>
<xsl:with-param name="name" select="key('label','download_orig')/@tr"/>
</xsl:call-template> (<xsl:value-of select="concat($i/file/info/@width,'x',$i/file/info/@height,' px - ',$i/file/info/@kb,' Kb')"/>)</div>
</div>
</xsl:if>
<xsl:if test="$i/image_footer">
<div class="notes"><xsl:value-of select="$i/image_footer" disable-output-escaping="yes"/></div>
</xsl:if>
</xsl:template>


<!-- ###############################
     GALLERY ITEM
     ############################### -->
<xsl:template name="galleryItem">
<xsl:param name="i"/>
<xsl:param name="with_details" select="false()"/>
<xsl:if test="$i/aimage">
<img width="{$i/aimage/@width}" height="{$i/aimage/@height}" alt="{$i/aimage/@caption}">
<xsl:attribute name="src">
<xsl:call-template name="createLinkUrl">
<xsl:with-param name="node" select="$i/aimage"/>
<xsl:with-param name="cdn" select="/root/site/@cdn!=''"/>
</xsl:call-template>
</xsl:attribute>
</img>
</xsl:if>
<xsl:if test="$with_details">
<div>
<xsl:if test="$i/@date!=''"><xsl:value-of select="$i/@date"/></xsl:if>
<xsl:if test="$i/@date!='' and $i/@author!=''"> - </xsl:if>
<xsl:if test="$i/@author!=''"><xsl:value-of select="$i/@author"/></xsl:if>
</div>
</xsl:if>
<h3>
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="$i"/>
</xsl:call-template>
</h3>
<xsl:if test="$i/description!=''">
<div><xsl:value-of select="$i/description" disable-output-escaping="yes"/></div>
</xsl:if>
<xsl:if test="$with_details and $i/@counter!='' ">
<div class="notes"><xsl:value-of select="concat($i/@counter,' ',key('label','images')/@tr)"/></div>
</xsl:if>
</xsl:template>


<!-- ###############################
     GALLERY THUMB ITEM
     ############################### -->
<xsl:template name="galleryThumbItem">
<xsl:param name="i"/>
<xsl:variable name="src">
<xsl:call-template name="createLinkUrl">
<xsl:with-param name="node" select="$i/src"/>
<xsl:with-param name="cdn" select="/root/site/@cdn!=''"/>
</xsl:call-template>
</xsl:variable>
<xsl:choose>
<xsl:when test="$i/@use_image_link='1' and $i/@link!=''">
<a href="{$i/@link}">
<img width="{$i/@width}" height="{$i/@height}" alt="{$i/@caption}" src="{$src}"/>
</a>
<a href="{$i/@link}"><div class="caption"><xsl:value-of select="$i/@caption_html" disable-output-escaping="yes"/></div></a>
</xsl:when>
<xsl:when test="$i/image_zoom">
<xsl:call-template name="highslideZoom">
<xsl:with-param name="i" select="$i"/>
<xsl:with-param name="src_node" select="$i/src"/>
<xsl:with-param name="alt_link" select="$i"/>
<xsl:with-param name="with_notes" select="true()"/>
</xsl:call-template>
</xsl:when>
<xsl:otherwise>
<a>
<xsl:attribute name="href">
<xsl:call-template name="createLinkUrl">
<xsl:with-param name="node" select="$i"/>
</xsl:call-template>
</xsl:attribute>
<img width="{$i/@width}" height="{$i/@height}" alt="{$i/@caption}" src="{$src}"/>
</a>
<div class="caption"><xsl:value-of select="$i/@caption_html" disable-output-escaping="yes"/></div>
</xsl:otherwise>
</xsl:choose>
</xsl:template>


<!-- ###############################
     GENERATOR
     ############################### -->
<xsl:template name="generator">
<meta name="Generator">
<xsl:attribute name="content">PhPeace <xsl:value-of select="/root/site/@phpeace"/> - build <xsl:value-of select="/root/site/@build"/></xsl:attribute>
</meta>
</xsl:template>


<!-- ###############################
     GENERIC ITEM
     ############################### -->
<xsl:template name="genericItem">
<xsl:param name="i"/>
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="$i"/>
</xsl:call-template>
</xsl:template>


<!-- ###############################
     GRAPHIC IMAGE
     ############################### -->
<xsl:template name="graphic">
<xsl:param name="id"/>
<xsl:param name="width"/>
<xsl:param name="height"/>
<xsl:param name="format" select="'jpg'"/>
<xsl:param name="alt_text">
<xsl:choose>
<xsl:when test="/root/topic"><xsl:value-of select="/root/topic/@name"/></xsl:when>
<xsl:otherwise><xsl:value-of select="/root/site/@title"/></xsl:otherwise>
</xsl:choose>
</xsl:param>
<xsl:choose>
<xsl:when test="/root/site/@ui='1'">
<xsl:variable name="cdn_params">
<xsl:choose>
<xsl:when test="/root/site/@cdn!='' and $format='gif'">?format=png</xsl:when>
<xsl:otherwise></xsl:otherwise>
</xsl:choose>
</xsl:variable>
<img alt="{$alt_text}" src="{/root/site/@assets_domain}/images/{$id}.{$format}{$cdn_params}" id="gra-{$id}"/>
</xsl:when>
<xsl:otherwise>
<xsl:call-template name="graphicInternal">
<xsl:with-param name="id" select="$id"/>
</xsl:call-template>
</xsl:otherwise>
</xsl:choose>
</xsl:template>


<!-- ###############################
     GRAPHIC IMAGE INTERNAL
     ############################### -->
<xsl:template name="graphicInternal">
<xsl:param name="id"/>
<xsl:param name="node" select="key('graphic',$id)"/>
<xsl:param name="alt_text" select="$node/@caption"/>
<xsl:variable name="gurl"><xsl:call-template name="createLinkUrl"><xsl:with-param name="node" select="$node"/></xsl:call-template></xsl:variable>
<img width="{$node/@width}" height="{$node/@height}" alt="{$alt_text}" src="{$gurl}" id="gra-{$id}"/>
</xsl:template>


<!-- ###############################
     GROUP (BREADCRUMB ITEM)
     ############################### -->
<xsl:template match="group" mode="breadcrumb">
<xsl:if test="position() &gt; 2"><xsl:value-of select="$breadcrumb_separator"/></xsl:if>
<xsl:call-template name="createLink">
<xsl:with-param name="name" select="@name"/>
<xsl:with-param name="node" select="."/>
</xsl:call-template>
</xsl:template>


<!-- ###############################
     HEAD
     ############################### -->
<xsl:template name="head">
<meta name="viewport" content="width=device-width, initial-scale=1"/>
<xsl:call-template name="metaRobots"/>
<xsl:call-template name="keywordsMeta"/>
<xsl:call-template name="generator"/>
<xsl:if test="/root/page">
<link rel="canonical" content="{/root/page/@url}"/>
</xsl:if>
<xsl:variable name="feed_mimetype">
<xsl:choose>
<xsl:when test="/root/site/feeds/@type='3'">atom+xml</xsl:when>
<xsl:otherwise>rss+xml</xsl:otherwise>
</xsl:choose>
</xsl:variable>
<xsl:call-template name="favicon"/>
<xsl:if test="/root/topic">
<link rel="alternate" type="application/{$feed_mimetype}" title="{/root/topic/@name}" 
href="{/root/topic/rss/@url}" />
</xsl:if>
<xsl:if test="/root/publish/@global='1'">
<link rel="alternate" type="application/{$feed_mimetype}" title="{/root/site/@title}" 
href="{/root/site/rss/@url}" />
</xsl:if>
<title><xsl:call-template name="headPageTitle"/></title>
<xsl:call-template name="css"/>
<xsl:call-template name="javascriptHead"/>
</xsl:template>


<!-- ###############################
     HEAD PAGE TITLE
     ############################### -->
<xsl:template name="headPageTitle">
<xsl:if test="$preview=true()">[<xsl:value-of select="key('label','preview')/@tr"/>] </xsl:if><xsl:value-of select="$current_page_title"/>
</xsl:template>


<!-- ###############################
     HIGHSLIDE ZOOM
     ############################### -->
<xsl:template name="highslideZoom">
<xsl:param name="i"/>
<xsl:param name="src_node" select="$i"/>
<xsl:param name="alt_link" select="$i/image_popup"/>
<xsl:param name="class" select="''"/>
<xsl:param name="with_notes" select="false()"/>
<xsl:variable name="src">
<xsl:call-template name="createLinkUrl">
<xsl:with-param name="node" select="$src_node"/>
<xsl:with-param name="cdn" select="/root/site/@cdn!=''"/>
</xsl:call-template>
</xsl:variable>
<a target="_blank" class="highslide">
<xsl:attribute name="onclick">return hs.expand(this, { src: '<xsl:call-template name="createLinkUrl"><xsl:with-param name="node" select="$i/image_zoom"/></xsl:call-template>', captionId: 'zoom-caption<xsl:value-of select="$i/@id"/>' } )</xsl:attribute>
<xsl:attribute name="href">
<xsl:call-template name="createLinkUrl">
<xsl:with-param name="node" select="$alt_link"/>
</xsl:call-template>
</xsl:attribute>
<xsl:attribute name="title"><xsl:value-of select="concat($i/@caption,' (',$i/image_zoom/@label,')')"/></xsl:attribute>
<img name="image-thumb{$i/@id}" id="image-thumb{$i/@id}" width="{$i/@width}" height="{$i/@height}" alt="{$i/@caption}" src="{$src}">
<xsl:if test="$class!=''"><xsl:attribute name="class"><xsl:value-of select="$class"/></xsl:attribute></xsl:if>
</img>
</a>
<div class="hidden">
<div class="highslide-caption" id="zoom-caption{$i/@id}">
<xsl:choose>
<xsl:when test="$with_notes=true()">
<xsl:call-template name="galleryImageItemNotes">
<xsl:with-param name="i" select="$i"/>
</xsl:call-template>
</xsl:when>
<xsl:otherwise>
<div class="image-caption"><xsl:value-of select="$i/@caption"/></div>
<xsl:if test="$i/@author!=''"><div class="image-author"><xsl:value-of select="key('label','author')/@tr"/>: <xsl:value-of select="$i/@author"/></div></xsl:if>
<xsl:if test="$i/@source!=''"><div class="image-source"><xsl:value-of select="key('label','source')/@tr"/>: <xsl:value-of select="$i/@source"/></div></xsl:if>
<xsl:call-template name="licenceInfo">
<xsl:with-param name="i" select="$i/image_zoom"/>
</xsl:call-template>
</xsl:otherwise>
</xsl:choose>
<div class="image-close"><a href="#" onclick="return hs.close(this)"><xsl:value-of select="$i/image_zoom/@label_close"/></a></div>
</div>
</div>
</xsl:template>


<!-- ###############################
     IMAGE NODE
     ############################### -->
<xsl:template name="imageNode">
<xsl:param name="id"/>
<xsl:param name="node"/>
<xsl:variable name="src">
<xsl:call-template name="createLinkUrl">
<xsl:with-param name="node" select="$node"/>
<xsl:with-param name="cdn" select="/root/site/@cdn!=''"/>
</xsl:call-template>
</xsl:variable>
<xsl:variable name="class">
<xsl:choose>
<xsl:when test="$node/@align='0'">right</xsl:when>
<xsl:when test="$node/@align='1'">left</xsl:when>
<xsl:when test="$node/@align='2'">standalone</xsl:when>
</xsl:choose>
</xsl:variable>
<xsl:choose>
<xsl:when test="$node/@zoom='1'">
<a target="_blank" onclick="open_popup(this,{$node/image_popup/@width + 100},{$node/image_popup/@height + 200}); return false">
<xsl:attribute name="href">
<xsl:call-template name="createLinkUrl">
<xsl:with-param name="node" select="$node/image_popup"/>
<xsl:with-param name="cdn" select="true()"/>
</xsl:call-template>
</xsl:attribute>
<xsl:attribute name="title"><xsl:value-of select="concat($node/@caption,' (',$node/image_popup/@label,')')"/></xsl:attribute>
xxx<img width="{$node/@width}" height="{$node/@height}" alt="{$node/@caption}" src="{$src}" class="{$class}"/>
</a>
</xsl:when>
<xsl:when test="$node/@zoom='2'">
<xsl:call-template name="highslideZoom">
<xsl:with-param name="i" select="$node"/>
<xsl:with-param name="src_node" select="$node"/>
<xsl:with-param name="class" select="$class"/>
</xsl:call-template>
</xsl:when>
<xsl:otherwise>
<img width="{$node/@width}" height="{$node/@height}" alt="{$node/@caption}" src="{$src}" class="{$class}"/>
</xsl:otherwise>
</xsl:choose>
</xsl:template>


<!-- ###############################
     ITEM
     ############################### -->
<xsl:template mode="mainlist" match="item">
<li>
<xsl:attribute name="class"><xsl:value-of select="@type"/>-item<xsl:if test="position()=last()-1"><xsl:text> last</xsl:text></xsl:if></xsl:attribute>
<xsl:if test="@id &gt; 0"><xsl:attribute name="id"><xsl:value-of select="@type"/>-<xsl:value-of select="@id"/></xsl:attribute></xsl:if>
<xsl:if test="@hdate"><div class="hdate">[<xsl:value-of select="@hdate"/>]</div></xsl:if>
<xsl:choose>
<xsl:when test="@type='article'">
<xsl:call-template name="articleItem">
<xsl:with-param name="a" select="."/>
</xsl:call-template>
</xsl:when>
<xsl:when test="@type='asso'">
<xsl:call-template name="assoItem">
<xsl:with-param name="i" select="."/>
</xsl:call-template>
</xsl:when>
<xsl:when test="@type='audio'">
<xsl:call-template name="audioItem">
<xsl:with-param name="i" select="."/>
</xsl:call-template>
</xsl:when>
<xsl:when test="@type='book'">
<xsl:call-template name="bookItem">
<xsl:with-param name="b" select="."/>
</xsl:call-template>
</xsl:when>
<xsl:when test="@type='campaign'">
<xsl:call-template name="campaignItem">
<xsl:with-param name="i" select="."/>
</xsl:call-template>
</xsl:when>
<xsl:when test="@type='event'">
<xsl:call-template name="eventItem">
<xsl:with-param name="e" select="."/>
</xsl:call-template>
</xsl:when>
<xsl:when test="@type='forum'">
<xsl:call-template name="forumItem">
<xsl:with-param name="i" select="."/>
</xsl:call-template>
</xsl:when>
<xsl:when test="@type='gallery'">
<xsl:call-template name="galleryItem">
<xsl:with-param name="i" select="."/>
</xsl:call-template>
</xsl:when>
<xsl:when test="@type='gallery_thumb' or @type='gallery_image' ">
<xsl:call-template name="galleryThumbItem">
<xsl:with-param name="i" select="."/>
</xsl:call-template>
</xsl:when>
<xsl:when test="@type='link'">
<xsl:call-template name="linkItem">
<xsl:with-param name="l" select="."/>
</xsl:call-template>
</xsl:when>
<xsl:when test="@payment='payment'">
<xsl:call-template name="paymentItem">
<xsl:with-param name="i" select="."/>
</xsl:call-template>
</xsl:when>
<xsl:when test="@type='poll'">
<xsl:call-template name="pollItem">
<xsl:with-param name="i" select="."/>
</xsl:call-template>
</xsl:when>
<xsl:when test="@type='poll_question'">
<xsl:call-template name="pollQuestionItem">
<xsl:with-param name="i" select="."/>
</xsl:call-template>
</xsl:when>
<xsl:when test="@type='person'">
<xsl:call-template name="personItem">
<xsl:with-param name="i" select="."/>
</xsl:call-template>
</xsl:when>
<xsl:when test="@type='order'">
<xsl:call-template name="orderItem">
<xsl:with-param name="o" select="."/>
</xsl:call-template>
</xsl:when>
<xsl:when test="@type='org'">
<xsl:call-template name="orgItem">
<xsl:with-param name="i" select="."/>
</xsl:call-template>
</xsl:when>
<xsl:when test="@type='product'">
<xsl:call-template name="productItem">
<xsl:with-param name="p" select="."/>
</xsl:call-template>
</xsl:when>
<xsl:when test="@type='quote'">
<xsl:call-template name="quoteItem">
<xsl:with-param name="i" select="."/>
</xsl:call-template>
</xsl:when>
<xsl:when test="@type='r_event'">
<xsl:call-template name="recurringEventItem">
<xsl:with-param name="e" select="."/>
</xsl:call-template>
</xsl:when>
<xsl:when test="@type='review'">
<xsl:call-template name="bookItem">
<xsl:with-param name="b" select="book"/>
</xsl:call-template>
</xsl:when>
<xsl:when test="@type='thread'">
<xsl:call-template name="threadItem">
<xsl:with-param name="i" select="."/>
</xsl:call-template>
</xsl:when>
<xsl:when test="@type='tourop'">
<xsl:call-template name="touropItem">
<xsl:with-param name="i" select="."/>
</xsl:call-template>
</xsl:when>
<xsl:when test="@type='tourop_ita'">
<xsl:call-template name="touropItaItem">
<xsl:with-param name="i" select="."/>
</xsl:call-template>
</xsl:when>
<xsl:when test="@type='video'">
<xsl:call-template name="videoItem">
<xsl:with-param name="i" select="."/>
</xsl:call-template>
</xsl:when>
<xsl:when test="@type='widget'">
<xsl:call-template name="widgetItem">
<xsl:with-param name="i" select="."/>
</xsl:call-template>
</xsl:when>
<xsl:when test="@type='web_feed_item'">
<xsl:call-template name="widgetContentItem">
<xsl:with-param name="i" select="."/>
</xsl:call-template>
</xsl:when>
<xsl:otherwise>
<xsl:call-template name="genericItem">
<xsl:with-param name="i" select="."/>
</xsl:call-template>
</xsl:otherwise>
</xsl:choose>
</li>
</xsl:template>


<!-- ###############################
     ITEM
     ############################### -->
<xsl:template mode="fulllist" match="item">
  <li>
    <xsl:if test="position()=last()-1"><xsl:attribute name="class">last</xsl:attribute></xsl:if>
    <div class="breadcrumb icon">
      <xsl:if test="topic and not(/root/topic/@id &gt; 0)">
        <xsl:call-template name="createLink">
          <xsl:with-param name="node" select="topic"/>
          <xsl:with-param name="name" select="topic/@name"/>
        </xsl:call-template>
        <xsl:value-of select="$breadcrumb_separator"/>
      </xsl:if>
      <xsl:apply-templates select="breadcrumb" mode="breadcrumb"/>
    </div>
    <xsl:choose>
      <xsl:when test="@type='article'">
        <xsl:call-template name="articleItem">
          <xsl:with-param name="a" select="."/>
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="@type='event'">
        <xsl:call-template name="eventItem">
          <xsl:with-param name="e" select="."/>
        </xsl:call-template>
      </xsl:when>
    </xsl:choose>
  </li>
</xsl:template>


<!-- ###############################
     ITEM
     ############################### -->
<xsl:template mode="fulllist2" match="item">
  <li>
    <xsl:if test="position()=last()-1"><xsl:attribute name="class">last</xsl:attribute></xsl:if>
    <xsl:call-template name="articleItem">
      <xsl:with-param name="a" select="."/>
      <xsl:with-param name="show_path" select="true()"/>
    </xsl:call-template>
  </li>
</xsl:template>


<!-- ###############################
     ITEM
     ############################### -->
<xsl:template mode="seclist" match="item">
  <li>
    <xsl:choose>
      <xsl:when test="@type='article' and @with_content='0'">
        <xsl:call-template name="articleItem">
          <xsl:with-param name="a" select="."/>
          <xsl:with-param name="show_topic" select="true()"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="@type='article' and @with_content='1'">
        <xsl:call-template name="articleContent">
          <xsl:with-param name="a" select="."/>
        </xsl:call-template>
      </xsl:when>
    </xsl:choose>
  </li>
</xsl:template>


<!-- ###############################
     ITEM
     ############################### -->
<xsl:template mode="contentlist" match="item">
<xsl:param name="showpath" select="false()"/>
<li>
<xsl:if test="position()=last()-1"><xsl:attribute name="class">last</xsl:attribute></xsl:if>
<xsl:if test="/root/topic/@show_path='1'">
<div class="item-breadcrumb">
<xsl:apply-templates select="breadcrumb" mode="breadcrumb"/>
</div>
</xsl:if>
<xsl:call-template name="articleContent">
<xsl:with-param name="a" select="."/>
</xsl:call-template>
</li>
</xsl:template>


<!-- ###############################
     ITEMS
     ############################### -->
<xsl:template name="items">
<xsl:param name="root"/>
<xsl:param name="node"/>
<xsl:param name="showpath" select="false()"/>
<xsl:if test="$root/@tot_items">
<xsl:call-template name="paging">
<xsl:with-param name="currentPage" select="$root/@page"/>
<xsl:with-param name="totalPages" select="$root/@tot_pages"/>
<xsl:with-param name="totalItems" select="$root/@tot_items"/>
<xsl:with-param name="label" select="$root/@label"/>
<xsl:with-param name="type" select="'header'"/>
<xsl:with-param name="node" select="$node"/>
</xsl:call-template>
<ul class="items">
<xsl:choose>
<xsl:when test="$showpath">
<xsl:apply-templates mode="fulllist" select="$root"/>
</xsl:when>
<xsl:otherwise>
<xsl:apply-templates mode="mainlist" select="$root"/>
</xsl:otherwise>
</xsl:choose>
</ul>
<xsl:call-template name="paging">
<xsl:with-param name="currentPage" select="$root/@page"/>
<xsl:with-param name="totalPages" select="$root/@tot_pages"/>
<xsl:with-param name="totalItems" select="$root/@tot_items"/>
<xsl:with-param name="label" select="$root/@label"/>
<xsl:with-param name="type" select="'footer'"/>
<xsl:with-param name="node" select="$node"/>
</xsl:call-template>
</xsl:if>
</xsl:template>


<!-- ###############################
     JAVASCRIPT FORMS
     ############################### -->
<xsl:template name="javascriptForms">
<link type="text/css" rel="stylesheet" href="{/root/site/@base}/js/jquery/css/ui-lightness/jquery-ui-1.8.5.custom.css" media="screen"/>
<script type="text/javascript" src="{/root/site/@base}/js/jquery/jquery-ui-1.8.5.custom.min.js"></script>
<script type="text/javascript" src="{/root/site/@base}/js/jquery/jquery.validate.min.js"></script>
<xsl:if test="$current_lang!='en' and $current_lang!='hi' and $current_lang!='el'">
<script type="text/javascript" src="{/root/site/@base}/js/jquery/i18n/{$current_lang}.js"></script>
</xsl:if>
<script type="text/javascript">
$().ready(function() {
	$.validator.setDefaults({
		errorClass: "invalid",
		errorPlacement: function(error, element) {
			error.insertAfter(element);
			element.parent("li").addClass("invalid");
		}
	})
});
</script>
</xsl:template>


<!-- ###############################
     JAVASCRIPT HEAD
     ############################### -->
<xsl:template name="javascriptHead">
<xsl:if test="$pagetype!='error404'">
<script type="text/javascript" src="{/root/site/@base}/js/tools.js{$js_version}"></script>
<script type="text/javascript" src="{/root/site/@base}/jsc/custom_{/root/publish/@id_language}.js"></script>
</xsl:if>
<script type="text/javascript" src="{/root/site/@assets_domain}/js/0/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="{/root/site/@assets_domain}/js/1/js/main.js"></script>
<xsl:if test="$pagetype='homepage' and /root/publish/@widgets">
<script type="text/javascript" src="{/root/site/@base}/js/widgets/lib.js"></script>
<script type="text/javascript" src="{/root/site/@base}/js/widgets/main.js"></script>
</xsl:if>
<xsl:call-template name="javascriptCustom"/>
</xsl:template>


<!-- ###############################
     KEYWORDS META
     ############################### -->
<xsl:template name="keywordsMeta">
<xsl:choose>
<xsl:when test="$pagetype='homepage'">
<xsl:call-template name="keywords">
<xsl:with-param name="node" select="/root/keywords"/>
</xsl:call-template>
</xsl:when>
<xsl:when test="$pagetype='topic_home'">
<xsl:call-template name="keywords">
<xsl:with-param name="node" select="/root/topic/keywords"/>
</xsl:call-template>
</xsl:when>
<xsl:when test="$pagetype='subtopic'">
<xsl:call-template name="keywords">
<xsl:with-param name="node" select="/root/subtopic/keywords"/>
</xsl:call-template>
</xsl:when>
<xsl:when test="$pagetype='article'">
<xsl:call-template name="keywords">
<xsl:with-param name="node" select="/root/article/keywords"/>
</xsl:call-template>
</xsl:when>
</xsl:choose>
</xsl:template>


<!-- ###############################
     KEYWORDS
     ############################### -->
<xsl:template name="keywords">
<xsl:param name="node"/>
<meta name="keywords">
<xsl:attribute name="content">
<xsl:for-each select="$node/keyword[@id_type != 4]">
<xsl:value-of select="./@name"/>
<xsl:if test="position()!=last()">,</xsl:if>
</xsl:for-each>
</xsl:attribute>
</meta>
</xsl:template>


<!-- ###############################
     LAST UPDATE
     ############################### -->
<xsl:template name="lastUpdate">
<xsl:variable name="lastupdate" select="/root/topic/lastupdate"/>
<xsl:if test="/root/topic/lastupdate">
<div class="last-update">
<xsl:value-of select="$lastupdate/@label"/>: <xsl:value-of select="$lastupdate/@display_date"/><xsl:text> </xsl:text><xsl:value-of select="$lastupdate/@display_time"/>
</div>
</xsl:if>
</xsl:template>


<!-- ###############################
     LEFT BAR
     ############################### -->
<xsl:template name="leftBar">
<xsl:call-template name="navigationMenu"/>
<xsl:call-template name="leftBottom"/>
</xsl:template>


<!-- ###############################
     LICENCE
     ############################### -->
<xsl:template name="licence">
<xsl:param name="i"/>
<xsl:if test="$i/licence">
<div class="licence">
<xsl:if test="$i/licence/@copyright"><div class="copyright"><xsl:value-of select="$i/licence/@copyright" disable-output-escaping="yes"/></div></xsl:if>
<div class="description"><xsl:if test="$i/licence/@id!='9'"><xsl:value-of select="$i/licence/@label"/>: </xsl:if><xsl:value-of select="$i/licence/description" disable-output-escaping="yes"/></div>
</div></xsl:if>
</xsl:template>


<!-- ###############################
     LICENCE INFO
     ############################### -->
<xsl:template name="licenceInfo">
<xsl:param name="i"/>
<xsl:if test="$i/licence">
<div class="licence-info">
<xsl:if test="$i/licence/@copyright"><div class="copyright"><xsl:value-of select="$i/licence/@copyright" disable-output-escaping="yes"/></div></xsl:if>
<h4><xsl:if test="$i/licence/@id!='9'"><xsl:value-of select="$i/licence/@label"/>:  </xsl:if><xsl:value-of select="$i/licence/@name"/></h4>
</div></xsl:if>
</xsl:template>


<!-- ###############################
     LINK ITEM
     ############################### -->
<xsl:template name="linkItem">
<xsl:param name="l"/>
<div><b><xsl:value-of select="$l/@title"/></b></div>
<div>
<xsl:call-template name="createLink">
<xsl:with-param name="name"><xsl:value-of select="$l/@url"/></xsl:with-param>
<xsl:with-param name="node" select="$l"/>
<xsl:with-param name="target" select="'_blank'"/>
</xsl:call-template>
</div>
<div><xsl:value-of select="$l/description" disable-output-escaping="yes"/></div>
</xsl:template>


<!-- ###############################
     LOGIN FIRST
     ############################### -->
<xsl:template name="loginFirst">
<xsl:param name="node"/>
<p class="login-first">
<div class="login-warning"><xsl:value-of select="$node/@label"/></div>
<div class="login-links"><xsl:call-template name="createLink">
<xsl:with-param name="node" select="$node"/>
</xsl:call-template> / 
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="$node/register"/>
</xsl:call-template>
</div>
</p>
</xsl:template>


<!-- ###############################
     MENU ITEM
     ############################### -->
<xsl:template mode="listitem" match="subtopic">
<xsl:param name="level"/>
<xsl:param name="recurse" select="true()"/>
<li id="ms{@id}">
<xsl:if test="@id = /root/subtopic/@id">
<xsl:attribute name="class">selected</xsl:attribute>
</xsl:if>
<xsl:call-template name="createLink">
<xsl:with-param name="name" select="@name"/>
<xsl:with-param name="node" select="."/>
</xsl:call-template>
<xsl:if test="subtopics and $level &lt; $menudepth and $recurse=true()">
<xsl:apply-templates>
<xsl:with-param name="level" select="$level + 1"/>
</xsl:apply-templates>
</xsl:if>
</li>
</xsl:template>


<!-- ###############################
     MENU ITEM / MAP
     ############################### -->
<xsl:template mode="map" match="subtopic">
<li>
<xsl:call-template name="createLink">
<xsl:with-param name="name" select="@name"/>
<xsl:with-param name="node" select="."/>
</xsl:call-template>
<xsl:apply-templates mode="map"/>
</li>
</xsl:template>


<!-- ###############################
     MENU ITEMS
     ############################### -->
<xsl:template match="subtopics">
<xsl:param name="level" select="'1'"/>
<ul>
<xsl:if test="$level=1">
<xsl:attribute name="class">menu</xsl:attribute>
</xsl:if>
<xsl:apply-templates mode="listitem">
<xsl:with-param name="level" select="$level"/>
</xsl:apply-templates>
</ul>
</xsl:template>


<!-- ###############################
     META ROBOTS
     ############################### -->
<xsl:template name="metaRobots">
<xsl:variable name="meta_description">
<xsl:choose>
<xsl:when test="/root/publish/@global='1' and $pagetype='homepage'">
<xsl:value-of select="/root/site/@description"/>
</xsl:when>
<xsl:when test="/root/publish/@global='1'">
<xsl:value-of select="concat(/root/site/@title,' - ',/root/site/@description)"/>
</xsl:when>
<xsl:when test="$pagetype='article'">
<xsl:value-of select="/root/topic/@name"/>
<xsl:if test="/root/article/halftitle!=''"> - <xsl:value-of select="/root/article/halftitle"/></xsl:if>
<xsl:if test="/root/article/subhead!=''"> - <xsl:value-of select="/root/article/subhead"/></xsl:if>
</xsl:when>
<xsl:when test="$pagetype='subtopic'">
<xsl:value-of select="/root/subtopic/@description"/>
<xsl:if test="/root/subtopic/@id_type='2'">
<xsl:if test="/root/subtopic/content/article/halftitle!=''"> - <xsl:value-of select="/root/subtopic/content/article/halftitle"/></xsl:if>
<xsl:if test="/root/subtopic/content/article/subhead!=''"> - <xsl:value-of select="/root/subtopic/content/article/subhead"/></xsl:if>
</xsl:if>
</xsl:when>
<xsl:otherwise>
<xsl:value-of select="/root/topic/@description"/>
</xsl:otherwise>
</xsl:choose>
</xsl:variable>
<meta name="description" content="{$meta_description}"/>

<xsl:if test="$pagetype='article' and /root/article/@show_author='1' and /root/article/author/@name!=''">
<meta name="author" content="{/root/article/author/@name}"/>
</xsl:if>

<xsl:choose>
<xsl:when test="$pagetype='print'">
<meta name="robots" content="noindex,nofollow" />
</xsl:when>
<xsl:when test="$pagetype='events'">
<meta name="robots" content="index,nofollow" />
</xsl:when>
<xsl:otherwise>
<meta name="robots" content="index,follow" />
</xsl:otherwise>
</xsl:choose>

<xsl:if test="/root/site/@fb_app_id!=''">
<meta property="fb:app_id" content="{/root/site/@fb_app_id}"/>
</xsl:if>

<meta property="og:title" content="{$current_page_title}" />
<meta property="og:type">
<xsl:attribute name="content">
<xsl:choose>
<xsl:when test="$pagetype='article'">article</xsl:when>
<xsl:otherwise>website</xsl:otherwise></xsl:choose>
</xsl:attribute>
</meta>

<xsl:if test="$pagetype='article' and /root/article/images/image[@associated='1']">
<meta property="og:image">
<xsl:attribute name="content">
<xsl:call-template name="createLinkUrl">
<xsl:with-param name="node" select="/root/article/images/image[@associated='1']"/>
</xsl:call-template>
</xsl:attribute>
</meta>
<meta property="og:image:width" content="/root/article/images/image[@associated='1']/@width"/>
<meta property="og:image:height" content="/root/article/images/image[@associated='1']/@height"/>
</xsl:if>

<meta property="og:url" content="{/root/page/@url}" />
<meta property="og:site_name" content="{$current_site_name}" />
<meta property="og:description" content="{$meta_description}"/>

</xsl:template>


<!-- ###############################
     NAVIGATION MENU
     ############################### -->
<xsl:template name="navigationMenu">
  <xsl:if test="/root/topic">
    <h2>
      <xsl:call-template name="createLink">
        <xsl:with-param name="node" select="/root/topic"/>
      </xsl:call-template>
    </h2>
    <xsl:apply-templates select="/root/menu/subtopics"/>
    <div class="menu-footer">
      <xsl:apply-templates select="/root/menu/menu_footer"/>
    </div>
  </xsl:if>
</xsl:template>


<!-- ###############################
     PAYMENT ITEM
     ############################### -->
<xsl:template name="paymentItem">
<xsl:param name="i"/>
<h3><xsl:value-of select="$i/description"/></h3>
<div class="description"><xsl:value-of select="concat($i/@payment_type,': ',$i/@currency,' ',$i/@amount)"/></div>
</xsl:template>


<!-- ###############################
     PAYPAL
     ############################### -->
<xsl:template name="paypal">
<xsl:param name="amount"/>
<xsl:param name="params_node"/>
<xsl:param name="email" select="$params_node/param[@name='email']/@value"/>
<xsl:param name="currency"/>
<xsl:param name="description"/>
<xsl:param name="token"/>
<xsl:param name="id_topic"/>
<xsl:param name="subscription" select="false()"/>
<xsl:param name="page_style" select="$params_node/param[@name='page_style']/@value"/>
<xsl:param name="item_number"/>
<xsl:param name="lang_code" select="'gb'"/>
<div id="donation">
<form name="_xclick" action="https://www.paypal.com/cgi-bin/webscr" method="post">
<input type="hidden" value="1" name="no_shipping"/>
<input type="hidden" name="business" value="{$email}"/>
<input type="hidden" name="item_name" value="{$description}"/>
<input type="hidden" name="item_number" value="{$item_number}"/>
<input type="hidden" name="currency_code" value="{$currency}"/>
<input type="hidden" name="lc" value="{$lang_code}"/>
<xsl:if test="$page_style!=''"><input type="hidden" name="page_style" value="{$page_style}"/></xsl:if>
<input type="hidden" name="return" value = "{/root/site/@base}/tools/paypal_return.php?id={$token}&amp;status=T&amp;id_topic={/root/topic/@id}"/>
<input type="hidden" name="cancel_return" value = "{/root/site/@base}/tools/paypal_return.php?id={$token}&amp;status=F&amp;id_topic={/root/topic/@id}"/>
<input type="hidden" name="rm" value="2"/>
<xsl:choose>
<xsl:when test="$subscription">
<input type="hidden" name="cmd" value="_xclick-subscriptions"/>
<input type="hidden" name="a3" value="{$amount}"/>
<input type="hidden" name="p3" value="{$params_node/param[@name='paypal_cycle_length']/@value}"/>
<input type="hidden" name="t3" value="{$params_node/param[@name='paypal_cycle_unit']/@value}"/>
<input type="hidden" value="1" name="no_note"/>
<input type="hidden" name="sra" value="1"/>
<input type="hidden" name="src" value="1"/>
<xsl:if test="$params_node/param[@name='paypal_times']/@value &gt; 0"><input type="hidden" name="srt" value="{$params_node/param[@name='paypal_times']/@value}"/></xsl:if>
<input type="image" src="https://www.paypal.com/en_US/i/btn/x-click-butcc-subscribe.gif" name="submit" alt="Donate with PayPal - it's fast, free and secure!"/>
</xsl:when>
<xsl:otherwise>
<xsl:if test="$amount!=''"><input type="hidden" name="amount" value="{$amount}"/></xsl:if>
<input type="hidden" name="cmd" value="_xclick"/>
<input type="image" src="https://www.paypal.com/en_US/i/btn/x-click-butcc-donate.gif" border="0" name="submit" alt="Donate with PayPal - it's fast, free and secure!"/>
</xsl:otherwise>
</xsl:choose>
</form>
</div>
</xsl:template>


<!-- ###############################
     POLL ITEM
     ############################### -->
<xsl:template name="pollItem">
<xsl:param name="i"/>
<h3>
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="$i"/>
<xsl:with-param name="name" select="$i/@title"/>
</xsl:call-template>
</h3>
<div class="description"><xsl:value-of select="$i/description" disable-output-escaping="yes"/></div>
<xsl:if test="@end_date"><div class="closure"><xsl:value-of select="@end_date"/></div></xsl:if>
<xsl:if test="$i/@active='2'"><div class="notes">(<xsl:value-of select="key('label','poll_over')/@tr"/>)</div></xsl:if>
</xsl:template>


<!-- ###############################
     POLL QUESTION ITEM
     ############################### -->
<xsl:template name="pollQuestionItem">
<xsl:param name="i"/>
<h3>
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="$i"/>
<xsl:with-param name="name" select="$i/@question"/>
</xsl:call-template>
</h3>
<div class="description"><xsl:value-of select="$i/description" disable-output-escaping="yes"/></div>
</xsl:template>


<!-- ###############################
     PRINT
     ############################### -->
<xsl:template name="print">
<li><a target="_blank" rel="nofollow">
<xsl:attribute name="href">
<xsl:choose>
<xsl:when test="$preview='1'">preview.php?id_type=14&amp;id=<xsl:value-of select="/root/article/@id"/>&amp;id_topic=<xsl:value-of select="/root/article/topic/@id"/></xsl:when>
<xsl:otherwise><xsl:value-of select="/root/site/@base"/>/tools/print.php?id=<xsl:value-of select="/root/article/@id"/></xsl:otherwise>
</xsl:choose>
</xsl:attribute>
<xsl:value-of select="key('label','print')/@tr"/></a></li>
</xsl:template>


<!-- ###############################
     PRIVACY WARNING
     ############################### -->
<xsl:template name="privacyWarning">
<xsl:param name="node" select="/root/subtopic/content/privacy_warning"/>
<xsl:call-template name="formInput">
<xsl:with-param name="varname">privacy</xsl:with-param>
<xsl:with-param name="type">checkbox</xsl:with-param>
<xsl:with-param name="tr_label"><xsl:value-of select="$node" disable-output-escaping="yes"/></xsl:with-param>
<xsl:with-param name="value" select="true()"/>
</xsl:call-template>
</xsl:template>


<!-- ###############################
     QUOTE ITEM
     ############################### -->
<xsl:template name="quoteItem">
<xsl:param name="i"/>
<div class="quote">
<p><xsl:value-of select="$i/text" disable-output-escaping="yes"/></p>
<div class="author">(<xsl:value-of select="$i/author/@name"/>
<xsl:if test="$i/author/notes"> - <xsl:value-of select="$i/author/notes" disable-output-escaping="yes"/></xsl:if>)
</div>
</div>
</xsl:template>


<!-- ###############################
     RANDOM QUOTE
     ############################### -->
<xsl:template name="randomQuote">
<xsl:param name="id_div" select="'random_quote'"/>
<xsl:if test="$pagetype!='error404'">
<div class="quote" id="{$id_div}"></div>
<xsl:choose>
<xsl:when test="$async_js=true()">
<script type="text/javascript">
getHttpContent('/js/quote.php?a=1','<xsl:value-of select="$id_div"/>')
</script>
</xsl:when>
<xsl:otherwise>
<div class="quote" id="{$id_div}">
<script type="text/javascript" src="{/root/site/@base}/js/quote.php?div={$id_div}">
</script>
</div>
</xsl:otherwise>
</xsl:choose>
</xsl:if>
</xsl:template>


<!-- ###############################
     RECURRING EVENT ITEM
     ############################### -->
<xsl:template name="recurringEventItem">
<xsl:param name="e"/>
<xsl:value-of select="$e/@year"/>: 
<xsl:choose>
<xsl:when test="$e/@url!=''"><a href="{$e/@url}"><xsl:value-of select="$e/@description"/></a></xsl:when>
<xsl:otherwise><xsl:value-of select="$e/@description"/></xsl:otherwise>
</xsl:choose>
</xsl:template>


<!-- ###############################
     RELATED
     ############################### -->
<xsl:template name="related">
<xsl:param name="items"/>
<xsl:param name="title"/>
<div id="article-related">
<h3 id="related-title"><xsl:value-of select="$title"/></h3>
<ul class="related">
<xsl:apply-templates select="$items" mode="seclist"/>
</ul>
</div>
</xsl:template>


<!-- ###############################
     RIGHT BAR
     ############################### -->
<xsl:template name="rightBar">
<xsl:if test="$pagetype='events'">
<xsl:call-template name="rightBarCalendar"/>
</xsl:if>
<xsl:if test="$pagetype='search'">
<xsl:call-template name="rightBarSearch"/>
</xsl:if>
<xsl:if test="not(/root/topic) or (/root/topic/@show_print='2')">
<!--
<xsl:call-template name="share"/>
-->
</xsl:if>
</xsl:template>


<!-- ###############################
     RSS LOGO
     ############################### -->
<xsl:template name="rssLogo">
<xsl:param name="node"/>
<div id="rss">
<a title="RSS feed">
<xsl:attribute name="href">
<xsl:call-template name="createLinkUrl">
<xsl:with-param name="node" select="$node"/>
</xsl:call-template>
</xsl:attribute>
<img src="{/root/site/@base}/logos/rss.gif" alt="RSS logo"/>
</a>
</div>
</xsl:template>


<!-- ###############################
     RSS PARSE
     ############################### -->
<xsl:template name="rssParse">
<xsl:param name="node"/>
<div class="rss-feed">
<xsl:choose>
<xsl:when test="$node/@version='2.0'">
<h4><a href="{$node/channel/link}"><xsl:value-of select="$node/channel/title"/></a></h4>
<div class="description"><xsl:value-of select="$node/channel/description" disable-output-escaping="yes"/></div>
<ul class="items">
<xsl:for-each select="$node/channel/item">
<li>
<xsl:attribute name="class">article-item<xsl:if test="position()=last()-1"><xsl:text> last</xsl:text></xsl:if></xsl:attribute>
<h3><a href="{link}"><xsl:value-of select="title"/></a></h3>
<div class="description"><xsl:value-of select="description" disable-output-escaping="yes"/></div>
<div class="notes"><xsl:value-of select="pubDate" disable-output-escaping="yes"/> - <xsl:value-of select="creator" disable-output-escaping="yes"/></div>
</li>
</xsl:for-each>
</ul>
</xsl:when>
</xsl:choose>
</div>
</xsl:template>


<!-- ###############################
     RSS LISTER
     ############################### -->
<xsl:template name="rssLister">
<xsl:param name="url"/>
<xsl:param name="title"/>
<xsl:param name="ttl" select="'30'"/>
<xsl:param name="items" select="'15'"/>
<xsl:param name="title_link" select="''"/>
<xsl:if test="$pagetype!='error404'">
<div class="lister-box">
<xsl:if test="$title!=''">
<h3 class="lister-title">
<xsl:choose>
<xsl:when test="$title_link!=''"><a href="{$title_link}"><xsl:value-of select="$title"/></a></xsl:when>
<xsl:otherwise><xsl:value-of select="$title"/></xsl:otherwise>
</xsl:choose>
</h3>
</xsl:if>
<div id="lister-id" class="lister">...</div>
<xsl:choose>
<xsl:when test="$async_js=true()">
<script type="text/javascript">
new rss_lister('<xsl:value-of select="$url"/>',<xsl:value-of select="$ttl"/>,'lister-id',<xsl:value-of select="$items"/>)
</script>
</xsl:when>
<xsl:otherwise>
<script type="text/javascript">
<xsl:attribute name="src"><xsl:value-of select="/root/site/@base"/>/js/rsslister.php?url=<xsl:value-of select="$url"/>&amp;ttl=<xsl:value-of select="$ttl"/>&amp;items=<xsl:value-of select="$items"/>
</xsl:attribute>
</script>
</xsl:otherwise>
</xsl:choose>
</div>
</xsl:if>
</xsl:template>


<!-- ###############################
     RSS TICKER
     ############################### -->
<xsl:template name="rssTicker">
<xsl:param name="url"/>
<xsl:param name="title"/>
<xsl:param name="ttl" select="'30'"/>
<xsl:param name="delay" select="'6000'"/>
<xsl:param name="title_link" select="''"/>
<xsl:param name="show_description" select="'0'"/>
<xsl:param name="div_id" select="'ticker-id'"/>
<xsl:param name="ticker_type" select="'rss'"/>
<xsl:if test="$pagetype!='error404'">
<div class="ticker-box ticker-{$ticker_type}">
<xsl:if test="$title!=''">
<h3 class="ticker-title">
<xsl:choose>
<xsl:when test="$title_link!=''"><a href="{$title_link}"><xsl:value-of select="$title"/></a></xsl:when>
<xsl:otherwise><xsl:value-of select="$title"/></xsl:otherwise>
</xsl:choose>
</h3>
</xsl:if>
<div id="{$div_id}" class="ticker">...</div>
<xsl:choose>
<xsl:when test="$async_js=true()">
<script type="text/javascript">
new rss_ticker('<xsl:value-of select="$url"/>',<xsl:value-of select="$ttl"/>,'<xsl:value-of select="$div_id"/>',<xsl:value-of select="$delay"/>,<xsl:value-of select="$show_description"/>)
</script>
</xsl:when>
<xsl:otherwise>
<script type="text/javascript">
<xsl:attribute name="src"><xsl:value-of select="/root/site/@base"/>/js/rssticker.php?url=<xsl:value-of select="$url"/>&amp;ttl=<xsl:value-of select="$ttl"/>&amp;delay=<xsl:value-of select="$delay"/>&amp;desc=<xsl:value-of select="$show_description"/>&amp;div=<xsl:value-of select="$div_id"/>
</xsl:attribute>
</script>
</xsl:otherwise>
</xsl:choose>
</div>
</xsl:if>
</xsl:template>


<!-- ###############################
     SEARCH BAR
     ############################### -->
<xsl:template name="searchBar">
<div id="search-bar">
<xsl:call-template name="searchForm"/>
</div>
</xsl:template>


<!-- ###############################
     SEARCH FORM
     ############################### -->
<xsl:template name="searchForm">
<xsl:param name="within_topic" select="true()"/>
<xsl:param name="within_group" select="false()"/>
<form method="get" id="search-form" accept-charset="{/root/site/@encoding}">
<xsl:attribute name="action">
<xsl:call-template name="createLinkUrl">
<xsl:with-param name="node" select="/root/site/search"/>
</xsl:call-template>
</xsl:attribute>
<fieldset>
<legend><xsl:value-of select="/root/site/search/@label"/></legend>
<xsl:if test="$preview=true()"><input type="hidden" name="id_type" value="18"/></xsl:if>
<xsl:if test="$within_topic=true()"><input type="hidden" name="id_topic" value="{/root/topic/@id}"/></xsl:if><xsl:if test="$within_group=true()"><input type="hidden" name="id_group" value="{/root/topic/@id_group}"/></xsl:if><input type="submit" value="{/root/site/search/@name}" class="search-submit"/><input type="text" name="q" value="{/root/search/@q}" class="search-input"/></fieldset></form>
</xsl:template>


<!-- ###############################
     SEND FRIEND
     ############################### -->
<xsl:template name="sendFriend">
<li><a rel="nofollow">
<xsl:attribute name="href">
<xsl:choose>
<xsl:when test="$preview='1'">preview.php?id_type=15&amp;id=<xsl:value-of select="/root/article/@id"/>&amp;id_topic=<xsl:value-of select="/root/article/topic/@id"/></xsl:when>
<xsl:otherwise><xsl:value-of select="/root/site/@base"/>/tools/friend.php?id=<xsl:value-of select="/root/article/@id"/></xsl:otherwise>
</xsl:choose>
</xsl:attribute>
<xsl:value-of select="key('label','friend')/@tr"/></a></li>
</xsl:template>


<!-- ###############################
     SHARE
     ############################### -->
<xsl:template name="share">
<div id="share">
<h4><xsl:value-of select="key('label','share')/@tr"/></h4>
<ul>
<li class="digg"><a href="https://digg.com/submit?phase=2&amp;url={/root/page/@url_encoded}&amp;title={$current_page_title}" target="_top">Digg</a></li>
<li class="facebook"><a href="https://www.facebook.com/sharer.php?u={/root/page/@url_encoded}&amp;t={$current_page_title}" target="_top">Facebook</a></li>
<li class="stumbleupon"><a href="https://www.stumbleupon.com/submit?url={/root/page/@url_encoded}&amp;title={$current_page_title}" target="_top">StumbleUpon</a></li>
<li class="delicious"><a href="https://del.icio.us/post?url={/root/page/@url_encoded}&amp;title={$current_page_title}" target="_top">del.icio.us</a></li>
<li class="reddit"><a href="https://reddit.com/submit?url={/root/page/@url_encoded}&amp;title={$current_page_title}" target="_top">Reddit</a></li>
<li class="googlebookmarks"><a href="https://www.google.com/bookmarks/mark?op=edit&amp;bkmk={/root/page/@url_encoded}&amp;title={$current_page_title}" target="_top">Google</a></li>
</ul>
</div>
</xsl:template>


<!-- ###############################
     SUBTOPIC
     ############################### -->
<xsl:template name="subtopic">
<xsl:call-template name="feedback"/>
<xsl:variable name="id_type" select="/root/subtopic/@id_type"/>
<xsl:choose>
<xsl:when test="$id_type='1' or $id_type='3' or ($id_type='9' and /root/subtopic/@id_subitem!='2') or $id_type='10' or $id_type='11' or $id_type='15'">
<xsl:call-template name="items">
<xsl:with-param name="root" select="/root/subtopic/content/items"/>
<xsl:with-param name="node" select="/root/subtopic"/>
<xsl:with-param name="showpath" select="$id_type='3'"/>
</xsl:call-template>
</xsl:when>
<xsl:when test="$id_type='2'">
<xsl:call-template name="articleContent">
<xsl:with-param name="a" select="/root/subtopic/content/article"/>
</xsl:call-template>
</xsl:when>
<xsl:when test="$id_type='4'">
<ul>
<xsl:choose>
<xsl:when test="/root/subtopic/@id_item &gt; 0">
<xsl:apply-templates select="/root/menu/subtopics//subtopic[@id=/root/subtopic/@id_item]" mode="map"/>
</xsl:when>
<xsl:otherwise>
<xsl:apply-templates select="/root/menu/subtopics" mode="map"/>
</xsl:otherwise>
</xsl:choose>
</ul>
</xsl:when>
<xsl:when test="$id_type='5'">
<xsl:call-template name="contact"/>
</xsl:when>
<xsl:when test="$id_type='9' and /root/subtopic/@id_subitem='2'">
<xsl:call-template name="slideshow">
<xsl:with-param name="id" select="/root/subtopic/content/gallery/@id"/>
<xsl:with-param name="width" select="/root/subtopic/content/gallery/@width"/>
<xsl:with-param name="height" select="/root/subtopic/content/gallery/@height"/>
<xsl:with-param name="images" select="/root/subtopic/content/gallery/@xml"/>
<xsl:with-param name="watermark"><xsl:if test="/root/subtopic/content/gallery/@watermark"><xsl:value-of select="/root/subtopic/content/gallery/@watermark"/></xsl:if></xsl:with-param>
<xsl:with-param name="shuffle" select="/root/subtopic/content/gallery/@shuffle"/>
<xsl:with-param name="bgcolor" select="'0x000000'"/>
<xsl:with-param name="jscaptions" select="true()"/>
</xsl:call-template>
<div id="slide-caption" name="slide-caption" class="gallery-image"></div>
</xsl:when>
<xsl:when test="$id_type='13'">
<xsl:call-template name="subtopicInsert"/>
</xsl:when>
<xsl:when test="$id_type='16'">
<xsl:call-template name="subtopicSearch"/>
</xsl:when>
<xsl:when test="$id_type='18'">
<xsl:call-template name="subtopicDynamic"/>
</xsl:when>
</xsl:choose>
</xsl:template>


<!-- ###############################
     SUBTOPIC [MAP]
     ############################### -->
<xsl:template match="subtopic" mode="map">
<li class="subtopic">
<xsl:call-template name="createLink">
<xsl:with-param name="name" select="@name"/>
<xsl:with-param name="node" select="."/>
</xsl:call-template>
<xsl:if test="subtopics">
<ul class="subtopics-map">
<xsl:apply-templates mode="map" select="subtopics"/>
</ul>
</xsl:if>
</li>
</xsl:template>


<!-- ###############################
     SUBTOPIC ITEM
     ############################### -->
<xsl:template name="subtopicItem">
<xsl:param name="s"/>
<xsl:param name="with_children" select="false()"/>
<xsl:param name="with_tags" select="false()"/>
<xsl:if test="$s/image">
<a>
<xsl:attribute name="href">
<xsl:call-template name="createLinkUrl">
<xsl:with-param name="node" select="$s"/>
<xsl:with-param name="title" select="$s/description"/>
</xsl:call-template>
</xsl:attribute>
<img width="{$s/image/@width}" height="{$s/image/@height}" alt="{$s/@name}">
<xsl:attribute name="src">
<xsl:call-template name="createLinkUrl">
<xsl:with-param name="node" select="$s/image"/>
<xsl:with-param name="cdn" select="/root/site/@cdn!=''"/>
</xsl:call-template>
</xsl:attribute>
</img>
</a>
</xsl:if>
<xsl:choose>
<xsl:when test="$with_tags">
<h4>
<xsl:call-template name="createLink">
<xsl:with-param name="name" select="$s/@name"/>
<xsl:with-param name="node" select="$s"/>
</xsl:call-template>
</h4>
</xsl:when>
<xsl:otherwise>
<xsl:call-template name="createLink">
<xsl:with-param name="name" select="$s/@name"/>
<xsl:with-param name="node" select="$s"/>
</xsl:call-template>
</xsl:otherwise>
</xsl:choose>
<xsl:if test="$s/@description"> 
<div class="description"><xsl:value-of select="$s/@description" disable-output-escaping="yes"/></div>
</xsl:if>
<xsl:if test="$with_children">
<ul class="subtopics">
<xsl:apply-templates mode="listitem" select="$s/subtopics"/>
</ul>
</xsl:if>
</xsl:template>


<!-- ###############################
     SUBTOPIC SEARCH
     ############################### -->
<xsl:template name="subtopicSearch">
<form method="get" id="search-topic" accept-charset="{/root/site/@encoding}">
<xsl:attribute name="action">
<xsl:call-template name="createLinkUrl">
<xsl:with-param name="node" select="/root/site/search"/>
</xsl:call-template>
</xsl:attribute>
<fieldset>
<legend><xsl:value-of select="/root/site/search/@name"/></legend>
<xsl:if test="$preview=true()"><input type="hidden" name="id_type" value="18"/></xsl:if>
<input type="hidden" name="id_topic" value="{/root/topic/@id}"/>
<ul class="form-inputs">
<li>
<label for="q"><xsl:value-of select="key('label','text')/@tr"/></label>
<input type="text" id="q" name="q" class="med" value="{/root/search/@q}"/>
</li>
<xsl:if test="/root/subtopic/content/templates">
<li class="funding">
<label for="id_template"><xsl:value-of select="/root/subtopic/content/templates/@label"/></label>
<select name="id_template">
<xsl:for-each select="/root/subtopic/content/templates/template">
<option value="{@id}"><xsl:value-of select="@name"/></option>
</xsl:for-each>
</select>
</li>
</xsl:if>
<li class="buttons"><input type="submit" value="{/root/site/search/@name}"/></li>
</ul>
</fieldset>
</form>
</xsl:template>


<!-- ###############################
     SUBTOPIC (BREADCRUMB ITEM)
     ############################### -->
<xsl:template match="subtopic" mode="breadcrumb">
<xsl:if test="position() &gt; 2"><xsl:value-of select="$breadcrumb_separator"/></xsl:if>
<xsl:call-template name="createLink">
<xsl:with-param name="name" select="@name"/>
<xsl:with-param name="node" select="."/>
<xsl:with-param name="p" select="@page"/>
</xsl:call-template>
</xsl:template>


<!-- ###############################
     THREAD ITEM
     ############################### -->
<xsl:template name="threadItem">
<xsl:param name="i"/>
<div><xsl:value-of select="$i/@insert_date"/></div>
<h3>
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="$i"/>
<xsl:with-param name="name" select="$i/@title"/>
</xsl:call-template>
</h3>
<div><xsl:value-of select="$i/description" disable-output-escaping="yes"/></div>
</xsl:template>


<!-- ###############################
     TOOL BAR
     ############################### -->
<xsl:template name="toolBar">
<xsl:if test="/root/topic/@show_print='1'">
<ul id="tool-bar">
<xsl:call-template name="print"/>
<xsl:call-template name="sendFriend"/>
</ul>
</xsl:if>
</xsl:template>


<!-- ###############################
     TOP BAR
     ############################### -->
<xsl:template name="topBar">
<xsl:if test="/root/topic/page_header"><div id="page-header"><xsl:apply-templates select="/root/topic/page_header"/></div></xsl:if>
<div id="logo">
<a>
<xsl:attribute name="href">
<xsl:call-template name="createLinkUrl">
<xsl:with-param name="node" select="/root/site"/>
</xsl:call-template>
</xsl:attribute>
<xsl:call-template name="graphic">
<xsl:with-param name="id" select="$id_logo"/>
</xsl:call-template>
</a>
</div>
<xsl:call-template name="bannerGroup">
<xsl:with-param name="id" select="'3'"/>
</xsl:call-template>
</xsl:template>


<!-- ###############################
     TOPIC LIST
     ############################### -->
<xsl:template name="topicList">
<xsl:variable name="list" select="/root/topic/lists/list"/>
<xsl:call-template name="rssTicker">
<xsl:with-param name="url" select="$list/@feed"/>
<xsl:with-param name="title" select="$list/@email"/>
<xsl:with-param name="title_link" select="$list/@url"/>
</xsl:call-template>
</xsl:template>


<!-- ###############################
     TOP NAV
     ############################### -->
<xsl:template name="topNav">
<xsl:apply-templates select="/root/c_features/feature[@id_user='0' and @id_function='13']"/>
<xsl:call-template name="searchBar"/>
</xsl:template>


<!-- ###############################
     TRACKING
     ############################### -->
<xsl:template name="tracking">
<xsl:if test="/root/site/@tracking='1' and $pagetype!='error404' ">
<div id="tracking-img">
<script type="text/javascript" src="{/root/site/@base}/js/track.php?id_t={/root/topic/@id}&amp;id_tg={/root/topic/@id_group}&amp;append=1">
</script>
</div>
</xsl:if>
</xsl:template>


<!-- ###############################
     USER INFO
     ############################### -->
<xsl:template name="userInfo">
  <div id="user-info">
    <xsl:choose>
      <xsl:when test="/root/publish/@live='1' ">
        <xsl:call-template name="userItem"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:variable name="url">/js/user.php?a=1<xsl:if test="/root/topic/@profiling='1'">&amp;id_topic=<xsl:value-of select="/root/topic/@id"/></xsl:if></xsl:variable>
        <script type="text/javascript">
  $(function() {
    htmlLoad('user-info','<xsl:value-of select="$url"/>')
  });
        </script>
      </xsl:otherwise>
    </xsl:choose>
  </div>
</xsl:template>


<!-- ###############################
     USER ITEM
     ############################### -->
<xsl:template name="userItem">
<xsl:param name="u" select="/root/user"/>
<xsl:choose>
<xsl:when test="$u/@name!=''">
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="/root/site/people"/>
<xsl:with-param name="name" select="$u/@name"/>
</xsl:call-template>
<xsl:if test="$u/@auth='1'">
<div id="user-auth"><xsl:call-template name="createLink">
<xsl:with-param name="node" select="/root/site/people/logout"/>
<xsl:with-param name="name" select="'Logout'"/>
</xsl:call-template></div>
</xsl:if>
</xsl:when>
<xsl:otherwise>
<div id="user-links">
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="/root/site/people/login"/>
<xsl:with-param name="name" select="/root/site/people/login/@label"/>
</xsl:call-template>
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="/root/site/people/register"/>
<xsl:with-param name="name" select="/root/site/people/register/@label"/>
</xsl:call-template>
</div>
</xsl:otherwise>
</xsl:choose>
</xsl:template>


<!-- ###############################
     VIDEO BOX
     ############################### -->
<xsl:template name="videoBox">
<xsl:param name="i"/>
<xsl:if test="$i/thumb">
<div class="video-box">
<a title="Video: {$i/@title}">
<xsl:attribute name="href">
<xsl:call-template name="createLinkUrl">
<xsl:with-param name="node" select="$i"/>
</xsl:call-template>
</xsl:attribute>
<img width="{$i/thumb/@width}" class="left">
<xsl:attribute name="src">
<xsl:call-template name="createLinkUrl">
<xsl:with-param name="node" select="$i/thumb"/>
<xsl:with-param name="cdn" select="/root/site/@cdn!=''"/>
</xsl:call-template>
</xsl:attribute>
</img>
</a>
</div>
</xsl:if>
</xsl:template>


<!-- ###############################
     VIDEO ITEM
     ############################### -->
<xsl:template name="videoItem">
<xsl:param name="i"/>
<xsl:if test="$i/thumb">
<a>
<xsl:attribute name="href">
<xsl:call-template name="createLinkUrl">
<xsl:with-param name="node" select="$i"/>
</xsl:call-template>
</xsl:attribute>
<img width="{$i/thumb/@width}" class="left">
<xsl:attribute name="src">
<xsl:call-template name="createLinkUrl">
<xsl:with-param name="node" select="$i/thumb"/>
<xsl:with-param name="cdn" select="/root/site/@cdn!=''"/>
</xsl:call-template>
</xsl:attribute>
</img>
</a>
</xsl:if>
<div class="item-date"><xsl:value-of select="$i/@date"/></div>
<h3>
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="$i"/>
<xsl:with-param name="name" select="$i/@title"/>
</xsl:call-template>
</h3>
<xsl:if test="$i/@author"><div class="item-author"><xsl:value-of select="$i/@author"/></div></xsl:if>
<xsl:if test="$i/@length"><div class="item-length"><xsl:value-of select="$i/@length"/></div></xsl:if>
</xsl:template>


<!-- ###############################
     VIDEO NODE
     ############################### -->
<xsl:template name="videoNode">
<xsl:param name="node"/>
<xsl:param name="autostart" select="$node/@auto_start='1'"/>
<xsl:if test="$node/@hash">
<xsl:variable name="video_xml">
<xsl:call-template name="createLinkUrl">
<xsl:with-param name="node" select="$node/xml"/>
</xsl:call-template>
</xsl:variable>
<xsl:variable name="mediaplayer"><xsl:if test="/root/topic/@domain and /root/publish/@static='1' and $preview=false()"><xsl:value-of select="/root/site/@base"/></xsl:if>/tools/mediaplayer.swf</xsl:variable>
<div class="video-box" id="video-{$node/@id}">
<div id="vid-{$node/@id}"><p class="flash-warning"><xsl:value-of select="key('label','flash_warning')/@tr" disable-output-escaping="yes"/></p></div>
<script type="text/javascript">
var flashvars = {};
flashvars.file = encodeURIComponent('<xsl:value-of select="$video_xml"/>');
<xsl:if test="$node/@link">
flashvars.link = encodeURIComponent('<xsl:value-of select="$node/@link"/>');
flashvars.linkfromdisplay = 'true';
</xsl:if>
<xsl:if test="$autostart=true()">
flashvars.autostart = 'true';
</xsl:if>
var params = {};
params.allowfullscreen = 'true';
params.wmode = "opaque";
var attributes = {};
attributes.id = 'vid-<xsl:value-of select="$node/@id"/>';
swfobject.embedSWF('<xsl:value-of select="$mediaplayer"/>','vid-<xsl:value-of select="$node/@id"/>','<xsl:value-of select="$node/@width"/>','<xsl:value-of select="$node/@height"/>','<xsl:value-of select="/root/publish/@flash_version"/>',false,flashvars,params,attributes);
</script>
</div>
</xsl:if>
</xsl:template>


</xsl:stylesheet>
