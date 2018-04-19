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

<xsl:variable name="title">
<xsl:choose>
<xsl:when test="$subtype = 'orders'">
<xsl:value-of select="/root/ecomm/orders_list/@label"/>
</xsl:when>
<xsl:when test="$subtype = 'order_complete' or $subtype='order'">
<xsl:value-of select="concat(key('label','order')/@tr,' #',/root/ecomm/order/@id)"/>
</xsl:when>
<xsl:when test="$subtype = 'product'">
<xsl:value-of select="/root/ecomm/product/@name"/>
</xsl:when>
<xsl:when test="$subtype = 'products'">
<xsl:value-of select="/root/ecomm/products_list/@label"/>
</xsl:when>
<xsl:otherwise>e-shop</xsl:otherwise>
</xsl:choose>
</xsl:variable>

<xsl:variable name="currency" select="/root/ecomm/@currency"/>

<xsl:variable name="current_page_title" select="$title"/>

<!-- ###############################
     CONTENT
     ############################### -->
<xsl:template name="content">
<div class="breadcrumb"><xsl:call-template name="ecommBreadcrumb"/></div>
<xsl:call-template name="feedback"/>
<div id="ecomm-content" class="ecomm-{$subtype}">
<xsl:choose>
<xsl:when test="$subtype='products'">
<xsl:call-template name="items">
<xsl:with-param name="root" select="/root/ecomm/products"/>
<xsl:with-param name="node" select="/root/ecomm/products"/>
</xsl:call-template>
</xsl:when>
<xsl:when test="$subtype='product'">
<xsl:call-template name="product"/>
</xsl:when>
<xsl:when test="$subtype='order_preview'">
<xsl:call-template name="orderPreview"/>
</xsl:when>
<xsl:when test="$subtype='orders'">
<xsl:choose>
<xsl:when test="/root/ecomm/login">
<p><xsl:call-template name="createLink">
<xsl:with-param name="node" select="/root/ecomm/login"/>
<xsl:with-param name="name" select="/root/ecomm/login/@label"/>
</xsl:call-template></p>
</xsl:when>
<xsl:otherwise>
<xsl:call-template name="items">
<xsl:with-param name="root" select="/root/ecomm/orders"/>
<xsl:with-param name="node" select="/root/ecomm/orders"/>
</xsl:call-template>
</xsl:otherwise>
</xsl:choose>
</xsl:when>
<xsl:when test="$subtype='order'">
<xsl:call-template name="order"/>
</xsl:when>
<xsl:when test="$subtype='order_complete'">
<xsl:call-template name="orderMessages"/>
<xsl:call-template name="order"/>
</xsl:when>
<xsl:otherwise>
<xsl:call-template name="ecommHome"/>
</xsl:otherwise>
</xsl:choose>
</div>
</xsl:template>


<!-- ###############################
     PAGE TITLE
     ############################### -->
<xsl:template name="pageTitle">
<xsl:if test="$preview='1'">[<xsl:value-of select="key('label','preview')/@tr"/>] - </xsl:if><xsl:value-of select="concat(/root/ecomm/@label,' - ',$title)"/>
</xsl:template>


<!-- ###############################
     ECOMM BREADCRUMB
     ############################### -->
<xsl:template name="ecommBreadcrumb">
<xsl:choose>
<xsl:when test="$subtype = 'orders' or $subtype = 'order_complete' or $subtype='order'">
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="/root/ecomm/orders_list"/>
<xsl:with-param name="name" select="/root/ecomm/orders_list/@label"/>
</xsl:call-template>
<xsl:if test="$subtype = 'order_complete' or $subtype='order'">
<xsl:value-of select="$breadcrumb_separator"/>
<xsl:value-of select="$title"/>
</xsl:if>
</xsl:when>
<xsl:when test="$subtype = 'product'">
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="/root/ecomm/products_list"/>
<xsl:with-param name="name" select="/root/ecomm/products_list/@label"/>
</xsl:call-template>
<xsl:value-of select="$breadcrumb_separator"/>
<xsl:value-of select="$title"/>
</xsl:when>
<xsl:otherwise>
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="/root/ecomm/products_list"/>
<xsl:with-param name="name" select="/root/ecomm/products_list/@label"/>
</xsl:call-template>
</xsl:otherwise>
</xsl:choose>
</xsl:template>


<!-- ###############################
     ECOMM HOME
     ############################### -->
<xsl:template name="ecommHome">

</xsl:template>


<!-- ###############################
     ORDER
     ############################### -->
