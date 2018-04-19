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

<xsl:variable name="node-widgets" select="/root/widgets"/>

<xsl:variable name="user_id" select="/root/user/@id"/>

<!-- ###############################
     WIDGET CONTENT
     ############################### -->
<xsl:template name="widgetContent">
	<xsl:call-template name="widgetNoJavascriptWarning" />
	<div id="widgets-content">
		<xsl:attribute name="class">
          	<xsl:choose>
			<xsl:when test="$subtype!=''"><xsl:value-of select="$subtype"/></xsl:when>
			<xsl:otherwise>widget_home</xsl:otherwise>
          	</xsl:choose>
          </xsl:attribute>
	
          <xsl:choose>
			<xsl:when test="$subtype='widget_library'">
				<xsl:call-template name="browseWidget" />
				<xsl:call-template name="widgetLibrary"/>
			</xsl:when>
			<xsl:when test="$subtype='widget_category'">
				<xsl:call-template name="browseWidget" />
				<xsl:call-template name="widgetCategory"/>
			</xsl:when>
			<xsl:when test="$subtype='widget_search'">
				<xsl:call-template name="browseWidget" />
				<xsl:call-template name="widgetSearch"/>
			</xsl:when>
			<xsl:when test="$subtype='widget_content_search'">
				<xsl:call-template name="browseWidget" />
				<xsl:call-template name="widgetContentSearch"/>
			</xsl:when>
			<xsl:when test="$subtype='mywidgets'">
				<xsl:call-template name="browseWidget" />
				<xsl:call-template name="myWidgets"/>
			</xsl:when>
			<xsl:when test="$subtype='widget_create'">
				<xsl:call-template name="browseWidget" />
				<xsl:call-template name="widgetCreate"/>
			</xsl:when>
			<xsl:when test="$subtype='widget_edit'">
				<xsl:call-template name="browseWidget" />
				<xsl:call-template name="widgetEdit"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="widgetCustomContent"/>
				<div id="tab-wrapper">
					<ul id="tab-navigation">
					</ul>
				</div> 
			</xsl:otherwise>
          </xsl:choose>
	</div>
</xsl:template>


<!-- ###############################
     WIDGET CUSTOM CONTENT
     ############################### -->
<xsl:template name="widgetCustomContent">
<p>Custom content</p>
</xsl:template>


<!-- ###############################
     WIDGET LIBRARY
     ############################### -->
<xsl:template name="widgetLibrary">
	<xsl:call-template name="searchWidget" />
	<xsl:call-template name="createWidget" />
	<xsl:call-template name="resetWidgets" />
	
	<div id="list-widget" class="search">
		<div class="widget-category background clearfix">
			<form method="post" action="actions.php" enctype="multipart/form-data" id="delete_widget">
				<input type="hidden" name="from" value="delete_widget"/>
				<input type="hidden" name="id" value=""/>
			</form>
			<h4><xsl:value-of select="key('label','my_widgets')/@tr"/></h4>
			<xsl:choose>
				<xsl:when test="$node-widgets/my_widgets/widget">
					<ul>
						<xsl:apply-templates select="$node-widgets/my_widgets" mode="listWidgets"/>
					</ul>
				</xsl:when>
				<xsl:otherwise>
					<p><xsl:value-of select="key('label','no_widgets')/@tr"/><xsl:text> </xsl:text><a href="/widgets/create.php?{/root/topic/@id}"><xsl:value-of select="key('label','would_create')/@tr"/></a></p>
				</xsl:otherwise>
			</xsl:choose>
		</div>
		<xsl:apply-templates select="$node-widgets/categories/category" mode="widgetLibrary-defaultList"/>
	</div>
</xsl:template>


<!-- ###############################
     WIDGET CATEGORY MATCH
     ############################### -->
<xsl:template match="category" mode="widgetLibrary-defaultList">
	<xsl:if test="number(@num_widgets) &gt; 0 and @library_show_widget=1">
		<div class="widget-category background clearfix">
			<h4>
				<xsl:value-of select="@name"/>
			</h4>
			<ul>
				<xsl:apply-templates select="widgets" mode="listWidgets"/>
			</ul>
		</div>
	</xsl:if>
</xsl:template>


<!-- ###############################
     WIDGET CATEGORY
     ############################### -->
<xsl:template name="widgetCategory">
	<xsl:call-template name="searchWidget" />
	<xsl:call-template name="createWidget" />

	<div id="list-widget" class="search">
		<xsl:apply-templates select="$node-widgets" mode="widgetCategoryBrowse"/>
		<xsl:if test="number($node-widgets/widget_category/items/@tot_pages) &gt; 0">
			<div class="widget-category background pagination clearfix">
				<xsl:call-template name="widgetsItems">
					<xsl:with-param name="root" select="$node-widgets/widget_category/items"/>
					<xsl:with-param name="node" select="$node-widgets/widget_category"/>
				</xsl:call-template>
			</div>
		</xsl:if>
	</div>
