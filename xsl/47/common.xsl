<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:include href="root.xsl" />
<xsl:include href="tools.xsl" />

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

<xsl:if test="$a/docs">
<xsl:call-template name="articleDocsTemplate">
<xsl:with-param name="docs" select="$a/docs"/>
</xsl:call-template>
</xsl:if>

<xsl:call-template name="articleContentNotes">
<xsl:with-param name="a" select="$a"/>
</xsl:call-template>

<xsl:if test="$a/@id_template">
<xsl:call-template name="articleContentTemplate">
<xsl:with-param name="a" select="$a"/>
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
ARTICLE DOCS TEMPLATE
############################### -->
<xsl:template name="articleDocsTemplate">
<xsl:param name="docs"/>
<xsl:if test="$docs/@id_article!=37 and $docs/@id_article!=35 and $docs/@id_article!=5">
<ol class="documents-list">
<xsl:for-each select="$docs/doc">
<xsl:sort select="@id" data-type="number" order="ascending"/>
<li>
<xsl:if test="@author!=''"><div class="doc-author"><xsl:value-of select="@author"/></div></xsl:if>

<h3>
<xsl:call-template name="createLink">
<xsl:with-param name="name" select="@title"/>
<xsl:with-param name="node" select="."/>
</xsl:call-template>
</h3>

<div class="file-info">(In formato <xsl:call-template name="uppercase"><xsl:with-param name="text" select="file_info/@format"/></xsl:call-template> - <xsl:value-of select="concat(file_info/@kb,' Kb')"/>)
</div>

<xsl:if test="description!=''"><em><xsl:value-of select="description" disable-output-escaping="yes"/></em></xsl:if>

</li>
</xsl:for-each>
</ol>
</xsl:if>
</xsl:template>



</xsl:stylesheet>
