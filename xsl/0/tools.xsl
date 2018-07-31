<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:g="http://base.google.com/ns/1.0">

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

<!-- ###############################
     TOOLS
     ############################### -->

<!-- ###############################
     FOR LOOP
     ############################### -->
<xsl:template name="numericLoop">
<xsl:param name="from" />
<xsl:param name="to" />
<xsl:param name="text_before" />
<xsl:param name="text_after" />
<xsl:value-of select="$text-before"/><xsl:value-of select="$from"/><xsl:value-of select="$text-after"/>
<xsl:if test="$from &lt; $to">
<xsl:call-template name="numericLoop">
<xsl:with-param name="from" select="($from + 1)" />
<xsl:with-param name="to" select="$to" />
<xsl:with-param name="text_before" select="$text_before" />
<xsl:with-param name="text_after" select="$text_after" />
</xsl:call-template>
</xsl:if>
</xsl:template>	



	<!-- ###############################
     FORM INPUT
     ############################### -->
	<xsl:template name="formInput">
		<xsl:param name="varname"/>
		<xsl:param name="label" select="$varname"/>
		<xsl:param name="tr_label" select="key('label',$label)/@tr"/>
		<xsl:param name="type" select="'text'"/>
		<xsl:param name="required" select="false()"/>
		<xsl:param name="disabled" select="false()"/>
		<xsl:param name="readonly" select="false()"/>
		<xsl:param name="size" />
		<xsl:param name="box_value" select="''"/>
		<xsl:param name="label_desc" select="''"/>
		<xsl:param name="value" select="/root/postback/var[@name=$varname]/@value"/>
		<xsl:param name="maxlength" select="''"/>
		<!-- additional form instructions or note, or note with list items -->
		<xsl:param name="inline-instructions" select="''"/>
		<xsl:param name="autocomplete" select="true()"/>
		<xsl:param name="note" select="''"/>
		<xsl:param name="note_list_item1" select="''" />
		<xsl:param name="note_list_item2" select="''" />
		<xsl:param name="note_list_item3" select="''" />
		<xsl:param name="note_list_item4" select="''" />
		<xsl:param name="note_list_item5" select="''" />
		<xsl:param name="class" select="''" />
		<li>
			<xsl:attribute name="class">
				<xsl:text>clearfix</xsl:text>
				<xsl:if test="$required=true() or /root/posterrors/postvar/@name=$varname"> validation</xsl:if>
				<xsl:if test="$type='checkbox'"> checkbox</xsl:if>
				<xsl:if test="$type='radio'"> radio</xsl:if>
				<xsl:if test="$class!=''"><xsl:text> </xsl:text><xsl:value-of select="$class" /></xsl:if>
			</xsl:attribute>
			
			<xsl:choose>
				<xsl:when test="$type='checkbox'">
					<input type="checkbox" id="{$varname}" name="{$varname}" class="checkbox">
						<xsl:if test="$value=true() or /root/postback/var[@name=$varname]/@value='on'">
							<xsl:attribute name="checked">checked</xsl:attribute>
						</xsl:if>
						<xsl:if test="$box_value!=''">
							<xsl:attribute name="value"><xsl:value-of select="$box_value"/></xsl:attribute>
						</xsl:if>
						<xsl:if test="$disabled=true()">
							<xsl:attribute name="disabled">disabled</xsl:attribute>
						</xsl:if>
						<xsl:if test="$required=true()">
							<xsl:attribute name="required">required</xsl:attribute>
						</xsl:if>
					</input>
					<label for="{$varname}">
						<xsl:attribute name="class">checkbox <xsl:if test="$required=true()">required</xsl:if></xsl:attribute> 
						<xsl:value-of select="$tr_label" disable-output-escaping="yes"/>
						<xsl:if test="$required=true()">
							<abbr title="Required">*</abbr>
						</xsl:if>
					</label>
				</xsl:when>
				<xsl:when test="$type='radio'">
					<input type="radio" id="{$varname}" name="{$varname}" value="{$value}" class="radio">
						<xsl:if test="($box_value!='' and $value=$box_value) or /root/postback/var[@name=$varname]/@value='$value'">
							<xsl:attribute name="checked">checked</xsl:attribute>
						</xsl:if>
						<xsl:if test="$disabled=true()">
							<xsl:attribute name="disabled">disabled</xsl:attribute>
						</xsl:if>
						<xsl:if test="$required=true()">
							<xsl:attribute name="required">required</xsl:attribute>
						</xsl:if>
					</input>
					<label for="{$varname}">
						<xsl:attribute name="class">radio <xsl:if test="$required=true()">required</xsl:if></xsl:attribute> 
						<xsl:value-of select="$tr_label" disable-output-escaping="yes"/>
						<xsl:if test="$required=true()">
							<abbr title="Required">*</abbr>
						</xsl:if>
					</label>
					<xsl:if test="$label_desc!=''">
						<div class="label-desc">
							<xsl:value-of select="$label_desc" disable-output-escaping="yes"/>
						</div>
					</xsl:if>
				</xsl:when>
				<xsl:when test="$type='textarea'">
					<label for="{$varname}">
						<xsl:attribute name="class">textarea <xsl:if test="$required=true()">required</xsl:if></xsl:attribute> 
						<xsl:value-of select="$tr_label"/>
						<xsl:if test="$required=true()">
							<abbr title="Required">*</abbr>
						</xsl:if>
					</label>
					<textarea id="{$varname}" name="{$varname}" class="{$size}">
						<xsl:if test="$required=true()">
							<xsl:attribute name="required">required</xsl:attribute>
						</xsl:if>
						<xsl:value-of select="$value"/>
					</textarea>
					<xsl:choose>
						<xsl:when test="$inline-instructions !=''">
							<div class="inline input-instructions">
								<xsl:value-of select="$inline-instructions" />
							</div>
						</xsl:when>
						<xsl:when test="$note !=''">
							<small class="inline input-instructions"><xsl:value-of select="$note" /></small>
							<xsl:if test="$note_list_item1 !=''">
								<ul class="inline input-instructions">
									<li><xsl:value-of select="$note_list_item1" /></li>
									<xsl:if test="$note_list_item2 !=''">
										<li><xsl:value-of select="$note_list_item2" /></li>
									</xsl:if>
									<xsl:if test="$note_list_item3 !=''">
										<li><xsl:value-of select="$note_list_item3" /></li>
									</xsl:if>
									<xsl:if test="$note_list_item4 !=''">
										<li><xsl:value-of select="$note_list_item4" /></li>
									</xsl:if>
									<xsl:if test="$note_list_item5 !=''">
										<li><xsl:value-of select="$note_list_item5" /></li>
									</xsl:if>
								</ul>
							</xsl:if>	
						</xsl:when>
					</xsl:choose>

				</xsl:when>
				<xsl:otherwise>
					<label for="{$varname}">
						<xsl:if test="$required=true()">
							<xsl:attribute name="class">required</xsl:attribute> 
						</xsl:if>
						<xsl:value-of select="$tr_label"/>
						<xsl:if test="$required=true()">
							<abbr title="Required">*</abbr>
						</xsl:if>
					</label>
					<input type="{$type}" id="{$varname}" name="{$varname}" class="{$size}" value="{$value}">
						<xsl:if test="$disabled=true()">
							<xsl:attribute name="disabled">disabled</xsl:attribute>
						</xsl:if>
						<xsl:if test="$readonly=true()">
							<xsl:attribute name="readonly">readonly</xsl:attribute>
						</xsl:if>
						<xsl:if test="$maxlength != ''">
							<xsl:attribute name="maxlength"><xsl:value-of select="$maxlength" /></xsl:attribute>
						</xsl:if>
						<xsl:if test="$autocomplete=false()">
							<xsl:attribute name="autocomplete">off</xsl:attribute>
						</xsl:if>
						<xsl:if test="$required=true()">
							<xsl:attribute name="required">required</xsl:attribute>
						</xsl:if>
					</input>
					<xsl:choose>
						<xsl:when test="$inline-instructions !=''">
							<div class="inline input-instructions">
								<xsl:value-of select="$inline-instructions" />
							</div>
						</xsl:when>
						<xsl:when test="$note !=''">
							<small class="inline input-instructions"><xsl:value-of select="$note" /></small>
							<xsl:if test="$note_list_item1 !=''">
								<ul class="inline input-instructions">
									<li><xsl:value-of select="$note_list_item1" /></li>
									<xsl:if test="$note_list_item2 !=''">
										<li><xsl:value-of select="$note_list_item2" /></li>
									</xsl:if>
									<xsl:if test="$note_list_item3 !=''">
										<li><xsl:value-of select="$note_list_item3" /></li>
									</xsl:if>
									<xsl:if test="$note_list_item4 !=''">
										<li><xsl:value-of select="$note_list_item4" /></li>
									</xsl:if>
									<xsl:if test="$note_list_item5 !=''">
										<li><xsl:value-of select="$note_list_item5" /></li>
									</xsl:if>
								</ul>
							</xsl:if>	
						</xsl:when>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
		</li>
	</xsl:template>


