<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!--********************************************************************

   PhPeace - Portal Management System

   Copyright notice
   (C) 2003-2018 Francesco Iannuzzelli <francesco@phpeace.org>
   All rights reserved

   This script is part of PhPeace.
   PhPeace is free software; you can redistribute it and/or modify 
   it under the terms of the GNU General Public License as 
   published by the Free Software Foundation; either version 2 of 
   the License, or (at your option) any later version.

   PhPeace is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   The GNU General Public License (GPL) is available at
   http://www.gnu.org/copyleft/gpl.html.
   A copy can be found in the file COPYING distributed with 
   these scripts.

   This copyright notice MUST APPEAR in all copies of the script!

********************************************************************-->

<xsl:output method="html" encoding="UTF-8" indent="no" doctype-system="http://www.w3.org/TR/html4/strict.dtd" doctype-public="-//W3C//DTD HTML 4.01//EN" />

<xsl:include href="common.xsl" />

<xsl:variable name="book_title">
<xsl:choose>
<xsl:when test="$subtype='publisher'"><xsl:value-of select="/root/books/publisher/@name"/></xsl:when>
<xsl:when test="$subtype='category'"><xsl:value-of select="/root/books/publisher/categories/category[@is_selected='1']/@name"/></xsl:when>
<xsl:when test="$subtype='book' or $subtype='reviews'"><xsl:value-of select="/root/books/book/@title"/></xsl:when>
<xsl:otherwise><xsl:value-of select="key('label','books')/@tr"/></xsl:otherwise>
</xsl:choose>
</xsl:variable>

<xsl:variable name="current_page_title" select="$book_title"/>

<xsl:variable name="currCategory" select="/root/books/publisher/categories/category[@is_selected='1']"/>


<!-- ###############################
     CONTENT
     ############################### -->
<xsl:template name="content">
<xsl:call-template name="bookBreadcrumb"/>
<xsl:call-template name="feedback"/>
<div id="books-content">
<xsl:choose>
<xsl:when test="$subtype='home'">
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
<xsl:call-template name="bookSearch"/>
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
     BOOK
     ############################### -->
<xsl:template match="book">
<div class="book">
<xsl:if test="image">
<img width="{image/@width}">
<xsl:attribute name="src">
<xsl:call-template name="createLinkUrl">
<xsl:with-param name="node" select="image"/>
</xsl:call-template>
</xsl:attribute>
</img>
</xsl:if>
<div id="book-summary">
<div class="author"><xsl:value-of select="@author"/></div>
<h1><xsl:value-of select="@title"/></h1>
<div class="summary"><xsl:value-of select="summary" disable-output-escaping="yes"/></div>
<p><xsl:value-of select="description" disable-output-escaping="yes"/></p>
</div>
<div id="book-details">
<div class="publisher"><xsl:value-of select="key('label','publisher')/@tr"/>: 
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="/root/books/publisher"/>
</xsl:call-template>
</div>
<div class="category"><xsl:value-of select="key('label','category')/@tr"/>: 
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="$currCategory"/>
</xsl:call-template>
</div>
<div class="isbn"><xsl:value-of select="key('label','isbn')/@tr"/>: <xsl:value-of select="@isbn"/></div>
<div class="pages"><xsl:value-of select="key('label','pages')/@tr"/>: <xsl:value-of select="@pages"/></div>
<div class="pubdate"><xsl:value-of select="key('label','publish_date')/@tr"/>: <xsl:value-of select="concat(@month,' ',@year)"/></div>
<div class="price"><xsl:value-of select="key('label','price')/@tr"/>: <xsl:value-of select="@price_format"/></div>
<p class="notes"><xsl:value-of select="notes" disable-output-escaping="yes"/></p>
</div>
<xsl:if test="article">
<div id="book-article">
<p><xsl:value-of select="key('label','see_book_article')/@tr"/></p>
<xsl:call-template name="articleItem">
<xsl:with-param name="a" select="article"/>
</xsl:call-template>
</div>
</xsl:if>

