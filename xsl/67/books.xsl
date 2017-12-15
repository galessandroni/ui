<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="../0/books.xsl" />

<xsl:output method="html" encoding="UTF-8" indent="no" doctype-system="http://www.w3.org/TR/html4/strict.dtd"  doctype-public="-//W3C//DTD HTML 4.01//EN" />

<xsl:include href="common.xsl" />


<!-- ###############################
CONTENT
############################### -->
<xsl:template name="content">
<xsl:call-template name="bookBreadcrumb"/>
<xsl:call-template name="feedback"/>
<div id="books-content">
<xsl:choose>
<xsl:when test="$subtype='home'">
<xsl:call-template name="bookSearch"/>
<xsl:choose>
<xsl:when test="/root/books/@hometype='0'">
<ul class="publishers">
<xsl:apply-templates select="/root/books" mode="listitem"/>
</ul>
</xsl:when>
<xsl:when test="/root/books/@hometype='1'">
<xsl:apply-templates select="/root/books"/>
</xsl:when>
<xsl:when test="/root/books/@hometype='2'">
<ul class="items">
<xsl:apply-templates select="/root/books" mode="mainlist"/>
</ul>
</xsl:when>
</xsl:choose>
</xsl:when>
<xsl:when test="$subtype='publisher'">
<xsl:apply-templates select="/root/books/publisher"/>
</xsl:when>
<xsl:when test="$subtype='category'">
<xsl:apply-templates select="/root/books/publisher/categories/category[@is_selected='1']"/>
</xsl:when>
<xsl:when test="$subtype='book'">
<xsl:apply-templates select="/root/books/book"/>
</xsl:when>
<xsl:when test="$subtype='reviews'">
<xsl:apply-templates select="/root/books/book" mode="reviews"/>
</xsl:when>
<xsl:when test="$subtype='search'">
<xsl:call-template name="items">
<xsl:with-param name="root" select="/root/books/search/books"/>
<xsl:with-param name="node" select="/root/books/search"/>
</xsl:call-template>
<xsl:call-template name="bookSearch"/>
</xsl:when>
<xsl:when test="$subtype='review_insert'">
<xsl:call-template name="reviewInsert"/>
</xsl:when>
</xsl:choose>
</div>
</xsl:template>



<!-- ###############################
     RIGHT BAR
     ############################### -->
<xsl:template name="rightBar">
<xsl:param name="a" select="/root/subtopic/content/article"/>
<div class="bordobox">
<xsl:apply-templates select="/root/c_features/feature[@id='156']" /></div>


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


</xsl:stylesheet>