<!-- ###############################
     FORM INPUT GEO
     ############################### -->
<xsl:template name="formInputGeo">
<xsl:param name="contextNode" select="/root"/>
<xsl:param name="currentGeo"/>
<xsl:param name="geoLocation" select="/root/site/@geo"/>
<xsl:param name="required" select="false()"/>
<xsl:param name="geoVarname" select="'id_geo'"/>
<li>
<xsl:if test="$required=true()">
<xsl:if test="/root/posterrors/postvar/@name='id_geo' ">
<xsl:attribute name="class">wrong</xsl:attribute>
</xsl:if>
</xsl:if>
<label for="{$geoVarname}">
<xsl:if test="$required=true()">
<xsl:attribute name="class">required</xsl:attribute>
</xsl:if>
<xsl:value-of select="$contextNode/geo/@name"/>
<xsl:if test="$required=true()">
<abbr title="Required">*</abbr>
</xsl:if></label>
<xsl:call-template name="geoSelect">
<xsl:with-param name="contextNode" select="$contextNode" />
<xsl:with-param name="currentGeo" select="$currentGeo" />
<xsl:with-param name="geoLocation" select="$geoLocation" />
<xsl:with-param name="geoVarname" select="$geoVarname" />
</xsl:call-template>
</li>
</xsl:template>