</xsl:template>


<!-- ###############################
     WIDGET SEARCH
     ############################### -->
<xsl:template name="widgetSearch">
	<xsl:call-template name="searchWidget" />
	<xsl:call-template name="createWidget" />
	<div id="list-widget" class="search">
		<xsl:apply-templates select="$node-widgets" mode="widgetSearchTerm">
			<xsl:with-param name="node" select="$node-widgets/search"/>
			<xsl:with-param name="results_count" select="$node-widgets/search/widgets" />
		</xsl:apply-templates>
		<xsl:if test="number($node-widgets/search/widgets/@tot_pages) &gt; 0">
			<div class="widget-search background pagination clearfix">
				<xsl:call-template name="widgetsItems">
					<xsl:with-param name="root" select="$node-widgets/search/widgets"/>
					<xsl:with-param name="node" select="$node-widgets/search"/>
				</xsl:call-template>
			</div>
		</xsl:if>
	</div>
</xsl:template>


<!-- ###############################
     WIDGET CONTENT SEARCH
     ############################### -->
<xsl:template name="widgetContentSearch">
	<xsl:call-template name="searchWidget" />
	<xsl:call-template name="createWidget" />
	<div id="list-widget" class="search">
		<xsl:apply-templates select="$node-widgets" mode="widgetSearchTerm">
			<xsl:with-param name="node" select="$node-widgets/search"/>
			<xsl:with-param name="results_count" select="$node-widgets/search/web_feed_items" />
		</xsl:apply-templates>		
		<xsl:if test="number($node-widgets/search/web_feed_items/@tot_pages) &gt; number(0)">
			<div class="widget-search background pagination clearfix">
				<xsl:call-template name="widgetsItems">
					<xsl:with-param name="root" select="$node-widgets/search/web_feed_items"/>
					<xsl:with-param name="node" select="$node-widgets/search"/>
				</xsl:call-template>
			</div>
		</xsl:if>
	</div>
</xsl:template>


<!-- ###############################
     WIDGET NO JAVASCRIPT WARNING
     ############################### -->
<xsl:template name="widgetNoJavascriptWarning">
	<div id="message" class="ui-widget">
		<noscript>
			<div class="ui-state-error ui-corner-all">
				<p>
					<span style="float: left; margin-right: 0.3em;" class="ui-icon ui-icon-alert"/>
					<strong>Alert:</strong> Seems like you don't have JavaScript enabled to experience <xsl:value-of select="/root/site/@title"/> fully.</p>
			</div>
		</noscript>
	</div>
</xsl:template>


<!-- ###############################
     MY WIDGETS
     ############################### -->
<xsl:template name="myWidgets">
	<xsl:call-template name="searchWidget" />
	<xsl:call-template name="createWidget" />

	<div id="list-widget">
		<div class="widget-category background clearfix">
			<form method="post" action="actions.php" enctype="multipart/form-data" id="delete_widget">
				<input type="hidden" name="from" value="delete_widget"/>
				<input type="hidden" name="id" value=""/>
			</form>
			<h4><xsl:value-of select="key('label','my_widgets')/@tr"/>
			<xsl:apply-templates select="$node-widgets/my_widgets" mode="widgetCategoryBrowseTotalItems"/>
			</h4>
			<xsl:choose>
				<xsl:when test="number($node-widgets/my_widgets/items/@tot_items) &gt; 0">
					<ul>
						<xsl:apply-templates select="$node-widgets/my_widgets" mode="listWidgets"/>
					</ul>
				</xsl:when>
				<xsl:otherwise>
					<p><xsl:value-of select="key('label','no_widgets')/@tr"/><xsl:text> </xsl:text><a href="/widgets/create.php?{/root/topic/@id}"><xsl:value-of select="key('label','would_create')/@tr"/></a></p>
				</xsl:otherwise>
			</xsl:choose>
		</div>
		<xsl:if test="number($node-widgets/my_widgets/items/@tot_pages) &gt; 0">
			<div class="widget-search background pagination clearfix">
				<xsl:call-template name="widgetsItems">
					<xsl:with-param name="root" select="/root/widgets/my_widgets/items"/>
					<xsl:with-param name="node" select="/root/widgets/my_widgets"/>
				</xsl:call-template>
			</div>
		</xsl:if>
	</div>
</xsl:template>


<!-- ###############################
     WIDGET CREATE
     ############################### -->
