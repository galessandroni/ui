<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html" encoding="UTF-8" indent="no" />
 
<xsl:include href="common.xsl" />

<xsl:param name="action" select="'subtopic'"/>
<xsl:param name="chapter_id" select="0"/>

<xsl:variable name="ebook_uid" select="concat(/root/publish/@pub_web,'/ebooks/',/root/ebook/@id)"/>

<!-- ###############################
 ROOT
 ############################### -->
<xsl:template match="/">
	<xsl:choose>
		<xsl:when test="$action='article'">
			<xsl:call-template name="articleToEbook"/>
		</xsl:when>
		<xsl:when test="$action='subtopic'">
			<xsl:call-template name="subtopicToEbook"/>
		</xsl:when>
		<xsl:when test="$action='opf'">
			<xsl:call-template name="ebookOPF"/>
		</xsl:when>
		<xsl:when test="$action='tocncx'">
			<xsl:call-template name="ebookTOCNCX"/>
		</xsl:when>
		<xsl:when test="$action='cover'">
			<xsl:call-template name="ebookCover"/>
		</xsl:when>
		<xsl:when test="$action='title'">
			<xsl:call-template name="ebookTitle"/>
		</xsl:when>
		<xsl:when test="$action='xpgt'">
			<xsl:call-template name="ebookXPGT"/>
		</xsl:when>
		<xsl:when test="$action='chapter'">
			<xsl:call-template name="ebookChapter">
				<xsl:with-param name="id" select="$chapter_id"/>
			</xsl:call-template>
		</xsl:when>
	</xsl:choose>
</xsl:template>


<!-- ###############################
 EBOOK OPF
 ############################### -->
<xsl:template name="ebookOPF">
<package xmlns="http://www.idpf.org/2007/opf" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" unique-identifier="bookid" version="2.0">
	<metadata xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:opf="http://www.idpf.org/2007/opf">
		<dc:title><xsl:value-of select="/root/book/@title"/></dc:title> 
		<dc:creator><xsl:value-of select="/root/book/@author"/></dc:creator>
		<dc:language xsi:type="dcterms:RFC3066"><xsl:value-of select="/root/book/@lang_code"/></dc:language> 
		<dc:identifier id="bookid">urn:uuid:<xsl:value-of select="$ebook_uid"/></dc:identifier>
		<dc:rights><xsl:value-of select="/root/ebook/@rights"/></dc:rights> 
		<dc:publisher><xsl:value-of select="/root/book/publisher/@name"/></dc:publisher> 
		<xsl:if test="/root/book/summary != ''">
			<dc:description><xsl:value-of select="/root/book/summary"/></dc:description> 
		</xsl:if>
		<xsl:if test="/root/book/keywords != ''">
			<dc:subject>
				<xsl:for-each select="/root/book/keywords/keyword[@id_type != 4]">
					<xsl:value-of select="./@name"/>
					<xsl:if test="position()!=last()">,</xsl:if>
				</xsl:for-each>
			</dc:subject> 
		</xsl:if>
	<xsl:if test="/root/book/image">
		<meta name="cover" content="cover-image"/>
	</xsl:if>
	</metadata>
	<manifest xmlns:opf="http://www.idpf.org/2007/opf">
		<item id="ncx" href="toc.ncx" media-type="text/xml"/>
		<item id="style" href="stylesheet.css" media-type="text/css"/>
		<item id="pagetemplate" href="page-template.xpgt" media-type="application/vnd.adobe-page-template+xml"/>
		<xsl:if test="/root/book/image">
			<item id="cover" href="cover.html" media-type="application/xhtml+xml"/>
			<item id="cover-image" href="images/cover.jpg" media-type="image/jpeg"/>
		</xsl:if>
		<item id="titlepage" href="title_page.html" media-type="application/xhtml+xml"/>
		<xsl:for-each select="/root/articles/article">
			<item id="chapter{@id}" href="chapter{@id}.html" media-type="application/xhtml+xml"/>
		</xsl:for-each>
		<xsl:for-each select="/root/articles/article/images/image">
			<item id="image_a{../@id_article}_i{@id}" href="images/a{../@id_article}_i{@id}.{/root/publish/@image_format}" media-type="{/root/publish/@image_mimetype}"/>
		</xsl:for-each>
	</manifest>
	<spine toc="ncx">
		<xsl:if test="/root/book/image">
			<itemref idref="cover" linear="no"/>
		</xsl:if>
		<itemref idref="titlepage"/>
		<xsl:for-each select="/root/articles/article">
			<itemref idref="chapter{@id}"/>
		</xsl:for-each>
	</spine>
	<xsl:if test="/root/book/image">
		<guide>
			<reference href="cover.html" type="cover" title="Cover"/>
		</guide>
	</xsl:if>