<!-- ###############################
     GEO SELECT
     ############################### -->
<xsl:template name="geoSelect">
<xsl:param name="contextNode" select="/root"/>
<xsl:param name="emptyOption" select="true()"/>
<xsl:param name="geoLocation" select="/root/site/@geo"/>
<xsl:param name="currentGeo"/>
<xsl:param name="geoVarname" select="'id_geo'"/>
<select name="{$geoVarname}">
<xsl:if test="$emptyOption=true()">
<option value="0"><xsl:value-of select="key('label','choose_option')/@tr"/></option>
</xsl:if>
<xsl:choose>
<xsl:when test="$geoLocation='1'">
<xsl:for-each select="$contextNode/geo/provinces/province">
<option value="{@id}">
<xsl:if test="@id=$currentGeo"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>
<xsl:value-of select="@name"/></option>
</xsl:for-each>
</xsl:when>
<xsl:when test="$geoLocation='5'">
<xsl:for-each select="$contextNode/geo/regions/region">
<option value="{@id}">
<xsl:if test="@id=$currentGeo"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>
<xsl:value-of select="@name"/></option>
</xsl:for-each>
</xsl:when>
<xsl:when test="$geoLocation='2' or $geoLocation='6' or $geoLocation='7' ">
<xsl:for-each select="$contextNode/geo/countries/country">
<option value="{@id}">
<xsl:if test="@id=$currentGeo"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>
<xsl:value-of select="@name"/></option>
</xsl:for-each>
</xsl:when>
<xsl:when test="$geoLocation='3' or $geoLocation='4'">
<xsl:for-each select="$contextNode/geo/counties/county">
<option value="{@id}">
<xsl:if test="@id=$currentGeo"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>
<xsl:value-of select="@name"/></option>
</xsl:for-each>
</xsl:when>
</xsl:choose>
</select>
</xsl:template>


<!-- ###############################
     LOGOS
     ############################### -->
<xsl:template name="logoWAIA">
<a href="https://www.w3.org/WAI/WCAG1A-Conformance" title="Explanation of Level A Conformance">
<img height="32" width="88" src="{/root/site/@base}/logos/wcag1A.png" alt="Level A conformance icon, W3C-WAI Web Content Accessibility Guidelines 1.0"/></a>
</xsl:template>

<xsl:template name="logoWAIAA">
<a href="https://www.w3.org/WAI/WCAG1AA-Conformance" title="Explanation of Level Double-A Conformance">
<img height="32" width="88" src="{/root/site/@base}/logos/wcag1AA.png" alt="Level Double-A conformance icon, W3C-WAI Web Content Accessibility Guidelines 1.0"/></a>
</xsl:template>

<xsl:template name="logoWAIAAA">
<a href="https://www.w3.org/WAI/WCAG1AAA-Conformance" title="Explanation of Level Triple-A Conformance">
<img height="32" width="88" src="{/root/site/@base}/logos/wcag1AAA.png" alt="Level Triple-A conformance icon, W3C-WAI Web Content Accessibility Guidelines 1.0"/></a>
</xsl:template>


<!-- ###############################
     SHOW XML
     ############################### -->
<xsl:template name="showXml">
  <textarea cols="120" rows="30">
<xsl:text disable-output-escaping="yes">&amp;lt;</xsl:text>![CDATA[<xsl:copy-of select="/"/>]]<xsl:text disable-output-escaping="yes">&amp;gt;</xsl:text>
  </textarea>
</xsl:template>


<!-- ###############################
     PAGING
     Paging header and footer
     ############################### -->
<xsl:template name="paging">
<xsl:param name="currentPage"/>
<xsl:param name="totalPages"/>
<xsl:param name="totalItems"/>
<xsl:param name="label"/>
<xsl:param name="type" select="'header'"/>
<xsl:param name="node"/>
<div class="paging-bar">
<xsl:if test="$type='header'">
<xsl:value-of select="concat($totalItems,' ',$label)"/>
</xsl:if>
<xsl:if test="$totalPages &gt; 1">
<xsl:choose>
<xsl:when test="$type='header'">
<xsl:if test="$totalPages &gt; 1">
  - <xsl:value-of select="key('label','page')/@tr"/><xsl:text> </xsl:text> 
