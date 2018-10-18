<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:include href="root.xsl" />
<xsl:include href="tools.xsl" />


<!-- ###############################
     TOPIC LATEST
     ############################### -->
<xsl:template name="topicLatest">
  <div id="topic-latest" class="pckbox">
    <xsl:choose>
      <xsl:when test="/root/publish/@live='1'">
        <xsl:if test="/root/c_features/feature[@id='32']/items">
          <xsl:apply-templates select="/root/c_features/feature[@id='32']"/>
        </xsl:if>
      </xsl:when>
      <xsl:otherwise>aja
        <script type="text/javascript">
  $(function() {
    htmlLoad('topic-latest','/js/feature.php?id=32&amp;transform',true)
  });
        </script>
      </xsl:otherwise>
    </xsl:choose>
  </div>
</xsl:template>


<!-- ###############################
     ARTICLE FOOTER
     ############################### -->
<xsl:template name="articleFooter">
  <xsl:param name="a"/>
  <xsl:if test="/root/features/feature[@id='33']/items">
    <div class="pckbox" id="similar">
      <h3 class="feature"><xsl:value-of select="/root/features/feature[@id='33']/@name"/></h3>
      <ul class="items">
        <xsl:apply-templates select="/root/features/feature[@id='33']/items" mode="mainlist"/>
      </ul>
    </div>
  </xsl:if>
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
<div class="title">
<xsl:call-template name="createLink">
<xsl:with-param name="name" select="@title"/>
<xsl:with-param name="node" select="."/>
</xsl:call-template>
(<xsl:value-of select="concat(file_info/@kb,' Kb - ',key('label','format')/@tr,' ',file_info/@format,')')"/>
</div>
<xsl:if test="@author!='' or source!=''"><div class="notes"><xsl:value-of select="@author"/>
<xsl:if test="source!=''"><xsl:value-of select="concat(' - ',key('label','source')/@tr,': ')"/><xsl:value-of select="source" disable-output-escaping="yes"/></xsl:if></div></xsl:if>
<xsl:if test="description!=''"><div><xsl:value-of select="description" disable-output-escaping="yes"/></div></xsl:if>
<xsl:call-template name="licenceInfo">
<xsl:with-param name="i" select="."/>
</xsl:call-template>
</li>
</xsl:for-each>
</ul>
</div>
</xsl:template>


</xsl:stylesheet>