</package>
</xsl:template>


<!-- ###############################
 EBOOK CHAPTER
 ############################### -->
<xsl:template name="ebookChapter">
<xsl:param name="id"/>
<xsl:variable name="a" select="/root/articles/article[@id=$id]"/>
<html>
<head>
<title><xsl:value-of select="$a/headline"/></title>
<link href="stylesheet.css" type="text/css" rel="stylesheet" />
<link rel="stylesheet" type="application/vnd.adobe-page-template+xml" href="page-template.xpgt"/>
</head>
<body class="chapter">
<xsl:call-template name="chapterHeader">
<xsl:with-param name="a" select="$a"/>
</xsl:call-template>
<xsl:call-template name="articleContent">
<xsl:with-param name="a" select="$a"/>
</xsl:call-template>
<xsl:call-template name="chapterFooter">
<xsl:with-param name="a" select="$a"/>
</xsl:call-template>
</body>
</html>
</xsl:template>


<!-- ###############################
 EBOOK COVER
 ############################### -->
<xsl:template name="ebookCover">
<html>
<head>
<title>Cover</title>
<link href="stylesheet.css" type="text/css" rel="stylesheet" />
</head>
<body class="cover">
<div id="cover-image">
<img src="images/cover.jpg" alt="{/root/book/@title}"/>
</div>
</body>
</html>
</xsl:template>


<!-- ###############################
 EBOOK TITLE
 ############################### -->
<xsl:template name="ebookTitle">
<html>
<head>
<title><xsl:value-of select="/root/book/@title"/></title>
<link href="stylesheet.css" type="text/css" rel="stylesheet" />
<link rel="stylesheet" type="application/vnd.adobe-page-template+xml" href="page-template.xpgt"/>
</head>
<body class="title">
<h1><xsl:value-of select="/root/book/@title"/></h1>
<h2>by: <xsl:value-of select="/root/book/@author"/></h2>
</body>
</html>
</xsl:template>


<!-- ###############################
 EBOOK TOC NCX
 ############################### -->
<xsl:template name="ebookTOCNCX">
<ncx xmlns="http://www.daisy.org/z3986/2005/ncx/" version="2005-1">
  <head>
    <meta name="dtb:uid" content="$ebook_uid"/>
    <meta name="dtb:depth" content="1"/>
    <meta name="dtb:generator" content="PhPeace {/root/site/@phpeace}"/>
    <meta name="dtb:totalPageCount" content="0"/>
    <meta name="dtb:maxPageNumber" content="0"/>
  </head>
  <docTitle>
    <text><xsl:value-of select="/root/book/@title"/></text>
  </docTitle>
  <navMap>
    <navPoint id="navpoint-1" playOrder="1">
      <navLabel>
        <text>Title Page</text>
      </navLabel>
      <content src="title_page.html"/>
    </navPoint>
  <xsl:for-each select="/root/articles/article">
	<xsl:variable name="counter" select="position() + 1" />
	   <navPoint id="navpoint-{$counter}" playOrder="{$counter}">
      <navLabel>
        <text><xsl:value-of select="headline"/></text>
      </navLabel>
      <content src="chapter{@id}.html"/>
    </navPoint>
  </xsl:for-each>
  </navMap>
</ncx>
</xsl:template>


<!-- ###############################
 SUBTOPIC TO EBOOK
 ############################### -->
<xsl:template name="subtopicToEbook">
<xsl:copy-of select="/"/>
</xsl:template>


<!-- ###############################
 ARTICLE TO EBOOK
 ############################### -->
<xsl:template name="articleToEbook">
<xsl:copy-of select="/"/>
</xsl:template>


<!-- ###############################
 EBOOK XPGT
 ############################### -->