<xsl:call-template name="pagingLoop">
<xsl:with-param name="currentPage" select="1"/>
<xsl:with-param name="selectedPage" select="number($currentPage)"/>
<xsl:with-param name="totalPages" select="number($totalPages)"/>
<xsl:with-param name="node" select="$node"/>
</xsl:call-template>
</xsl:if>
</xsl:when>
<xsl:otherwise>
<xsl:value-of select="concat(key('label','page')/@tr,' ',$currentPage,' ',key('label','of')/@tr,' ',$totalPages)"/>
<xsl:if test="$totalPages &gt; 1">
| 
<xsl:call-template name="createLink">
<xsl:with-param name="name" select="key('label','previous')/@tr"/>
<xsl:with-param name="node" select="$node"/>
<xsl:with-param name="p" select="number($currentPage) - 1" />
<xsl:with-param name="condition" select="$currentPage &gt; 1"/>
</xsl:call-template>
-
<xsl:call-template name="createLink">
<xsl:with-param name="name" select="key('label','next')/@tr"/>
<xsl:with-param name="node" select="$node"/>
<xsl:with-param name="p" select="number($currentPage) + 1"/>
<xsl:with-param name="condition" select="$currentPage &lt; $totalPages"/>
</xsl:call-template>
</xsl:if>
</xsl:otherwise>
</xsl:choose>
</xsl:if>		
</div>
</xsl:template>
	
	
<!-- ###############################
     PAGING LOOP
     Creates the links to the pages, excluding those farther 
     than $pageDiff from the selected page
     ############################### -->
<xsl:template name="pagingLoop">
<xsl:param name="currentPage"/>
<xsl:param name="selectedPage"/>
<xsl:param name="totalPages"/>
<xsl:param name="node"/>
<xsl:variable name="pageSeparator" select="' '"/>
<xsl:variable name="pageDiff" select="2"/>

<xsl:call-template name="createLink">
	<xsl:with-param name="name" select="1"/>
	<xsl:with-param name="node" select="$node"/>
	<xsl:with-param name="p" select="1"/>
	<xsl:with-param name="condition" select="$selectedPage!=1"/>
</xsl:call-template>
<xsl:if test="$selectedPage &gt; 3">
	<xsl:value-of select="$pageSeparator"/>...
</xsl:if>
<xsl:value-of select="$pageSeparator"/>
<xsl:if test="$selectedPage &gt; 2">
	<xsl:call-template name="createLink">
		<xsl:with-param name="name" select="$selectedPage - 1"/>
		<xsl:with-param name="node" select="$node"/>
		<xsl:with-param name="p" select="$selectedPage - 1"/>
	</xsl:call-template>
	<xsl:value-of select="$pageSeparator"/>
</xsl:if>
<xsl:if test="$selectedPage!=1 and $selectedPage!=$totalPages">
	<xsl:call-template name="createLink">
		<xsl:with-param name="name" select="$selectedPage"/>
		<xsl:with-param name="node" select="$node"/>
		<xsl:with-param name="p" select="$selectedPage"/>
		<xsl:with-param name="condition" select="false()"/>
	</xsl:call-template>
	<xsl:value-of select="$pageSeparator"/>
</xsl:if>
<xsl:if test="$selectedPage &lt; ($totalPages - 1)">
	<xsl:call-template name="createLink">
		<xsl:with-param name="name" select="$selectedPage + 1"/>
		<xsl:with-param name="node" select="$node"/>
		<xsl:with-param name="p" select="$selectedPage + 1"/>
	</xsl:call-template>
	<xsl:value-of select="$pageSeparator"/>
</xsl:if>
<xsl:if test="$selectedPage &lt; ($totalPages - 2)">
	<xsl:value-of select="$pageSeparator"/>...
</xsl:if>
<xsl:call-template name="createLink">
	<xsl:with-param name="name" select="$totalPages"/>
	<xsl:with-param name="node" select="$node"/>
	<xsl:with-param name="p" select="$totalPages"/>
	<xsl:with-param name="condition" select="$selectedPage!=$totalPages"/>
</xsl:call-template>
</xsl:template>


<!-- ###############################
     OPTION LOOP
     ############################### -->
<xsl:template name="optionLoop">
<xsl:param name="from" />
<xsl:param name="to" />
<xsl:param name="value" />
<option value="{$from}">
<xsl:if test="$from=$value">
<xsl:attribute name="selected">selected</xsl:attribute>
</xsl:if>
<xsl:value-of select="$from"/>
</option>
<xsl:if test="$from &lt; $to">
<xsl:call-template name="optionLoop">
<xsl:with-param name="from" select="($from + 1)" />
<xsl:with-param name="to" select="$to" />
<xsl:with-param name="value" select="$value" />
</xsl:call-template>
</xsl:if>
</xsl:template>	


<!-- ###############################
     STRING INSERT
     ############################### -->
<xsl:template name="stringInsert">
<xsl:param name="string" />
<xsl:param name="before" />
<xsl:param name="value" />
<xsl:value-of select="concat(substring-before($string,$before),$value,$before)" />
</xsl:template>	