<xsl:if test="/root/books/@show_reviews!='4'">
<xsl:choose>
<xsl:when test="reviews/@tot_imp_reviews &gt; 0">
<div id="reviews">
<h2><xsl:value-of select="key('label','reviews')/@tr"/></h2>
<ul class="items">
<xsl:apply-templates select="reviews" mode="listitem"/>
</ul>
<xsl:if test="reviews/@tot_reviews &gt; reviews/@tot_imp_reviews">
<p class="inline">
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="reviews"/>
<xsl:with-param name="name" select="key('label','reviews_all')/@tr"/>
</xsl:call-template>
</p>
</xsl:if>
</div>
</xsl:when>
<xsl:otherwise>
<xsl:if test="reviews/@tot_reviews &gt; 0 and reviews/@tot_imp_reviews='0'">
<p class="inline">
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="reviews"/>
<xsl:with-param name="name" select="key('label','reviews_read')/@tr"/>
</xsl:call-template>
</p>
</xsl:if>
</xsl:otherwise>
</xsl:choose>
</xsl:if>

<xsl:if test="/root/books/@allow_reviews &gt; 0">
<p class="inline">
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="reviews/insert"/>
<xsl:with-param name="name" select="key('label','review_insert')/@tr"/>
</xsl:call-template>
</p>
</xsl:if>
</div>
</xsl:template>


<!-- ###############################
     BOOK [REVIEWS]
     ############################### -->
<xsl:template match="book" mode="reviews">
<div class="book">
<div class="author"><xsl:value-of select="@author"/></div>
<h1>
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="."/>
<xsl:with-param name="name" select="@title"/>
</xsl:call-template>
</h1>
<div class="summary"><xsl:value-of select="summary" disable-output-escaping="yes"/></div>
<xsl:if test="/root/books/@allow_reviews='1'">
<p>
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="reviews/insert"/>
<xsl:with-param name="name" select="key('label','review_insert')/@tr"/>
</xsl:call-template>
</p>
</xsl:if>
<div id="reviews">
<h2><xsl:value-of select="key('label','reviews')/@tr"/></h2>
<ul class="items">
<xsl:apply-templates select="reviews" mode="listitem"/>
</ul>
</div>
</div>
</xsl:template>


<!-- ###############################
     BOOK BREADCRUMB
     ############################### -->
<xsl:template name="bookBreadcrumb">
<div class="breadcrumb">
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="/root/books"/>
<xsl:with-param name="name" select="key('label','books')/@tr"/>
</xsl:call-template>
<xsl:if test="$subtype!='home'">
<xsl:value-of select="$breadcrumb_separator"/>
</xsl:if>
<xsl:choose>
<xsl:when test="$subtype='search'">
<xsl:value-of select="key('label','search')/@tr"/> "<em><xsl:value-of select="/root/books/search/@q"/></em>"
</xsl:when>
<xsl:when test="$subtype='publisher'">
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="/root/books/publisher"/>
</xsl:call-template>
</xsl:when>
<xsl:when test="$subtype='category'">
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="/root/books/publisher"/>
</xsl:call-template>
<xsl:value-of select="$breadcrumb_separator"/>
<xsl:value-of select="$currCategory/@name"/>
</xsl:when>
<xsl:when test="$subtype='book' or $subtype='reviews'  or $subtype='review_insert'">
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="/root/books/publisher"/>
</xsl:call-template>
<xsl:value-of select="$breadcrumb_separator"/>
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="/root/books/publisher/categories/category[@is_selected='1']"/>
</xsl:call-template>
<xsl:value-of select="$breadcrumb_separator"/>
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="/root/books/book"/>
<xsl:with-param name="name" select="/root/books/book/@title"/>
</xsl:call-template>
</xsl:when>
</xsl:choose>
</div>
</xsl:template>


<!-- ###############################
     BOOK SEARCH
     ############################### -->
<xsl:template name="bookSearch">
<form method="get" accept-charset="{/root/site/@encoding}" id="book-search">
<xsl:attribute name="action">
<xsl:call-template name="createLinkUrl">
<xsl:with-param name="node" select="/root/books/search"/>
</xsl:call-template>
</xsl:attribute>

<xsl:if test="$preview='1'">
<input type="hidden" name="id_type" value="0"/>
<input type="hidden" name="subtype" value="search"/>
<input type="hidden" name="module" value="books"/>
<input type="hidden" name="id_module" value="16"/>
</xsl:if>
<input type="hidden" name="id_topic" value="{/root/topic/@id}"/>
<ul class="form-inputs">
<xsl:call-template name="formInput">
<xsl:with-param name="varname">q</xsl:with-param>
<xsl:with-param name="label">text</xsl:with-param>
<xsl:with-param name="value" select="/root/books/search/@q"/>
</xsl:call-template>
<li class="buttons"><input type="submit" value="{key('label','search')/@tr}"/></li>
</ul>
</form>
</xsl:template>


