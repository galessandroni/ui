<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"><xsl:import href="../0/article.xsl" />

<xsl:output method="html" encoding="UTF-8" indent="no" doctype-system="http://www.w3.org/TR/html4/strict.dtd"  doctype-public="-//W3C//DTD HTML 4.01//EN" />

<xsl:include href="common.xsl" />



<!-- ###############################
ARTICLE CONTENT
############################### -->
<xsl:template name="articleContent">
<xsl:param name="a" select="/root/article"/>
<div id="article-content">
<xsl:attribute name="class">text-<xsl:value-of select="$a/@text-align"/></xsl:attribute>

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



<xsl:if test="$a/books">
<xsl:call-template name="articleBooks">
<xsl:with-param name="node" select="$a/books"/>
</xsl:call-template>
</xsl:if>

<xsl:call-template name="licence">
<xsl:with-param name="i" select="$a"/>
</xsl:call-template>

</xsl:otherwise>
</xsl:choose>
</div>
</xsl:template>




<!-- ###############################
     RIGHT BAR
     ############################### -->
<xsl:template name="rightBar">

<xsl:param name="a" select="/root/article"/>

<xsl:variable name="f1" select="/root/features/feature[@id='139']"/>
<!-- ### tutte le news #### -->
<xsl:variable name="f2" select="/root/c_features/feature[@id='137']"/>
<!-- ### chi siamo #### -->
<xsl:variable name="f3" select="/root/c_features/feature[@id='140']"/>
<!-- ### t onino bello #### -->
<xsl:variable name="f4" select="/root/c_features/feature[@id='141']"/>
<!-- ### attivita #### -->
<xsl:variable name="f5" select="/root/c_features/feature[@id='142']"/>
<!-- ### punti di pace #### -->
<xsl:variable name="f6" select="/root/c_features/feature[@id='143']"/>
<!-- ### tematiche #### -->
<xsl:variable name="f7" select="/root/c_features/feature[@id='144']"/>

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

<xsl:when  test="/root/article/breadcrumb/subtopic/@id='489'">
<h3 class="feature"><xsl:value-of select="$f3/@name"/></h3>
<ul class="items">
<xsl:apply-templates select="$f3/items" mode="mainlist"/>
</ul>
</xsl:when>
<xsl:when  test="/root/article/breadcrumb/subtopic/@id='497'">
<h3 class="feature"><xsl:value-of select="$f4/@name"/></h3>
<ul class="items">
<xsl:apply-templates select="$f4/items" mode="mainlist"/>
</ul>
</xsl:when>
<xsl:when  test="/root/article/breadcrumb/subtopic/@id='491'">
<h3 class="feature"><xsl:value-of select="$f5/@name"/></h3>
<ul class="items">
<xsl:apply-templates select="$f5/items" mode="mainlist"/>
</ul>
</xsl:when>
<xsl:when  test="/root/article/breadcrumb/subtopic/@id='513'">
<h3 class="feature"><xsl:value-of select="$f6/@name"/></h3>
<ul class="items">
<xsl:apply-templates select="$f6/items" mode="mainlist"/>
</ul>
</xsl:when>
<xsl:when  test="/root/article/breadcrumb/subtopic/@id='3251'">
<h3 class="feature"><xsl:value-of select="$f7/@name"/></h3>
<ul class="items">
<xsl:apply-templates select="$f7/items" mode="mainlist"/>
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


<xsl:call-template name="articleContentNotes">
<xsl:with-param name="a" select="$a"/>
</xsl:call-template>

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


</xsl:template>


<!-- ###############################
ARTICLE CONTENT NOTES
############################### -->
<xsl:template name="articleContentNotes">
<xsl:param name="a"/>
<xsl:if test="string-length($a/notes) &gt; 9">
<div class="article-notes"><h3><xsl:value-of select="key('label','notes')/@tr"/></h3> <xsl:value-of select="$a/notes" disable-output-escaping="yes"/></div>
</xsl:if>
</xsl:template>


<!-- ###############################
CONTENT
############################### -->
<xsl:template name="content">
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
<div class="share-tool">
<xsl:call-template name="toolBar" />
<xsl:call-template name="share"/></div>
<xsl:call-template name="breadcrumb" />
<xsl:call-template name="articleContent" />
</xsl:otherwise>
</xsl:choose>
</xsl:template>

<!-- ###############################
TOOL BAR
############################### -->
<xsl:template name="toolBar">
<xsl:if test="/root/topic/@show_print='1'">
<ul id="tool-bar">
<div class="print"><xsl:call-template name="print"/></div>
<div class="send"><xsl:call-template name="sendFriend"/></div>
</ul>
</xsl:if>
</xsl:template>

<!-- ###############################
SHARE
############################### -->
<xsl:template name="share">
<div id="share">
<h4><xsl:value-of select="key('label','share')/@tr"/></h4>
<ul>
<li class="digg"><a href="http://digg.com/submit?phase=2&amp;url={/root/page/@url_encoded}&amp;title={$current_page_title}"></a></li>
<li class="facebook"><a href="http://www.facebook.com/sharer.php?u={/root/page/@url_encoded}&amp;t={$current_page_title}"></a></li>
<li class="stumbleupon"><a href="http://www.stumbleupon.com/submit?url={/root/page/@url_encoded}&amp;title={$current_page_title}"></a></li>
<li class="delicious"><a href="http://del.icio.us/post?url={/root/page/@url_encoded}&amp;title={$current_page_title}"></a></li>
<li class="reddit"><a href="http://reddit.com/submit?url={/root/page/@url_encoded}&amp;title={$current_page_title}"></a></li>
<li class="googlebookmarks"><a href="http://www.google.com/bookmarks/mark?op=edit&amp;bkmk={/root/page/@url_encoded}&amp;title={$current_page_title}"></a></li>
</ul>
</div>
</xsl:template>



</xsl:stylesheet>