<!-- ###############################
     STRING SEARCH AND REPLACE
     ############################### -->
<xsl:template name="stringReplace">
<xsl:param name="string" />
<xsl:param name="find" />
<xsl:param name="replace" />
<xsl:param name="all" select="'yes'" />
<xsl:value-of select="concat (substring-before ($string, $find), $replace)" />
<xsl:choose>
<xsl:when test="contains (substring-after ($string, $find), $find) and $all = 'yes'">
<xsl:call-template name="stringReplace">
<xsl:with-param name="string" select="substring-after ($string, $find)" />
<xsl:with-param name="find" select="$find" />
<xsl:with-param name="replace" select="$replace" />
<xsl:with-param name="all" select="$all" />
</xsl:call-template>
</xsl:when>
<xsl:otherwise>
<xsl:value-of select="substring-after ($string, $find)" />
</xsl:otherwise>
</xsl:choose>
</xsl:template>	


<!-- ###############################
     STRING REPLACE SINGLE QUOTES
     ############################### -->
<xsl:template name="stringReplaceSingleQuotes">
<xsl:param name="string" />
<xsl:call-template name="stringReplace">
<xsl:with-param name="string" select="$string"/>
<xsl:with-param name="find">'</xsl:with-param>
<xsl:with-param name="replace" select="'&amp;apos;'" />
</xsl:call-template>
</xsl:template>	


<!-- ###############################
     STRING SPLIT
     ############################### -->
<xsl:template name="stringSplit2Option">
<xsl:param name="str"/>
<xsl:param name="separator" select="','"/>
<xsl:choose>
<xsl:when test="contains($str,$separator)">
<option value="{substring-before($str,$separator)}"><xsl:value-of select="substring-before($str,$separator)"/></option>
<xsl:call-template name="stringSplit">
<xsl:with-param name="str" select="substring-after($str,$separator)"/>
</xsl:call-template>
</xsl:when>
<xsl:otherwise>
<option value="{$str}"><xsl:value-of select="$str"/></option>
</xsl:otherwise>
</xsl:choose>
</xsl:template>


<!-- ###############################
     PREVIEW TOOLBAR
     ############################### -->
<xsl:template name="previewToolbar">
<div id="preview-toolbar">Preview Toolbar
 - <a href="{/root/preview/@edit}"><b>Edit</b></a>
 - <a href="{/root/preview/@xml}"><b>XML</b></a>
<xsl:if test="not(/root/publish/@ui='1')">
 - <b>XSL</b> gen: 
<xsl:for-each select="/root/preview/generic/xsl">
<a href="{@edit}"><xsl:value-of select="@type"/></a>
<xsl:if test="position()!=last()">,</xsl:if>
</xsl:for-each>
<xsl:if test="/root/preview/style">
style<xsl:value-of select="/root/preview/style/@id"/>:
<xsl:for-each select="/root/preview/style/xsl">
<a href="{@edit}"><xsl:value-of select="@type"/></a>
<xsl:if test="position()!=last()">,</xsl:if>
</xsl:for-each>
</xsl:if>
 - <b>CSS</b> gen:
<xsl:for-each select="/root/preview/generic/css">
<a href="{@edit}"><xsl:value-of select="@type"/></a>
<xsl:if test="position()!=last()">,</xsl:if>
</xsl:for-each>
<xsl:if test="/root/preview/style">
s<xsl:value-of select="/root/preview/style/@id"/>:
<xsl:for-each select="/root/preview/style/css">
<a href="{@edit}"><xsl:value-of select="@type"/></a>
<xsl:if test="position()!=last()">,</xsl:if>
</xsl:for-each>
</xsl:if>
</xsl:if>
 - <b>Features</b> gen:
<xsl:if test="/root/preview/generic/features">
<xsl:for-each select="/root/preview/generic/features/feature">
<a href="{@edit}"><xsl:value-of select="@id"/></a>
<xsl:if test="position()!=last()">, </xsl:if>
</xsl:for-each>
</xsl:if>
<xsl:if test="/root/preview/style/features">
s<xsl:value-of select="/root/preview/style/@id"/>:
<xsl:for-each select="/root/preview/style/features/feature">
<a href="{@edit}"><xsl:value-of select="@id"/></a>
<xsl:if test="position()!=last()">, </xsl:if>
</xsl:for-each>
</xsl:if>
</div>
</xsl:template>


<!-- ###############################
     UPPERCASE
     ############################### -->
<xsl:template name="uppercase">
<xsl:param name="text"/>
<xsl:variable name="lowercase" select="'abcdefghijklmnopqrstuvwxyz'"/>
<xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'"/>
<xsl:value-of select="translate($text, $lowercase, $uppercase)"/>
</xsl:template>
<!-- ###############################
     LOWERCASE
     ############################### -->