<xsl:template name="order">
<xsl:variable name="o" select="/root/ecomm/order"/>
<h3><xsl:value-of select="concat(key('label','order')/@tr,' #',$o/@id)"/></h3>
<div class="date"><xsl:value-of select="$o/@date"/></div>
<div class="price"><xsl:value-of select="concat(key('label','total')/@tr,': ',$o/@total,' ',$currency)"/></div>
<ul class="order-products">
<xsl:apply-templates mode="mainlist" select="$o/products"/>
</ul>
<h4><xsl:value-of select="key('label','delivery')/@tr"/></h4>
<ul class="delivery-info">
<li><xsl:value-of select="key('label','name')/@tr"/>: <xsl:value-of select="/root/user/@name"/></li>
<li><xsl:value-of select="key('label','email')/@tr"/>: <xsl:value-of select="/root/user/@email"/></li>
<li><xsl:value-of select="key('label','phone')/@tr"/>: <xsl:value-of select="/root/user/@phone"/></li>
<li><xsl:value-of select="key('label','address')/@tr"/>: <xsl:value-of select="/root/user/@address"/></li>
<li><xsl:value-of select="key('label','postcode')/@tr"/>: <xsl:value-of select="/root/user/@postcode"/></li>
<li><xsl:value-of select="key('label','town')/@tr"/>: <xsl:value-of select="/root/user/@town"/></li>
<li><xsl:value-of select="key('label','address_notes')/@tr"/>: <xsl:value-of select="/root/user/@address_notes"/></li>
<li><xsl:value-of select="/root/user/@geo_name_label"/>: <xsl:value-of select="/root/user/@geo_name"/></li>
<li><xsl:value-of select="$o/delivery_notes/@label"/>: <xsl:value-of select="$o/delivery_notes"/></li>
</ul>
<h4>Status: <xsl:value-of select="$o/@status"/></h4>
<xsl:if test="$o/@id_status = '0'">
<form id="order-pay" action="{/root/site/@base}/ecomm/actions.php" method="post">
<input type="hidden" name="from" value="order_pay"/>
<input type="hidden" name="id_topic" value="{/root/topic/@id}"/>
<input type="hidden" name="id_order" value="{$o/@id}"/>
<ul class="form-inputs">
<li class="buttons"><input type="submit" value="{key('label','pay')/@tr}"/></li>
</ul>
</form>
</xsl:if>
</xsl:template>


<!-- ###############################
     ORDER ITEM
     ############################### -->
<xsl:template name="orderItem">
<xsl:param name="o"/>
<h3>
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="$o"/>
<xsl:with-param name="name" select="concat(key('label','order')/@tr,' #',$o/@id)"/>
</xsl:call-template>
</h3>
<div class="date"><xsl:value-of select="$o/@date"/></div>
<div class="price"><xsl:value-of select="concat(key('label','total')/@tr,': ',$o/@total,' ',$currency)"/></div>
<div class="status">Status: <xsl:value-of select="$o/@status"/></div>
</xsl:template>


<!-- ###############################
     ORDER MESSAGES
     ############################### -->
<xsl:template name="orderMessages">
<xsl:variable name="o" select="/root/ecomm/order"/>
<div id="order-messages" class="{/root/ecomm/order/message/@type}">
<xsl:value-of select="/root/ecomm/order/message/content"/>
</div>
</xsl:template>


<!-- ###############################
     ORDER PREVIEW
     ############################### -->