<!-- ###############################
     CATEGORY
     ############################### -->
<xsl:template match="category">
<h1><xsl:value-of select="@name"/></h1>
<div class="notes"><xsl:value-of select="description" disable-output-escaping="yes"/></div>
<xsl:call-template name="items">
<xsl:with-param name="root" select="/root/books/books"/>
<xsl:with-param name="node" select="."/>
</xsl:call-template>
</xsl:template>


<!-- ###############################
     CATEGORY [LIST ITEM]
     ############################### -->
<xsl:template match="category" mode="listitem">
<li>
<div class="category-name">
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="."/>
</xsl:call-template>
</div>
<div class="notes"><xsl:value-of select="description" disable-output-escaping="yes"/></div>
<div class="books"><xsl:value-of select="key('label','books')/@tr"/>: <xsl:value-of select="@books"/></div>
</li>
</xsl:template>


<!-- ###############################
     PUBLISHER
     ############################### -->
<xsl:template match="publisher">
<h1><xsl:value-of select="@name"/></h1>
<xsl:if test="@address!='' and @town!=''">
<div class="notes"><xsl:value-of select="concat(@address,' - ',@zipcode,' ',@town)"/></div>
</xsl:if>
<xsl:if test="@phone!=''">
<div class="phone">Tel: <xsl:value-of select="@phone"/></div>
</xsl:if>
<xsl:if test="@fax!=''">
<div class="fax">Fax: <xsl:value-of select="@fax"/></div>
</xsl:if>
<xsl:if test="@email!=''">
<div class="email">Email: <a href="mailto:{@email}"><xsl:value-of select="@email"/></a></div>
</xsl:if>
<xsl:if test="@website!=''">
<div class="website"><a href="{@website}" target="_blank"><xsl:value-of select="@website"/></a></div>
</xsl:if>
<h2><xsl:value-of select="key('label','categories')/@tr"/></h2>
<ul class="categories">
<xsl:apply-templates select="categories" mode="listitem"/>
</ul>
</xsl:template>


<!-- ###############################
     PUBLISHER [LIST ITEM]
     ############################### -->
<xsl:template match="publisher" mode="listitem">
<li>
<div class="publisher-name">
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="."/>
</xsl:call-template>
</div>
<xsl:if test="@address!='' and @town!=''">
<div class="notes"><xsl:value-of select="@address"/> - <xsl:value-of select="@town"/></div>
</xsl:if>
</li>
</xsl:template>


<!-- ###############################
     REVIEW [LIST ITEM]
     ############################### -->
<xsl:template match="review" mode="listitem">
<li class="review-item">
<a name="#r{@id}"/>
<div class="author"><xsl:value-of select="@date"/> - <xsl:value-of select="@name"/>
</div>
<xsl:call-template name="reviewStars">
<xsl:with-param name="vote" select="@vote"/>
</xsl:call-template>
<div class="review"><xsl:value-of select="content" disable-output-escaping="yes"/></div>
<xsl:if test="params">
<ul class="params">
<xsl:for-each select="params/param">
<li><span class="param-label"><xsl:value-of select="@name"/></span>: <xsl:value-of select="@value"/></li> 
</xsl:for-each>
</ul>
</xsl:if>
</li>
</xsl:template>


<!-- ###############################
     REVIEW INSERT
     ############################### -->
<xsl:template name="reviewInsert">
<div class="author"><xsl:value-of select="/root/books/book/@author"/></div>
<h1>
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="/root/books/book"/>
<xsl:with-param name="name" select="/root/books/book/@title"/>
</xsl:call-template>
</h1>
<div class="summary"><xsl:value-of select="/root/books/book/summary" disable-output-escaping="yes"/></div>
<xsl:choose>
<xsl:when test="/root/books/@allow_reviews='0'"><p><xsl:value-of select="key('label','reviews_not_allowed')/@tr"/></p></xsl:when>
<xsl:when test="/root/books/@allow_reviews='1'">
<xsl:choose>
<xsl:when test="/root/user/@id &gt; 0"><xsl:call-template name="reviewInsertForm"/></xsl:when>
<xsl:otherwise>
<xsl:call-template name="loginFirst">
<xsl:with-param name="node" select="/root/books/book/reviews/insert/login"/>
</xsl:call-template>
</xsl:otherwise>
</xsl:choose>
</xsl:when>
<xsl:otherwise>
<xsl:call-template name="reviewInsertForm"/>
</xsl:otherwise>
</xsl:choose>
</xsl:template>