<xsl:template name="lowercase">
<xsl:param name="text"/>
<xsl:variable name="lowercase" select="'abcdefghijklmnopqrstuvwxyz'"/>
<xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'"/>
<xsl:value-of select="translate($text, $uppercase, $lowercase)"/>
</xsl:template>


<!-- ###############################
     PARAM [CUSTOM]
     ############################### -->
<xsl:template match="param" mode="custom">
<xsl:variable name="varname" select="concat('param_',@id)"/>
<xsl:variable name="required" select="@mandatory='1'"/>
<xsl:choose>
<xsl:when test="@type='textarea'  ">
<xsl:call-template name="formInput">
<xsl:with-param name="tr_label" select="@label"/>
<xsl:with-param name="varname" select="$varname"/>
<xsl:with-param name="type">textarea</xsl:with-param>
<xsl:with-param name="required" select="$required"/>
<xsl:with-param name="value" select="@value"/>
</xsl:call-template>
</xsl:when>
<xsl:when test="@type='checkbox' or @type='subscription' ">
<xsl:call-template name="formInput">
<xsl:with-param name="tr_label" select="@label"/>
<xsl:with-param name="varname" select="$varname"/>
<xsl:with-param name="type">checkbox</xsl:with-param>
<xsl:with-param name="required" select="$required"/>
</xsl:call-template>
</xsl:when>
<xsl:when test="@type='geo'  ">
<xsl:call-template name="formInputGeo">
<xsl:with-param name="contextNode" select="."/>
<xsl:with-param name="geoLocation" select="geo/@geo_location"/>
<xsl:with-param name="required" select="$required"/>
<xsl:with-param name="geoVarname" select="'id_geo'"/>
</xsl:call-template>
</xsl:when>
<xsl:when test="@type='dropdown' ">
<li>
<label for="{$varname}"><xsl:value-of select="@label"/></label>
<select name="{$varname}">
<xsl:for-each select="subparams/subparam">
<option value="{@value}"><xsl:value-of select="@value"/></option>
</xsl:for-each>
</select>
</li>
</xsl:when>
<xsl:when test="@type='dropdown_open' ">
<script type="text/javascript">
$().ready(function() {
	$('input#<xsl:value-of select="$varname"/>\\[\\]').change(function () {
		$('input#<xsl:value-of select="$varname"/>_other').val("");
	});
	$('input#<xsl:value-of select="$varname"/>_other').focus(function () {
		$('input#<xsl:value-of select="$varname"/>\\[\\]').attr("checked",false);
	});
});
</script>
<fieldset class="dropdown-open">
<legend><xsl:value-of select="@label"/></legend>
<xsl:variable name="radio_id" select="@label"/>
<ul class="form-inputs">
<xsl:for-each select="subparams/subparam">
<xsl:call-template name="formInput">
<xsl:with-param name="tr_label" select="@value"/>
<xsl:with-param name="varname" select="concat($varname,'[]')"/>
<xsl:with-param name="type">radio</xsl:with-param>
<xsl:with-param name="value" select="@value"/>
</xsl:call-template>
</xsl:for-each>
<xsl:call-template name="formInput">
<xsl:with-param name="tr_label" select="key('label','other')/@tr"/>
<xsl:with-param name="varname" select="concat($varname,'_other')"/>
</xsl:call-template>
</ul>
</fieldset>
</xsl:when>
<xsl:when test="@type='radio' ">
<fieldset class="radio">
<legend><xsl:value-of select="@label"/></legend>
<xsl:variable name="radio_id" select="@label"/>
<ul class="form-inputs">
<xsl:for-each select="subparams/subparam">
<xsl:call-template name="formInput">
<xsl:with-param name="tr_label" select="@value"/>
<xsl:with-param name="varname" select="$varname"/>
<xsl:with-param name="type">radio</xsl:with-param>
<xsl:with-param name="value" select="@value"/>
</xsl:call-template>
</xsl:for-each>
</ul>
</fieldset>
</xsl:when>
<xsl:when test="@type='mchoice' ">
<fieldset class="mchoice">
<legend><xsl:value-of select="@label"/></legend>
<xsl:variable name="checkbox_id" select="@label"/>
<ul class="form-inputs">
<xsl:for-each select="subparams/subparam">
<xsl:call-template name="formInput">
<xsl:with-param name="tr_label" select="@value"/>
<xsl:with-param name="varname" select="concat($varname,'[]')"/>
<xsl:with-param name="box_value" select="@value"/>
<xsl:with-param name="type">checkbox</xsl:with-param>
</xsl:call-template>
</xsl:for-each>
</ul>
</fieldset>
</xsl:when>
<xsl:when test="@type='mchoice_open' ">
<fieldset class="mchoice">
<legend><xsl:value-of select="@label"/></legend>
<xsl:variable name="checkbox_id" select="@label"/>
<ul class="form-inputs">
<xsl:for-each select="subparams/subparam">
<xsl:call-template name="formInput">
<xsl:with-param name="tr_label" select="@value"/>
<xsl:with-param name="varname" select="concat($varname,'[]')"/>
<xsl:with-param name="box_value" select="@value"/>
<xsl:with-param name="type">checkbox</xsl:with-param>
</xsl:call-template>
</xsl:for-each>
<xsl:call-template name="formInput">
<xsl:with-param name="tr_label" select="key('label','other')/@tr"/>
<xsl:with-param name="varname" select="concat($varname,'[]')"/>
</xsl:call-template>
</ul>
</fieldset>
</xsl:when>
<xsl:when test="@type='upload' or @type='upload_image'">
<li>
<label for="{$varname}"><xsl:value-of select="@label"/></label>
<input type="file" name="{$varname}[]"/>
</li>
</xsl:when>
<xsl:when test="@type='link'">
<xsl:call-template name="formInput">
<xsl:with-param name="tr_label" select="@label"/>
<xsl:with-param name="varname" select="$varname"/>
<xsl:with-param name="size">link</xsl:with-param>
<xsl:with-param name="required" select="$required"/>
<xsl:with-param name="value" select="@value"/>
</xsl:call-template>
</xsl:when>
<xsl:otherwise>
<xsl:call-template name="formInput">
<xsl:with-param name="tr_label" select="@label"/>
<xsl:with-param name="varname" select="$varname"/>
<xsl:with-param name="required" select="$required"/>
<xsl:with-param name="value">
<xsl:choose>
<xsl:when test="/root/postback/var[@name=$varname]">
<xsl:value-of select="/root/postback/var[@name=$varname]/@value"/>
</xsl:when>
<xsl:when test="@use and /root/user/@id">
<xsl:choose>
<xsl:when test="@use=1"><xsl:value-of select="/root/user/@name1"/></xsl:when>
<xsl:when test="@use=2"><xsl:value-of select="/root/user/@name2"/></xsl:when>
<xsl:when test="@use=3"><xsl:value-of select="/root/user/@name3"/></xsl:when>
<xsl:when test="@use=4"><xsl:value-of select="/root/user/@email"/></xsl:when>
</xsl:choose>
</xsl:when>
<xsl:otherwise><xsl:value-of select="@value"/></xsl:otherwise>
</xsl:choose>
</xsl:with-param>
</xsl:call-template>
</xsl:otherwise>
</xsl:choose>
</xsl:template>