<xsl:template name="widgetCreate">
	<div id="list-widget" class="add clearfix">
		<div class="widget-create background clearfix">
			<ul id="create-widget-navigation">
				<li><a href="#create-rss-widget"><xsl:value-of select="key('label','widget_create_rss')/@tr"/></a></li>
				<li><a href="#create-manual-widget"><xsl:value-of select="key('label','widget_create_manual')/@tr"/></a></li>
				<li><a href="#create-advance-manual-widget"><xsl:value-of select="key('label','widget_create_advanced')/@tr"/></a></li>
			</ul>
			<div id="create-rss-widget">
				<p><xsl:value-of select="key('label','widget_create_rss_welcome')/@tr"/></p>
				<form method="post" action="actions.php" id="create-rss">
					<input type="hidden" name="from" value="create_rss_widget"/>
					<fieldset>
						<legend><xsl:value-of select="key('label','widget')/@tr"/></legend>
						<ul class="form-inputs">
							<li class="clearfix">
								<label for="widget_rss_title"><xsl:value-of select="key('label','title')/@tr"/></label>
								<input type="text" name="widget_rss_title" id="widget_rss_title" value="{root/widgets/rss_widget/@title}" class="widget-input-wide" />
								<small><xsl:value-of select="key('label','title')/@tr"/></small>
							</li>
							<li class="clearfix">
								<label for="widget_rss_desc"><xsl:value-of select="key('label','description')/@tr"/></label>
								<input type="text" name="widget_rss_desc" id="widget_rss_desc" value="{root/widgets/rss_widget/@description}" class="widget-input-wide" />
								<small><xsl:value-of select="key('label','widget_description')/@tr"/></small>
							</li>
							<li class="clearfix">
								<label>Feed URL</label>
								<input type="text" name="widget_rss_url" id="widget_rss_url"  value="{root/widgets/rss_widget/@url}" class="widget-input-wide" />
								<small><xsl:value-of select="concat(key('label','feed_url_example')/@tr,' ',/root/site/rss/@url)"/></small>
							</li>
							<li class="clearfix buttons">
								<button type="submit" id="widget_rss_submit" class="btn"><span><xsl:value-of select="key('label','widget_create_rss')/@tr"/></span></button>
							</li>
						</ul>
					</fieldset>
				</form>
			</div>
			<div id="create-manual-widget">
				<p><xsl:value-of select="key('label','widget_create_manual_welcome')/@tr"/></p>
				<form method="post" action="{/root/site/@upload_host}/widgets/actions.php" enctype="multipart/form-data" id="create-manual">
					<input type="hidden" name="from" value="create_manual_widget"/>
					<fieldset>
						<ul class="form-inputs">
							<li class="clearfix">
								<label for="widget_manual_title"><xsl:value-of select="key('label','title')/@tr"/></label>
								<input type="text" name="widget_manual_title" id="widget_manual_title" value="{root/widgets/manual_widget/@title}" class="widget-input-wide" />
								<small><xsl:value-of select="key('label','title')/@tr"/></small>
							</li>
							<li class="clearfix">
								<label for="widget_manual_desc"><xsl:value-of select="key('label','description')/@tr"/></label>
								<input type="text" name="widget_manual_desc" id="widget_manual_desc" value="{root/widgets/manual_widget/@description}" class="widget-input-wide" />
								<small><xsl:value-of select="key('label','widget_description')/@tr"/></small>
							</li>
							<li class="clearfix">
								<label for="widget_manual_image"><xsl:value-of select="key('label','widget_image')/@tr"/></label>
								<input id="img" type="file" name="img"/>
								<small><xsl:value-of select="key('label','widget_image_desc')/@tr"/></small>
							</li>
							<li class="clearfix">
								<label for="widget_manual_content"><xsl:value-of select="key('label','widget_content')/@tr"/></label>
								<textarea name="widget_manual_content" id="widget_manual_content" class="widget-input-content-wide"><xsl:value-of select="/root/widgets/manual_widget/@content"/></textarea>
								<small><xsl:value-of select="key('label','widget_content_desc')/@tr"/></small>
							</li>
							<li class="clearfix">
								<label for="widget_manual_link">Link</label>
								<input type="text" name="widget_manual_link" id="widget_manual_link" value="{root/widgets/manual_widget/@link_url}" class="widget-input-wide"/>
								<small><xsl:value-of select="key('label','widget_link_desc')/@tr"/></small>
							</li>
							<li class="clearfix buttons">
								<button type="submit" id="widget_manual_submit" class="btn"><span><xsl:value-of select="key('label','widget_create_manual')/@tr"/></span></button>
							</li>
						</ul>
					</fieldset>
				</form>
			</div>
			<div id="create-advance-manual-widget">
				<p><xsl:value-of select="key('label','widget_create_advanced_welcome')/@tr"/></p>
				<form method="post" action="{/root/site/@upload_host}/widgets/actions.php" enctype="multipart/form-data" id="create-advance-manual">
					<input type="hidden" name="from" value="create_advance_manual_widget"/>
					<fieldset>
						<ul class="form-inputs">
							<li class="clearfix">
								<label for="widget_advance_manual_title"><xsl:value-of select="key('label','title')/@tr"/></label>
								<input type="text" name="widget_advance_manual_title" id="widget_advance_manual_title" value="{root/widgets/advance_manual_widget/@title}" class="widget-input-wide" />
								<small><xsl:value-of select="key('label','title')/@tr"/></small>
							</li>
							<li class="clearfix">
								<label for="widget_advance_manual_desc"><xsl:value-of select="key('label','description')/@tr"/></label>
								<input type="text" name="widget_advance_manual_desc" id="widget_advance_manual_desc" value="{root/widgets/advance_manual_widget/@description}" class="widget-input-wide" />
								<small><xsl:value-of select="key('label','widget_description')/@tr"/></small>
							</li>
							<li class="clearfix">
								<label for="widget_advance_manual_image"><xsl:value-of select="key('label','widget_image')/@tr"/></label>
								<input id="img" type="file" name="img"/>
								<small><xsl:value-of select="key('label','widget_image_desc')/@tr"/></small>
							</li>
							<li class="clearfix">
								<label for="widget_advance_manual_content"><xsl:value-of select="key('label','widget_content')/@tr"/></label>
								<textarea name="widget_advance_manual_content" id="widget_advance_manual_content" class="widget-input-content-wide"><xsl:value-of select="/root/widgets/advance_manual_widget/@content"/></textarea>
								<small><xsl:value-of select="key('label','widget_content_desc')/@tr"/></small>
							</li>
							<li class="clearfix">
								<label for="widget_advance_manual_link">Link</label>
								<input type="text" name="widget_advance_manual_link" id="widget_advance_manual_link" value="{root/widgets/advance_manual_widget/@link_url}" class="widget-input-wide"/>
								<small><xsl:value-of select="key('label','widget_link_desc')/@tr"/></small>
							</li>
							<li class="clearfix buttons">
								<button type="submit" id="widget_advance_manual_submit" class="btn"><span><xsl:value-of select="key('label','widget_create_advanced')/@tr"/></span></button>
							</li>
						</ul>
					</fieldset>
				</form>
			</div>
		</div>
	</div>
