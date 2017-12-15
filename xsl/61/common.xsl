<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:include href="root.xsl" />
<xsl:include href="tools.xsl" />


<!-- ###############################
     RIGHT BAR PCK
     ############################### -->
<xsl:template name="rightBarPck">
<div id="gdppdf">
<xsl:apply-templates select="/root/c_features/feature[@id='90']" />
</div>
<xsl:choose>
<xsl:when test="$pagetype='events'">
<xsl:call-template name="rightBarCalendar"/>
</xsl:when>
<xsl:otherwise>
<!-- RIGHT BAR generica -->
<xsl:if test="$pagetype!='error404'">
<div id="podcast"><xsl:apply-templates select="/root/c_features/feature[@id='88']" /></div>
<xsl:call-template name="gdpVideo">
<xsl:with-param name="id_feature" select="92"/>
<xsl:with-param name="id_feature_dida" select="93"/>
</xsl:call-template>

<div class="pckbox">
<xsl:variable name="f" select="/root/c_features/feature[@id='94']"/>
<h3 class="feature">Ultime novita'</h3>
<ul class="items">
<xsl:apply-templates select="$f/items" mode="mainlist"/>
</ul>
</div>


<xsl:call-template name="geoSearchPck"/>
<xsl:call-template name="bannerGroup">
<xsl:with-param name="id" select="'19'"/>
</xsl:call-template>
<xsl:call-template name="nextEventsPck"/>
<xsl:call-template name="gallerie"/>
</xsl:if>
</xsl:otherwise>
</xsl:choose>
</xsl:template>


<!-- ###############################
     LEFT BOTTOM
     ############################### -->
<xsl:template name="leftBottom">
<xsl:call-template name="gdpVideo">
<xsl:with-param name="id_feature" select="100"/>
<xsl:with-param name="id_feature_dida" select="101"/>
</xsl:call-template>
<xsl:call-template name="gdpVideo">
<xsl:with-param name="id_feature" select="110"/>
<xsl:with-param name="id_feature_dida" select="109"/>
</xsl:call-template>
</xsl:template>


<!-- ###############################
     GDP VIDEO
     ############################### -->
<xsl:template name="gdpVideo">
<xsl:param name="id_feature"/>
<xsl:param name="id_feature_dida"/>
<xsl:variable name="hash" 
select="/root/c_features/feature[@id=$id_feature]/items/item/content"/>
<div class="gdpbox">
<h3 class="feature"><a href="http://it.youtube.com/Casaperlanonviolenza" title="Clicca per vedere tutti i video della Casa per la Nonviolenza">VIDEO</a></h3>
<object width="170" height="150"><param name="movie" value="http://it.youtube.com/v/{$hash}&amp;hl=it&amp;showsearch=0"/><param name="wmode" value="transparent"/><embed src="http://it.youtube.com/v/{$hash}&amp;hl=it&amp;showsearch=0" type="application/x-shockwave-flash" wmode="transparent" width="170" height="150"></embed></object>
<div id="video-dida"><a href="http://it.youtube.com/watch?v={$hash}" title="Clicca per vedere il video su YouTube" target="_blank"><xsl:value-of select="/root/c_features/feature[@id=$id_feature_dida]/items/item/content"  disable-output-escaping="yes"/></a></div>
</div>
<!--
<iframe id="videos_list" name="videos_list" src="http://www.youtube.com/videos_list?user=Casaperlanonviolenza" scrolling="auto" width="180" height="300" frameborder="0" marginheight="0" marginwidth="0"></iframe>
-->

</xsl:template>

</xsl:stylesheet>