<!-- ###############################
	CAPTCHA WRAPPER
	############################### -->
<xsl:template name="captchaWrapper">
<xsl:if test="/root/site/@recaptcha_public_key and not(/root/user/@id &gt; 0)">
<xsl:call-template name="recaptcha"/>
</xsl:if>
</xsl:template>


<!-- ###############################
	RECAPTCHA
	############################### -->
<xsl:template name="recaptcha">
<xsl:param name="theme" select="'light'"/>
<xsl:param name="size" select="'normal'"/>
<script src='https://www.google.com/recaptcha/api.js?hl={$current_lang}'></script>
<div class="g-recaptcha" data-sitekey="{/root/site/@recaptcha_public_key}" data-theme="{$theme}" data-size="{$size}"></div>
</xsl:template>

    
<!-- ###############################
     SLIDESHOW
     ############################### -->
<xsl:template name="slideshow">
<xsl:param name="id"/>
<xsl:param name="width"/>
<xsl:param name="height"/>
<xsl:param name="images"/>
<xsl:param name="controls" select="true()"/>
<xsl:param name="repeat" select="true()"/>
<xsl:param name="audio" select="''"/>
<xsl:param name="transition" select="'fade'"/>
<xsl:param name="watermark" select="''"/>
<xsl:param name="shuffle" select="'false'"/>
<xsl:param name="jscaptions" select="false()"/>
<xsl:param name="bgcolor" select="'0x000000'"/>

<xsl:if test="$jscaptions=true()">
<script type="text/javascript">
var currentItem<xsl:value-of select="$id"/>;

function getUpdate(typ,pr1,pr2,swfid) {
  eval("getUpdate"+swfid+"('"+typ+"','"+pr1+"','"+pr2+"')");
}

function getUpdate<xsl:value-of select="$id"/>(typ,pr1,pr2) {
  if(typ == 'item') {
  	currentItem<xsl:value-of select="$id"/> = pr1; 
  	setTimeout("getItemData<xsl:value-of select="$id"/>(currentItem<xsl:value-of select="$id"/>)",100);
  }
};
function getItemData<xsl:value-of select="$id"/>(idx) {
var obj = thisMovie("galshow-<xsl:value-of select="$id"/>").itemData(idx);
gc = document.getElementById("slide-caption-<xsl:value-of select="$id"/>");
gc.innerHTML = obj['description'];
};
</script>
</xsl:if>