</xsl:template>


<!-- ###############################
     SEARCH WIDGET - RESULTS
     ############################### -->
<xsl:template match="widgets" mode="widgetSearchTerm">
	<xsl:param name="node" />
	<xsl:param name="results_count" select="$node"/>
	<div class="widget-search background">
		<h4>Your search for <em>
				'<xsl:value-of select="$node/@qw"/>'
			</em> returned
			<xsl:choose>
				<xsl:when test="$results_count/@tot_items = 0"> no results</xsl:when>
				<xsl:when test="$results_count/@tot_items = 1"><em><xsl:value-of select="$results_count/@tot_items" /></em> result</xsl:when>
				<xsl:otherwise><em><xsl:value-of select="$results_count/@tot_items" /></em> results</xsl:otherwise>
			</xsl:choose>
		</h4>
		<xsl:if test="$results_count/@tot_items = 0">
			<p>You can try searching for another widget...</p>
		</xsl:if>
	</div>
</xsl:template>


<!-- ###############################
     CATEGORY WIDGET  -  BROWSE
     ############################### -->
<xsl:template match="widget_category" mode="widgetCategoryBrowse">
	<div class="widget-search background">
		<h4>
			<xsl:value-of select="@name"/>
			<xsl:apply-templates select="/root/widgets/widget_category" mode="widgetCategoryBrowseTotalItems"/>
		</h4>
	</div>
</xsl:template>
<xsl:template match="items" mode="widgetCategoryBrowseTotalItems">
	<em> (<xsl:value-of select="@tot_items"/>
		<xsl:choose>
			<xsl:when test="@tot_items = 1"> widget)</xsl:when>
			<xsl:otherwise> widgets)</xsl:otherwise>		
		</xsl:choose>
	 </em>
</xsl:template>


<!-- ###############################
     WIDGETS ITEMS
     ############################### -->
<xsl:template name="widgetsItems">
	<xsl:param name="root"/>
	<xsl:param name="node"/>
	<xsl:if test="number($root/@tot_pages) &gt; 1">
		<xsl:call-template name="paging">
			<xsl:with-param name="currentPage" select="$root/@page"/>
			<xsl:with-param name="totalPages" select="$root/@tot_pages"/>
			<xsl:with-param name="totalItems" select="$root/@tot_items"/>
			<xsl:with-param name="label" select="string('widgets found')"/>
			<xsl:with-param name="type" select="'header'"/>
			<xsl:with-param name="node" select="$node"/>
		</xsl:call-template>
	</xsl:if>	
	<xsl:if test="$root/@tot_items">
		<ul>
			<xsl:apply-templates select="$root/item" mode="widgetSearchListItem"/>
		</ul>
	</xsl:if>	
	<xsl:if test="number($root/@tot_pages) &gt; 1">
		<xsl:call-template name="paging">
			<xsl:with-param name="currentPage" select="$root/@page"/>
			<xsl:with-param name="totalPages" select="$root/@tot_pages"/>
			<xsl:with-param name="totalItems" select="$root/@tot_items"/>
			<xsl:with-param name="label" select="string('widgets found')"/>
			<xsl:with-param name="type" select="'footer'"/>
			<xsl:with-param name="node" select="$node"/>
		</xsl:call-template>
	</xsl:if>