<xsl:template name="orderPreview">
<xsl:choose>
<xsl:when test="/root/ecomm/login">
<p><xsl:call-template name="createLink">
<xsl:with-param name="node" select="/root/ecomm/login"/>
<xsl:with-param name="name" select="/root/ecomm/login/@label"/>
</xsl:call-template></p>
</xsl:when>
<xsl:otherwise>
<xsl:variable name="p" select="/root/ecomm/product"/>
<xsl:if test="$p/@id &gt; 0 and $p/@stock &gt; 0">
<xsl:if test="$p/thumb">
<img width="{$p/thumb/@width}" class="left">
<xsl:attribute name="src">
<xsl:call-template name="createLinkUrl">
<xsl:with-param name="node" select="$p/thumb"/>
</xsl:call-template>
</xsl:attribute>
</img>
</xsl:if>
<h3><xsl:value-of select="$p/@name"/></h3>
<div class="price"><xsl:value-of select="concat(key('label','price')/@tr,': ',$p/@price,' ',$currency)"/></div>
<div class="stock"><xsl:value-of select="key('label','stock_in')/@tr"/></div>
<form id="product-purchase" action="{/root/site/@base}/ecomm/actions.php" method="post">
<input type="hidden" name="from" value="product_purchase"/>
<input type="hidden" name="id_topic" value="{/root/topic/@id}"/>
<input type="hidden" name="id_product" value="{$p/@id}"/>
<ul class="form-inputs">
<li><label for="name"><xsl:value-of select="key('label','name')/@tr"/></label>
<div id="name"><xsl:value-of select="/root/user/@name"/></div></li>
<li><label for="email"><xsl:value-of select="key('label','email')/@tr"/></label>
<div id="email"><xsl:value-of select="/root/user/@email"/></div></li>
<xsl:call-template name="formInput">
<xsl:with-param name="varname">phone</xsl:with-param>
<xsl:with-param name="label">phone</xsl:with-param>
<xsl:with-param name="value" select="/root/user/@phone"/>
</xsl:call-template>
<xsl:call-template name="formInput">
<xsl:with-param name="varname">address</xsl:with-param>
<xsl:with-param name="label">address</xsl:with-param>
<xsl:with-param name="type">textarea</xsl:with-param>
<xsl:with-param name="required" select="true()"/>
<xsl:with-param name="value" select="/root/user/@address"/>
</xsl:call-template>
<xsl:call-template name="formInput">
<xsl:with-param name="varname">postcode</xsl:with-param>
<xsl:with-param name="size">small</xsl:with-param>
<xsl:with-param name="value" select="/root/user/@postcode"/>
</xsl:call-template>
<xsl:call-template name="formInput">
<xsl:with-param name="varname">town</xsl:with-param>
<xsl:with-param name="value" select="/root/user/@town"/>
<xsl:with-param name="required" select="true()"/>
</xsl:call-template>
<xsl:call-template name="formInput">
<xsl:with-param name="varname">address_notes</xsl:with-param>
<xsl:with-param name="label">address_notes</xsl:with-param>
<xsl:with-param name="type">textarea</xsl:with-param>
<xsl:with-param name="value" select="/root/user/@address_notes"/>
</xsl:call-template>
<xsl:call-template name="formInputGeo">
<xsl:with-param name="currentGeo">
<xsl:choose>
<xsl:when test="/root/user/@id_geo &gt; 0"><xsl:value-of select="/root/user/@id_geo"/></xsl:when>
<xsl:otherwise>130</xsl:otherwise>
</xsl:choose>
</xsl:with-param>
</xsl:call-template>
<xsl:call-template name="formInput">
<xsl:with-param name="varname">delivery_notes</xsl:with-param>
<xsl:with-param name="tr_label" select="$p/@delivery_notes_label"/>
<xsl:with-param name="type">textarea</xsl:with-param>
</xsl:call-template>
<li class="buttons"><input type="submit" value="{$p/@order_confirm_label}"/></li>
</ul>
</form>
</xsl:if>
</xsl:otherwise>
</xsl:choose>
</xsl:template>


<!-- ###############################
     PRODUCT
     ############################### -->
<xsl:template name="product">
<xsl:variable name="p" select="/root/ecomm/product"/>
<xsl:if test="$p/image">
<img width="{$p/image/@width}" class="left">
<xsl:attribute name="src">
<xsl:call-template name="createLinkUrl">
<xsl:with-param name="node" select="$p/image"/>
</xsl:call-template>
</xsl:attribute>
</img>
</xsl:if>
<h3><xsl:value-of select="$p/@name"/></h3>
<div class="description"><xsl:value-of select="$p/description" disable-output-escaping="yes"/></div>
<div class="price"><xsl:value-of select="concat(key('label','price')/@tr,': ',$p/@price,' ',$currency)"/></div>
<div class="stock">
<xsl:choose>
<xsl:when test="$p/@stock='0'"><xsl:value-of select="key('label','stock_out')/@tr"/></xsl:when>
<xsl:otherwise><xsl:value-of select="key('label','stock_in')/@tr"/></xsl:otherwise>
</xsl:choose>
</div>
<xsl:if test="$p/@stock &gt; 0">
<div id="buy">
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="$p/order"/>
<xsl:with-param name="name" select="key('label','buy')/@tr"/>
</xsl:call-template>
</div>
</xsl:if>

</xsl:template>


<!-- ###############################
     PRODUCT ITEM
     ############################### -->
<xsl:template name="productItem">
<xsl:param name="p"/>
<xsl:if test="$p/thumb">
<a>
<xsl:attribute name="href">
<xsl:call-template name="createLinkUrl">
<xsl:with-param name="node" select="$p"/>
</xsl:call-template>
</xsl:attribute>
<img width="{$p/thumb/@width}" class="left">
<xsl:attribute name="src">
<xsl:call-template name="createLinkUrl">
<xsl:with-param name="node" select="$p/thumb"/>
</xsl:call-template>
</xsl:attribute>
</img>
</a>
</xsl:if>
<h3>
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="$p"/>
<xsl:with-param name="name" select="$p/@name"/>
</xsl:call-template>
</h3>
<div class="price"><xsl:value-of select="concat(key('label','price')/@tr,': ',$p/@price,' ',$currency)"/></div>
<div class="stock">
<xsl:choose>
<xsl:when test="$p/@stock='0'"><xsl:value-of select="key('label','stock_out')/@tr"/></xsl:when>
<xsl:otherwise><xsl:value-of select="key('label','stock_in')/@tr"/></xsl:otherwise>
</xsl:choose>
</div>
</xsl:template>


</xsl:stylesheet>