<div id="galshow-{$id}" class="slideshow"><p class="flash-warning"><xsl:value-of select="key('label','flash_warning')/@tr" disable-output-escaping="yes"/></p></div>
<script type="text/javascript">
var flashvars = {};
flashvars.javascriptid = '<xsl:value-of select="$id"/>';
flashvars.width = '<xsl:value-of select="$width"/>';
flashvars.height = '<xsl:value-of select="$height"/>';
flashvars.file = encodeURIComponent('<xsl:value-of select="$images"/>');
<xsl:if test="$audio!=''">
flashvars.audio = encodeURIComponent('<xsl:value-of select="$audio"/>');
flashvars.showeq = 'true';
</xsl:if>
<xsl:if test="$watermark!=''">
flashvars.logo = encodeURIComponent('<xsl:value-of select="$watermark"/>');
</xsl:if>
flashvars.shuffle = '<xsl:value-of select="$shuffle"/>';
flashvars.screencolor = '<xsl:value-of select="$bgcolor"/>';
flashvars.shownavigation = 'true';
<xsl:if test="$jscaptions=true()">
flashvars.enablejs = 'true';
</xsl:if>
flashvars.linkfromdisplay = 'true';
flashvars.overstretch = 'false';
flashvars.transition = '<xsl:value-of select="$transition"/>';
var params = {};
params.allowfullscreen = 'false';
params.wmode = 'opaque';
params.bgcolor = '<xsl:value-of select="$bgcolor"/>';
var attributes = {};
attributes.id = "galshow-<xsl:value-of select="$id"/>";
swfobject.embedSWF("/tools/imagerotator.swf","galshow-<xsl:value-of select="$id"/>",'<xsl:value-of select="$width"/>','<xsl:value-of select="$height"/>','9.0.0','<xsl:value-of select="/root/site/@base"/>/tools/expressInstall.swf',flashvars,params,attributes);
</script>
</xsl:template>


   
<!-- ###############################
     FACEBOOK LIKE
     ############################### -->
<xsl:template name="facebookLike">
<xsl:param name="width" select="200"/>
<xsl:param name="action" select="'like'"/>
<xsl:param name="layout" select="'standard'"/>
<xsl:param name="faces" select="'false'"/>
<div class="facebook-like">
<iframe src="https://www.facebook.com/plugins/like.php?href={/root/page/@url_encoded}&amp;locale={/root/site/@lang_code}&amp;layout={$layout}&amp;show-faces={$faces}&amp;width={$width}&amp;action={$action}&amp;colorscheme=light" scrolling="no" frameborder="0" style="border:none; overflow:hidden; width:{$width}px;" allowTransparency="true"></iframe>
</div>
</xsl:template>


<!-- ###############################
     GOOGLE ANALYTICS
     ############################### -->
<xsl:template name="googleAnalytics">
<xsl:param name="ua-id" />
<xsl:param name="domain" />
<xsl:if test="$preview=false() and $ua-id != ''">
<script type="text/javascript">
<xsl:text disable-output-escaping="yes">
var _gaq = _gaq || [];
_gaq.push(['_setAccount', '</xsl:text><xsl:value-of select="$ua-id"/><xsl:text disable-output-escaping="yes">']);</xsl:text>
<xsl:if test="$domain != ''">
<xsl:text disable-output-escaping="yes">
_gaq.push(['_setDomainName', '</xsl:text><xsl:value-of select="$domain"/><xsl:text disable-output-escaping="yes">']);</xsl:text>
</xsl:if>
<xsl:text disable-output-escaping="yes">
_gaq.push(['_trackPageview']);
(function() {
	var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
	ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
	var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
})();
</xsl:text>
</script>
</xsl:if>
</xsl:template>


<!-- ###############################
     GOOGLE UNIVERSAL ANALYTICS
     ############################### -->
<xsl:template name="googleUniversalAnalytics">
<xsl:param name="ua-id" />
<xsl:if test="$preview=false() and $ua-id != ''">
<script type="text/javascript">
<xsl:text disable-output-escaping="yes">
(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
})(window,document,'script','//www.google-analytics.com/analytics.js','ga');
ga('create', '</xsl:text><xsl:value-of select="$ua-id"/><xsl:text disable-output-escaping="yes">', 'auto');
ga('send', 'pageview');
</xsl:text>
</script>
</xsl:if>
</xsl:template>


<!-- ###############################
     GOOGLE PLUS ONE
     ############################### -->
<xsl:template name="googlePlusOne">
<xsl:param name="size" select="'standard'"/>
<xsl:param name="count" select="true()"/>
<g:plusone><xsl:attribute name="size"><xsl:value-of select="$size"/></xsl:attribute><xsl:if test="not($count)"><xsl:attribute name="count">false</xsl:attribute></xsl:if></g:plusone>
<script type="text/javascript">
  window.___gcfg = {lang: '<xsl:value-of select="$current_lang"/>'};
  (function() {
    var po = document.createElement('script'); po.type = 'text/javascript'; po.async = true;
    po.src = 'https://apis.google.com/js/plusone.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(po, s);
  })();
</script>
</xsl:template>


</xsl:stylesheet>
