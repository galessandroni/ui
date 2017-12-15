<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:include href="root.xsl" />
<xsl:include href="tools.xsl" />

<xsl:variable name="id_sublevel">
<xsl:choose>
<xsl:when test="$pagetype='subtopic'"><xsl:value-of select="/root/subtopic/breadcrumb/subtopic/@id"/></xsl:when>
<xsl:when test="$pagetype='article'"><xsl:value-of select="/root/article/breadcrumb/subtopic/@id"/></xsl:when>
</xsl:choose>
</xsl:variable>


<!-- ###############################
ITEM
############################### -->
<xsl:template mode="pxlist" match="item">
<xsl:param name="breadcrumb" select="false()"/>
<li>
<xsl:if test="position()=last()-1"><xsl:attribute name="class">last</xsl:attribute></xsl:if>
<xsl:call-template name="articleItem">
<xsl:with-param name="a" select="."/>
</xsl:call-template>
<xsl:if test="$breadcrumb">
<div class="item-breadcrumb">
<xsl:apply-templates select="breadcrumb" mode="breadcrumb"/>
</div>
</xsl:if>
</li>
</xsl:template>


<!-- ###############################
     TOP BAR PCK
     ############################### -->
<xsl:template name="topBarPck">
<div id="logo">
<a title="Homepage Immi">
<xsl:attribute name="href">
<xsl:call-template name="createLinkUrl">
<xsl:with-param name="node" select="/root/topic"/>
</xsl:call-template>
</xsl:attribute>
<xsl:call-template name="graphic">
<xsl:with-param name="id" select="257"/>
</xsl:call-template>
</a>
</div>
</xsl:template>


<!-- ###############################
TOP NAV PCK
############################### -->
<xsl:template name="topNavPck">
<ul id="main-menu">
<xsl:for-each select="/root/menu/subtopics/subtopic">
<li>
<xsl:if test="@id=$id_sublevel">
<xsl:attribute name="class">selected</xsl:attribute>
</xsl:if>
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="."/>
</xsl:call-template>
</li>
</xsl:for-each>
</ul>
</xsl:template>


<!-- ###############################
     LEFT BAR PCK
     ############################### -->
<xsl:template name="leftBarPck">
<xsl:call-template name="navigationMenu"/>
<xsl:call-template name="leftBottom"/>
</xsl:template>


<!-- ###############################
     LEFT BAR PX
     ############################### -->
<xsl:template name="leftBarPx">
<div id="px-main">
<xsl:call-template name="articleItem">
<xsl:with-param name="a" select="/root/c_features/feature[@id='85']/items/item" />
</xsl:call-template>
</div>
<!-- libri -->
</xsl:template>


<!-- ###############################
NAVIGATION MENU
############################### -->
<xsl:template name="navigationMenu">
<xsl:choose>
<xsl:when test="$id_sublevel &gt; 0">
<h2>
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="/root/menu/subtopics/subtopic[@id=$id_sublevel]"/>
</xsl:call-template>
</h2>
<xsl:apply-templates select="/root/menu/subtopics/subtopic[@id=$id_sublevel]"/>
</xsl:when>
<xsl:otherwise>
<xsl:call-template name="leftBarPx"/>
</xsl:otherwise>
</xsl:choose>
<div id="pxlogos">
<a title="" href="">
<xsl:call-template name="graphic">
<xsl:with-param name="id" select="231"/>
</xsl:call-template>
</a>
<a title="" href="">
<xsl:call-template name="graphic">
<xsl:with-param name="id" select="232"/>
</xsl:call-template>
</a>
</div>
<div class="menu-footer">
<xsl:apply-templates select="/root/menu/menu_footer"/>
</div>
<xsl:call-template name="rssLogo">
<xsl:with-param name="node" select="/root/topic/rss"/>
</xsl:call-template>
</xsl:template>


<!-- ###############################
     RIGHT BAR PCK
     ############################### -->
<xsl:template name="rightBarPck">
<!-- Agenda -->
<div id="agenda">
<xsl:apply-templates select="/root/c_features/feature[@id='84']" />
</div>

<!-- Search -->
<xsl:call-template name="searchPck"/>

<!-- Edupace -->
<div id="edupace">
<a title="">
<xsl:attribute name="href">
<xsl:call-template name="createLinkUrl">
<xsl:with-param name="node" select="/root/menu//subtopic[@id=1058]"/>
</xsl:call-template>
</xsl:attribute>
<xsl:call-template name="graphic">
<xsl:with-param name="id" select="234"/>
</xsl:call-template>
<h3></h3>
</a>
</div>

<!-- Campagne -->

<!-- 5x1000 -->

<!-- SBL -->
<div id="sbl">
<a title="" href="">
<xsl:call-template name="graphic">
<xsl:with-param name="id" select="233"/>
</xsl:call-template>
<h3></h3>
</a>
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
<input type="hidden" name="id_topic" value="{/root/topic/@id}"/>
<input type="text" name="q" value="{/root/search/@q}" class="search-input"/>
<input type="submit" value="{/root/site/search/@name}" class="search-submit"/>
</fieldset>
</form>
</xsl:template>


<!-- ###############################
     BOTTOM BAR PCK
     ############################### -->
<xsl:template name="bottomBarPck">
<xsl:apply-templates select="/root/c_features/feature[@id='83']" />
</xsl:template>

</xsl:stylesheet>