<xsl:template name="ebookXPGT">
<ade:template xmlns="http://www.w3.org/1999/xhtml" xmlns:ade="http://ns.adobe.com/2006/ade"
                 xmlns:fo="http://www.w3.org/1999/XSL/Format">

  <fo:layout-master-set>
   <fo:simple-page-master master-name="single_column">
                <fo:region-body margin-bottom="3pt" margin-top="0.5em" margin-left="3pt" margin-right="3pt"/>
    </fo:simple-page-master>
  
    <fo:simple-page-master master-name="single_column_head">
                <fo:region-before extent="8.3em"/>
                <fo:region-body margin-bottom="3pt" margin-top="6em" margin-left="3pt" margin-right="3pt"/>
    </fo:simple-page-master>

    <fo:simple-page-master master-name="two_column"     margin-bottom="0.5em" margin-top="0.5em" margin-left="0.5em" margin-right="0.5em">
                <fo:region-body column-count="2" column-gap="10pt"/>
    </fo:simple-page-master>

    <fo:simple-page-master master-name="two_column_head" margin-bottom="0.5em" margin-left="0.5em" margin-right="0.5em">
                <fo:region-before extent="8.3em"/>
                <fo:region-body column-count="2" margin-top="6em" column-gap="10pt"/>
    </fo:simple-page-master>

    <fo:simple-page-master master-name="three_column" margin-bottom="0.5em" margin-top="0.5em" margin-left="0.5em" margin-right="0.5em">
                <fo:region-body column-count="3" column-gap="10pt"/>
    </fo:simple-page-master>

    <fo:simple-page-master master-name="three_column_head" margin-bottom="0.5em" margin-top="0.5em" margin-left="0.5em" margin-right="0.5em">
                <fo:region-before extent="8.3em"/>
                <fo:region-body column-count="3" margin-top="6em" column-gap="10pt"/>
    </fo:simple-page-master>

    <fo:page-sequence-master>
        <fo:repeatable-page-master-alternatives>
            <fo:conditional-page-master-reference master-reference="three_column_head" page-position="first" ade:min-page-width="80em"/>
            <fo:conditional-page-master-reference master-reference="three_column" ade:min-page-width="80em"/>
            <fo:conditional-page-master-reference master-reference="two_column_head" page-position="first" ade:min-page-width="50em"/>
            <fo:conditional-page-master-reference master-reference="two_column" ade:min-page-width="50em"/>
            <fo:conditional-page-master-reference master-reference="single_column_head" page-position="first" />
            <fo:conditional-page-master-reference master-reference="single_column"/>
        </fo:repeatable-page-master-alternatives>
    </fo:page-sequence-master>

  </fo:layout-master-set>

  <ade:style>
    <ade:styling-rule selector=".title_box" display="adobe-other-region" adobe-region="xsl-region-before"/>
  </ade:style>

</ade:template>
</xsl:template>


<!-- ###############################
     IMAGE NODE EBOOK
     ############################### -->
<xsl:template name="imageNodeEbook">
<xsl:param name="id"/>
<xsl:param name="node"/>
<xsl:param name="id_article"/>
<xsl:variable name="class">
<xsl:choose>
<xsl:when test="$node/@align='0'">right</xsl:when>
<xsl:when test="$node/@align='1'">left</xsl:when>
<xsl:when test="$node/@align='2'">standalone</xsl:when>
</xsl:choose>
</xsl:variable>
<img width="{$node/@width}" height="{$node/@height}" alt="{$node/@caption}" src="images/a{$id_article}_i{$id}.{/root/publish/@image_format}" class="{$class}"/>
</xsl:template>


<!-- ###############################
     CHAPTER HEADER
     ############################### -->
<xsl:template name="chapterHeader">
<xsl:param name="a"/>
<div class="header"><xsl:value-of select="/root/book/@title"/> - <xsl:value-of  select="$a/headline"/></div>
</xsl:template>


<!-- ###############################
     CHAPTER FOOTER
     ############################### -->
<xsl:template name="chapterFooter">
<xsl:param name="a"/>
<div class="footer">Copyright <xsl:value-of select="/root/book/@author"/></div>
</xsl:template>

</xsl:stylesheet>