</xsl:template>
<xsl:template match="item" mode="widgetSearchListItem">
	<li id="widget-{@id}" class="widget">
		<p class="widget-title">
			<xsl:choose>
				<xsl:when test="@widget_title !=''">
					<xsl:value-of select="@widget_title"/>
					<p class="widget-description">
						<xsl:value-of select="@title"/>
					</p>
				</xsl:when>
				<xsl:otherwise><xsl:value-of select="@title"/></xsl:otherwise>
			</xsl:choose>
		</p> 
		<div class="widget-actions">
			<xsl:if test="@can_edit = 1">
				<a href="/widgets/edit.php?id={@id}" class="widget-actions-edit" title="edit this widget"><span class="ui-icon ui-icon-pencil">Edit</span></a>
			</xsl:if>
			<xsl:if test="@can_edit">
				<a href="#{@id}" class="widget-actions-delete" title="delete this widget"><span class="ui-icon ui-icon-close">Delete</span></a>
			</xsl:if>
		</div>
		<p class="widget-description">
			<xsl:choose>
				<xsl:when test="@description !=''">
					<xsl:value-of select="@description"/>
				</xsl:when>
				<xsl:otherwise>Sorry, there is no description available for this widget</xsl:otherwise>
			</xsl:choose>
		</p>
		<div class="widget-action clearfix">
			<button class="btn widget-action-preview" href="#">
				<span>Preview</span>
			</button>
			<xsl:choose>
				<xsl:when test="(@status_name !='Approved' and @status_name !='')">
					<button class="btn widget-action-comments" href="#">
						<span>Status: <xsl:value-of select="@status_name"/> - learn more</span>
					</button>
					<div class="widget-comments" style="display:none;" title="Comments for {@title}">
						<h5>Status: <xsl:value-of select="@status_name"/></h5>
						<h6>Comments</h6>
						<xsl:choose>
							<xsl:when test="@comment !=''">
								<p><xsl:value-of select="@comment"/></p>
							</xsl:when>
							<xsl:otherwise>
								<p>Sorry, comment unavailable</p>
							</xsl:otherwise>
						</xsl:choose>
					</div>
				</xsl:when>
				<xsl:when test="(($user_id != '0') and ($subtype !='mywidgets' or $subtype !='widget_library') or @status_name ='Approved')">
					<button class="btn widget-action-add" href="#">
						<span>Add to homepage</span>
					</button>	
				</xsl:when>
				<xsl:otherwise>
				</xsl:otherwise> 
			</xsl:choose>
		</div>
	</li>
</xsl:template>


<!-- ###############################
     WIDGET ITEM - called from common.xsl
     ###############################  -->
<xsl:template name="widgetItem">
	<xsl:param name="i"/>
	<dl>
		<dt class="title">
			<a href="#">
				<xsl:call-template name="createLink">
					<xsl:with-param name="node" select="$i"/>
					<xsl:with-param name="name" select="$i/@title"/>
				</xsl:call-template>
			</a>
		</dt>
		<dt class="description">
			<xsl:value-of select="$i/@description"/>
		</dt>
	</dl>
	<a class="add" href="#" title="Add this widget to my homepage">+</a>
</xsl:template> 
<xsl:template name="widgetContentItem">
	<xsl:param name="i"/>
	<dl>
		<dt class="title">
			<a href="#">
				<xsl:call-template name="createLink">
					<xsl:with-param name="node" select="$i"/>
					<xsl:with-param name="name" select="$i/@title"/>
				</xsl:call-template>
			</a>
		</dt>
		<dt class="description">Widget <xsl:value-of select="$i/@widget_title"/>
		</dt>
	</dl>
	<a class="add" href="#" title="Add this widget to my homepage">+</a>
</xsl:template>


<!-- ###############################
     LIST WIDGETS
     ############################### -->