<!-- ###############################
     REVIEW INSERT FORM
     ############################### -->
<xsl:template name="reviewInsertForm">
<xsl:call-template name="javascriptForms"/>
<script type="text/javascript">
$().ready(function() {
	$("#review-insert").validate({
		rules: {
			review: "required",
			name: "required",
			email: {
				required: true,
				email:	true
			}
		}
	});
});
</script>
<form action="{/root/site/@base}/{/root/site/books/@path}/actions.php" method="post" id="review-insert" accept-charset="{/root/site/@encoding}">
<input type="hidden" name="from" value="review"/>
<xsl:if test="/root/topic">
<input type="hidden" name="id_topic" value="{/root/topic/@id}"/>
</xsl:if>
<input type="hidden" name="id_book" value="{/root/books/book/@id}"/>
<fieldset>
<legend><xsl:value-of select="key('label','review_insert')/@tr"/></legend>
<ul class="form-inputs">
<li>
<xsl:call-template name="reviewStarsInsert"/>
</li>
<xsl:call-template name="formInput">
<xsl:with-param name="varname">review</xsl:with-param>
<xsl:with-param name="required" select="true()"/>
<xsl:with-param name="type">textarea</xsl:with-param>
<xsl:with-param name="size">extralarge</xsl:with-param>
</xsl:call-template>
<xsl:apply-templates select="/root/books/book/reviews/params/param" mode="custom"/>
<xsl:choose>
<xsl:when test="/root/user/@id &gt; 0">
<li>
<p><xsl:value-of select="key('label','author')/@tr"/>: <xsl:value-of select="/root/user/@name"/></p>
<input type="hidden" name="name" value="{/root/user/@name}"/>
<input type="hidden" name="email" value="{/root/user/@email}"/>
</li>
</xsl:when>
<xsl:otherwise>
<xsl:call-template name="formInput">
<xsl:with-param name="varname">name</xsl:with-param>
<xsl:with-param name="label">name</xsl:with-param>
<xsl:with-param name="required" select="true()"/>
</xsl:call-template>
<xsl:call-template name="formInput">
<xsl:with-param name="varname">email</xsl:with-param>
<xsl:with-param name="label">email</xsl:with-param>
<xsl:with-param name="required" select="true()"/>
</xsl:call-template>
</xsl:otherwise>
</xsl:choose>
<xsl:if test="/root/site/@captcha">
<li class="clearfix">
<xsl:call-template name="captchaWrapper"/>
</li>
</xsl:if>
</ul>
</fieldset>
<ul class="form-inputs">
<li class="buttons"><input type="submit" value="{key('label','submit')/@tr}"/></li>
</ul>
</form>
</xsl:template>


<!-- ###############################
     REVIEW STARS
     ############################### -->
<xsl:template name="reviewStars">
<xsl:param name="vote"/>
<div class="vote">
<span class="param-label">
<xsl:value-of select="key('label','vote')/@tr"/>: </span>
<xsl:choose>
<xsl:when test="$vote=1">*</xsl:when>
<xsl:when test="$vote=2">**</xsl:when>
<xsl:when test="$vote=3">***</xsl:when>
<xsl:when test="$vote=4">****</xsl:when>
<xsl:when test="$vote=5">*****</xsl:when>
</xsl:choose>
</div>
</xsl:template>


<!-- ###############################
     REVIEW STARS INSERT
     ############################### -->
<xsl:template name="reviewStarsInsert">
<label for="vote"><xsl:value-of select="key('label','vote')/@tr"/></label>
<select name="vote"><xsl:call-template name="optionLoop">
<xsl:with-param name="from" select="1"/>
<xsl:with-param name="to" select="5"/>
<xsl:with-param name="value" select="3"/>
</xsl:call-template>
</select>
</xsl:template>


</xsl:stylesheet>