<xsl:template match="widget" mode="listWidgets">
	<li id="widget-{@id}" class="widget">
		<p class="widget-title">
			<xsl:value-of select="@title"/>
		</p>
		<xsl:if test="parent::my_widgets">
			<div class="widget-actions">
				<xsl:if test="@can_edit = 1">
					<a href="/widgets/edit.php?id={@id}" class="widget-actions-edit" title="edit this widget"><span class="ui-icon ui-icon-pencil">Edit</span></a>
				</xsl:if>
				<xsl:if test="@can_edit">
					<a href="#{@id}" class="widget-actions-delete" title="delete this widget"><span class="ui-icon ui-icon-close">Delete</span></a>
				</xsl:if>
			</div>
		</xsl:if>	
		<p class="widget-description">
			<xsl:choose>
				<xsl:when test="@description !=''">
					<xsl:value-of select="@description"/>
				</xsl:when>
				<xsl:otherwise>Sorry, there is no description available for this widget</xsl:otherwise>
			</xsl:choose>
		</p>
		<div class="widget-action clearfix">
			<button class="btn widget-action-preview" href="#">
				<span>Preview</span>
			</button>
			<xsl:choose>
				<xsl:when test="$user_id != '0' and @status_name ='Approved'">
					<button class="btn widget-action-add" href="#">
						<span>Add to homepage</span>
					</button>	
				</xsl:when>
				<xsl:otherwise>
					<xsl:if test="(@status_name !='Approved' and @status_name !='')">
						<button class="btn widget-action-comments" href="#">
							<span>Status: <xsl:value-of select="@status_name"/> - learn more</span>
						</button>
						<div class="widget-comments" style="display:none;" title="Comments for {@title}">
							<h5>Status: <xsl:value-of select="@status_name"/></h5>
							<h6>Comments</h6>
							<xsl:choose>
								<xsl:when test="@comment !=''">
									<p><xsl:value-of select="@comment"/></p>
								</xsl:when>
								<xsl:otherwise>
									<p>Sorry, comment unavailable</p>
								</xsl:otherwise>
							</xsl:choose>
						</div>
					</xsl:if>
				</xsl:otherwise>
			</xsl:choose>
		</div>
	</li>
</xsl:template>


<!-- ###############################
     BROWSE WIDGET 
     ############################### -->	
<xsl:template name="browseWidget">
	<div id="browse-widget" class="background">
		<ul>
			<li>
				<a href="mywidgets.php" title="key('label','my_widgets')/@tr"><xsl:value-of select="key('label','my_widgets')/@tr"/></a>
			</li>
			<xsl:apply-templates select="$node-widgets/categories" mode="browseWidgetCategories"/>
		</ul>
	</div>
</xsl:template>
<xsl:template match="category" mode="browseWidgetCategories">
	<xsl:if test="number(@num_widgets) &gt; 0">
		<li>
			<xsl:variable name="id" select="@id"/>
			<xsl:variable name="name" select="@name"/>
			<xsl:variable name="url" select="@url"/>
			<a href="{$url}" title="{$name}">
				<xsl:value-of select="@name"/>
			</a>
		</li>
	</xsl:if>
</xsl:template>


<!-- ###############################
     SEARCH WIDGET 
     ############################### -->
<xsl:template name="searchWidget">
	<div id="search-widget" class="">
		<h3><xsl:value-of select="key('label','widget_library')/@tr"/></h3>
		<p><xsl:value-of select="key('label','widget_library_welcome')/@tr"/></p>
		<div id="search-for-widget">
			<form action="search.php">
				<input type="hidden" name="content" id="content" value="0" />
				<fieldset>
					<h5><label for="qw"><xsl:value-of select="key('label','search')/@tr"/></label></h5>
					<input type="text" name="qw" id="qw" value=""/>
					<label for="search-option"><xsl:value-of select="key('label','within')/@tr"/></label>	
					<select id="search-option" class="search-option">
						<option id="widget" value="0" selected="selected"><xsl:value-of select="key('label','widget')/@tr"/></option>
						<option id="widget-content" value="1"><xsl:value-of select="key('label','widget_content')/@tr"/></option>
					</select>
					<button type="submit" id="widget_search_submit" value="{key('label','search')/@tr}" class="btn"><span><xsl:value-of select="key('label','search')/@tr"/></span></button>
				</fieldset>
			</form>
		</div>
	</div>
</xsl:template>


<!-- ###############################
     CREATE WIDGET 
     ############################### -->
<xsl:template name="createWidget">
	<div id="create-widget" class="">
		<form action="create.php">
			<h3><xsl:value-of select="key('label','widget_create')/@tr"/></h3>
			<p><xsl:value-of select="key('label','widget_create_welcome')/@tr"/></p>
			<button type="submit" id="widget_create_submit" value="{key('label','widget_create')/@tr}" class="btn"><span><xsl:value-of select="key('label','widget_create')/@tr"/></span></button>
		</form>
	</div>
</xsl:template>


<!-- ###############################
     RESET WIDGETS 
     ############################### -->
<xsl:template name="resetWidgets">
	<div id="reset-widget" class="">
		<form action="reset.php">
			<h3><xsl:value-of select="key('label','widget_reset')/@tr"/></h3>
			<p><xsl:value-of select="key('label','widget_reset_info')/@tr"/></p>
			<button type="submit" id="widget_reset_submit" value="{key('label','widget_reset')/@tr}" class="btn"><span><xsl:value-of select="key('label','widget_reset')/@tr"/></span></button>
		</form>
	</div>
</xsl:template>


<!-- ###############################
     WIDGET EDIT 
     ############################### -->
<xsl:template name="widgetEdit">
	<xsl:call-template name="searchWidget" />
	<xsl:call-template name="createWidget" />

	<div id="list-widget" class="add clearfix">
		<div class="widget-edit background clearfix">
			<xsl:choose>
				<xsl:when test="$node-widgets/widget_edit/@ valid ='0'">
					<h4>Sorry, we couldn't find that widget</h4>
					<p>Please try browsing within our categories of widgets or alternatively try seaching for another widget</p>
				</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="$node-widgets/widget_edit/@widget_type ='0'">
							<xsl:call-template name="widgetEditManual" />
						</xsl:when>
						<xsl:when test="$node-widgets/widget_edit/@widget_type = '1'">
							<xsl:call-template name="widgetEditRSS" />
						</xsl:when>
						<xsl:when test="$node-widgets/widget_edit/@widget_type ='3'">
							<xsl:call-template name="widgetEditAdvanceManual" />
						</xsl:when>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
		</div>
	</div>
</xsl:template>


<!-- ###############################
     WIDGET EDIT MANUAL 
     ############################### -->
<xsl:template  name="widgetEditManual">
	<div id="edit-manual-widget">
		<h4>Edit widget - <em><xsl:value-of select="$node-widgets/widget_edit/@title" /></em></h4>
		<div class="form-instructions">Type: Manual widget</div>
		<form method="post" action="{/root/site/@upload_host}/widgets/actions.php" enctype="multipart/form-data" id="edit-manual">
			<input type="hidden" name="from" value="edit_manual_widget"/>
			<input type="hidden" name="id" value="{$node-widgets/widget_edit/@id_widget}"/>
			<fieldset>
				<ul class="form-inputs">
					<li class="clearfix">
						<label for="widget_manual_title">Title</label>
						<input type="text" name="widget_manual_title" id="widget_manual_title" value="{$node-widgets/widget_edit/@title}" class="widget-input-wide" />
						<small>Title should be short and sweet.</small>
					</li>
					<li class="clearfix">
						<label for="widget_manual_desc">Description</label>
						<input type="text" name="widget_manual_desc" id="widget_manual_desc" value="{$node-widgets/widget_edit/@description}" class="widget-input-wide" />
						<small>Widget description.</small>
					</li>
					<li class="clearfix">
						<xsl:if test="$node-widgets/widget_edit/@image_src !=''">
							<small><img src="{$node-widgets/widget_edit/@image_src}" alt="widget image" width="{$node-widgets/widget_edit/@image_width}" /></small>
						</xsl:if>
						<label for="widget_manual_image">Current Image</label>
						<input id="img" type="file" name="img"/>
						<small>Upload a new image related to this widget.</small>
					</li>
					<li class="clearfix">
						<label for="widget_manual_content">Content</label>
						<textarea name="widget_manual_content" id="widget_manual_content" rows="10" cols="50" class="widget-input-content-wide"><xsl:value-of select="/root/widgets/widget_edit/@content"/></textarea>
						<small>Enter the text contents for the widget. Only text format is allowed for manual widget.</small>
					</li>
					<li class="clearfix">
						<label for="widget_manual_link">Link</label>
						<input type="text" name="widget_manual_link" id="widget_manual_link" value="{$node-widgets/widget_edit/@link_url}" class="widget-input-wide" />
						<small>
							<xsl:choose>
								<xsl:when test="$node-widgets/widget_edit/@link_url !=''">
									Include a link where the user can read more information on the widget.
								</xsl:when>
								<xsl:otherwise>
									Update the link where the user can read more information on the widget.
								</xsl:otherwise>
							</xsl:choose>
						</small>
					</li>
					<li class="buttons clearfix">
						<button type="submit" id="widget_manual_submit" class="btn"><span>Update this widget</span></button>
					</li>
				</ul>
			</fieldset>
		</form>
	</div>
</xsl:template>


<!-- ###############################
     WIDGET EDIT ADVANCE MANUAL 
     ############################### -->
<xsl:template  name="widgetEditAdvanceManual">
	<div id="edit-advance-manual-widget">
		<h4>Edit widget - <em><xsl:value-of select="$node-widgets/widget_edit/@title" /></em></h4>
		<div class="form-instructions">Type: Advanced Manual widget</div>
		<form method="post" action="{/root/site/@upload_host}/widgets/actions.php" enctype="multipart/form-data" id="edit-advance-manual">
			<input type="hidden" name="from" value="edit_advance_manual_widget"/>
			<input type="hidden" name="id" value="{$node-widgets/widget_edit/@id_widget}"/>
			<input type="hidden" id="id_sub" name="id_sub" value=""/>
			<input type="hidden" name="action" id="action" value="" />
			<fieldset>
				<ul class="form-inputs">
					<li class="clearfix">
						<label for="widget_advance_manual_title">Title</label>
						<input type="text" name="widget_advance_manual_title" id="widget_advance_manual_title" value="{$node-widgets/widget_edit/@title}" class="widget-input-wide" />
						<small>Title should be short and sweet.</small>
					</li>
					<li class="clearfix">
						<label for="widget_advance_manual_desc">Description</label>
						<input type="text" name="widget_advance_manual_desc" id="widget_advance_manual_desc" value="{$node-widgets/widget_edit/@description}" class="widget-input-wide" />
						<small>Widget description.</small>
					</li>
					<li class="clearfix">
						<div class="form-instructions">Below is your recent entry. You can delete each entry or <a href="#" id="add-new-widget-entry">add a new entry to your widget</a>.</div>
						<ul id ="add-new-widget-entry-fields" class="ui-helper-hidden">
							<li class="clearfix">
								<xsl:if test="$node-widgets/widget_edit/@image_src !=''">
									<small><img src="{$node-widgets/widget_edit/@image_src}" alt="widget image" width="{$node-widgets/widget_edit/@image_width}" /></small>
								</xsl:if>
								<label for="widget_advance_manual_image">Current Image</label>
								<input id="img" type="file" name="img"/>
								<small>Upload a new image related to this widget.</small>
							</li>
							<li class="clearfix">
								<label for="widget_advance_manual_content">Content</label>
								<textarea name="widget_advance_manual_content" id="widget_advance_manual_content" rows="10" cols="50" class="widget-input-content-wide"><xsl:value-of select="/root/widgets/widget_edit/@content"/></textarea>
								<small>Enter the text contents for the widget. Only text format is allowed for manual widget.</small>
							</li>
							<li class="clearfix">
								<label for="widget_advance_manual_link">Link</label>
								<input type="text" name="widget_advance_manual_link" id="widget_advance_manual_link" value="{$node-widgets/widget_edit/@link_url}" class="widget-input-wide" />
								<small>
									<xsl:choose>
										<xsl:when test="$node-widgets/widget_edit/@link_url !=''">
											Include a link where the user can read more information on the widget.
										</xsl:when>
										<xsl:otherwise>
											Update the link where the user can read more information on the widget.
										</xsl:otherwise>
									</xsl:choose>
								</small>
							</li>
						</ul>
					</li>
					<div id="list-sub-widget">
						<ul id="sub-widget-items">
							<xsl:apply-templates select="$node-widgets/widget_edit/childs" mode="advanceSubWidget"/>
						</ul>
						<script type="text/javascript">
							function setSubWidgetIdValue(idVal)
							{
								$('#id_sub').val(idVal);
								$('#action').val("delete");
								return true;
							}
						</script>
					</div>
					<li class="buttons clearfix">
						<button type="submit" id="widget_advance_manual_submit" class="btn"><span>Update this widget</span></button>
					</li>
				</ul>
			</fieldset>
		</form>
	</div>
</xsl:template>


<!-- ###############################
     ADVANCE SUBWIDGET 
     ############################### -->
<xsl:template match="child" mode="advanceSubWidget">
	
		<li class="clearfix">
			<div class="sub-widget-item">
				<button type="submit" id="widget_advance_manual_delete_{@id_widget}" class="btn delete" onclick="return setSubWidgetIdValue({@id_widget});"><span>Delete</span></button>
				<xsl:if test="@image_src !=''">
					<!--<small><img src="{@image_src}" alt="widget image" width="{@image_width}" /></small>-->
					<img src="{@image_src}" alt="widget image" width="53" />
				</xsl:if>
				<p><xsl:value-of select="@content" disable-output-escaping="yes" /></p>

				<p><xsl:value-of select="@link_url" /></p>
			</div>
		</li>
	
</xsl:template>


<!-- ###############################
     WIDGET EDIT RSS 
     ############################### -->
<xsl:template name="widgetEditRSS">
	<div id="edit-rss-widget">
		<h4>Edit widget - <em><xsl:value-of select="$node-widgets/widget_edit/@title" /></em></h4>
		<p>You can make changes to this widget</p>
		<div class="form-instructions">Type: RSS based widget</div>
		<form method="post" action="actions.php" id="edit-rss">
			<input type="hidden" name="from" value="edit_rss_widget"/>
			<input type="hidden" name="id" value="{$node-widgets/widget_edit/@id_widget}"/>
			<fieldset>
				<ul class="form-inputs">
					<li class="clearfix">
						<label for="widget_rss_title">Title</label>
						<input type="text" name="widget_rss_title" id="widget_rss_title" value="{$node-widgets/widget_edit/@title}" class="widget-input-wide"/>
						<small>Edit this widget's title</small>
					</li>
					<li class="clearfix">
						<label for="widget_rss_desc">Description</label>
						<input type="text" name="widget_rss_desc" id="widget_rss_desc" value="{$node-widgets/widget_edit/@description}" class="widget-input-wide"/>
						<small>Edit this widget's description.</small>
					</li>
					<li class="clearfix">
						<label>Feed URL</label>
						<input type="text" name="widget_rss_url" id="widget_rss_url" value="{$node-widgets/widget_edit/@url}"  class="widget-input-wide"/>
						<small>Edit the RSS feed URL for this widget.</small>
					</li>
					<li class="buttons clearfix">
						<button type="submit" id="widget_rss_submit" class="btn"><span>Update this widget</span></button>
					</li>
				</ul>
			</fieldset>
		</form>
	</div>
</xsl:template>

</xsl:stylesheet>

