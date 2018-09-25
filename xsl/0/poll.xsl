<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html" encoding="UTF-8" indent="no" />

<xsl:include href="common.xsl" />

<xsl:variable name="po" select="/root/poll"/>

<xsl:variable name="current_page_title">
<xsl:value-of select="/root/topic/@name"/> - <xsl:value-of select="key('label','poll')/@tr"/>
<xsl:if test="$po/@id &gt; 0"><xsl:value-of select="concat(': ',$po/@title)"/></xsl:if>
</xsl:variable>


<!-- ###############################
     CONTENT
     ############################### -->
<xsl:template name="content">
<xsl:choose>
<xsl:when test="/root/poll and /root/poll/@active &gt; 0">
<xsl:call-template name="pollBreadcrumb"/>
<xsl:call-template name="feedback"/>
<div class="poll-content" id="poll-{$subtype}" >
<h1><xsl:value-of select="key('label','poll')/@tr"/>: 
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="$po"/>
<xsl:with-param name="name" select="$po/@title"/>
</xsl:call-template>
</h1>
<div class="description"><xsl:value-of select="$po/description" disable-output-escaping="yes"/></div>
<xsl:call-template name="pollContent"/>
</div>
</xsl:when>
<xsl:otherwise>
<xsl:call-template name="pollBreadcrumb"/>
<xsl:call-template name="feedback"/>
<h1><xsl:value-of select="key('label','polls')/@tr"/></h1>
<xsl:call-template name="items">
<xsl:with-param name="root" select="/root/polls/items"/>
<xsl:with-param name="node" select="/root/polls"/>
</xsl:call-template>
</xsl:otherwise>
</xsl:choose>
</xsl:template>


<!-- ###############################
     POLL BREADCRUMB
     ############################### -->
<xsl:template name="pollBreadcrumb">
<div class="breadcrumb">
<xsl:choose>
<xsl:when test="/root/poll">
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="$po"/>
<xsl:with-param name="name" select="$po/@title"/>
<xsl:with-param name="condition" select="$po/items"/>
</xsl:call-template>
<xsl:if test="$po/items">
<xsl:value-of select="$breadcrumb_separator"/>
<xsl:value-of select="$po/items/@label"/>
</xsl:if>
</xsl:when>
<xsl:otherwise><xsl:value-of select="key('label','polls')/@tr"/></xsl:otherwise>
</xsl:choose>
</div>
</xsl:template>


<!-- ###############################
     POLL CONTENT
     ############################### -->
<xsl:template name="pollContent">
<xsl:if test="$po/@active &gt; 0">
	<xsl:if test="$po/@active='2'">
		<p class="poll-over"><xsl:value-of select="key('label','poll_over')/@tr"/></p>
	</xsl:if>
	<xsl:choose>
	<xsl:when test="$subtype='info'">
		<xsl:choose>
		<xsl:when test="$po/thanks">
			<xsl:call-template name="pollThanks"/>
		</xsl:when>
		<xsl:otherwise>
			<xsl:call-template name="pollInfo"/>
		</xsl:otherwise>
		</xsl:choose>
		<xsl:if test="$po/results">
			<p id="results-link">
			<xsl:call-template name="createLink">
			<xsl:with-param name="node" select="$po/results"/>
			<xsl:with-param name="name" select="$po/results/@label"/>
			</xsl:call-template>
			</p>
		</xsl:if>
	</xsl:when>
	<xsl:when test="$subtype='question'">
		<xsl:call-template name="pollQuestion"/>
	</xsl:when>
	<xsl:when test="$subtype='result'">
		<xsl:call-template name="pollPersonResults"/>
	</xsl:when>
	<xsl:when test="$subtype='register'">
		<xsl:call-template name="pollPersonRegister"/>
	</xsl:when>
	<xsl:when test="$subtype='questions_group'">
		<xsl:call-template name="pollQuestionsGroup"/>
	</xsl:when>
	<xsl:when test="$subtype='results'">
		<xsl:call-template name="pollResults"/>
	</xsl:when>
	</xsl:choose>
</xsl:if>

</xsl:template>


<!-- ###############################
     POLL INFO
     ############################### -->
<xsl:template name="pollInfo">
<p class="intro"><xsl:value-of select="$po/intro" disable-output-escaping="yes"/></p>
<xsl:choose>
<xsl:when test="$po/login">
<xsl:call-template name="loginFirst">
<xsl:with-param name="node" select="$po/login"/>
</xsl:call-template>
</xsl:when>
<xsl:otherwise>

<xsl:if test="$po/@id_type='4' and $po/@active='1'">
<form action="{$po/@submit}" method="post" id="poll-form-{$po/@id}" class="poll-form" accept-charset="{/root/site/@encoding}">
<input type="hidden" name="from" value="poll"/>
<input type="hidden" name="action" value="group"/>
<input type="hidden" name="seq" value="0"/>
<input type="hidden" name="id_poll" value="{$po/@id}"/>
<input type="hidden" name="id_topic" value="{/root/topic/@id}"/>
<ul id="poll-prequestions" class="form-inputs">
<xsl:call-template name="pollPersonParams"/>
</ul>
<xsl:call-template name="pollSteps"/>
<ul id="poll-buttons" class="form-inputs">
<li class="buttons">
<input type="submit" value="{key('label','next')/@tr}" class="next-button"/>
</li>
</ul>
</form>
</xsl:if>

<xsl:if test="$po/@id_type='3'">
<xsl:call-template name="items">
<xsl:with-param name="root" select="$po/questions"/>
<xsl:with-param name="node" select="$po"/>
</xsl:call-template>
</xsl:if>

<xsl:if test="$po/questions and $po/@active='1'">
<form action="{$po/@submit}" method="post" id="poll-form-{$po/@id}" class="poll-form" accept-charset="{/root/site/@encoding}">
<input type="hidden" name="from" value="poll"/>
<input type="hidden" name="action" value="vote"/>
<input type="hidden" name="id_poll" value="{$po/@id}"/>
<input type="hidden" name="id_topic" value="{/root/topic/@id}"/>
<ul id="poll-questions" class="form-inputs">
<xsl:for-each select="$po/questions/question">
<li>
<xsl:choose>
<xsl:when test="$po/@id_type='0'"><input type="radio" id="id_question" name="id_question" value="{@id}" onclick="styleToggle(this)"/></xsl:when>
<xsl:when test="$po/@id_type='1'"><input type="checkbox" id="id_question" name="id_question[]" value="{@id}" onclick="styleToggle(this)"/></xsl:when>
<xsl:when test="$po/@id_type='2'"><select name="vote_{@id}">
<option value="0"><xsl:value-of select="key('label','vote')/@tr"/></option>
<xsl:for-each select="$po/votes/vote"><option value="{@value}"><xsl:value-of select="@value"/></option></xsl:for-each>
</select></xsl:when>
</xsl:choose>
<label for="id_question"><xsl:value-of select="@question"/></label>
<xsl:if test="description!=''"><div class="description"><xsl:value-of select="description" disable-output-escaping="yes"/></div></xsl:if>
</li>
</xsl:for-each>
</ul>
<ul class="form-inputs">
<xsl:if test="$po/question">
<li id="question-new">
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="$po/question"/>
<xsl:with-param name="name" select="$po/question/@label"/>
</xsl:call-template>
</li>
</xsl:if>
<xsl:if test="$po/@id_type='0' or $po/@id_type='1' or $po/@id_type='2'">
<xsl:if test="/root/site/@captcha">
<li class="clearfix">
<xsl:call-template name="captchaWrapper"/>
</li>
</xsl:if>
<li class="buttons"><input type="submit" value="{key('label','submit')/@tr}"/>
<input type="reset" value="{key('label','reset')/@tr}"/>
</li>
</xsl:if>
</ul>
</form>
</xsl:if>
</xsl:otherwise>
</xsl:choose>

</xsl:template>


<!-- ###############################
     POLL QUESTION
     ############################### -->
<xsl:template name="pollQuestion">
<xsl:choose>
<xsl:when test="$po/login">
<xsl:call-template name="loginFirst">
<xsl:with-param name="node" select="$po/login"/>
</xsl:call-template>
</xsl:when>
<xsl:when test="$po/question and $po/@active &gt; 0">
<h2><xsl:value-of select="$po/question/@question"/></h2>
<xsl:if test="$po/question/author"><div class="author"><xsl:value-of select="concat($po/question/author/@label,': ',$po/question/author/@name)"/></div></xsl:if>
<xsl:if test="$po/question/description!=''"><div class="description"><xsl:value-of select="$po/question/description" disable-output-escaping="yes"/></div></xsl:if>
<xsl:call-template name="articleContentComments">
<xsl:with-param name="a" select="$po"/>
</xsl:call-template>
<xsl:if test="$po/question/description_long!=''"><div class="description"><xsl:value-of select="$po/question/description_long" disable-output-escaping="yes"/></div></xsl:if>

<xsl:if test="$po/@active='1'">
<form action="{$po/@submit}" method="post" id="poll-form-{$po/@id}" class="poll-form" accept-charset="{/root/site/@encoding}">
<input type="hidden" name="from" value="poll"/>
<input type="hidden" name="action" value="vote"/>
<input type="hidden" name="id_poll" value="{$po/@id}"/>
<input type="hidden" name="id_topic" value="{/root/topic/@id}"/>
<input type="hidden" name="id_question" value="{$po/question/@id}"/>
<ul id="poll-questions" class="form-inputs">
<select name="vote">
<option value="0"><xsl:value-of select="key('label','vote')/@tr"/></option>
<xsl:for-each select="$po/votes/vote"><option value="{@value}"><xsl:value-of select="@value"/></option></xsl:for-each>
</select>
<li class="buttons"><input type="submit" value="{key('label','submit')/@tr}"/></li>
</ul>
</form>
</xsl:if>
</xsl:when>
<xsl:otherwise>
<xsl:if test="$po/@active='1'">
<form action="{$po/@submit}" method="post" id="poll-form-{$po/@id}" class="poll-form" accept-charset="{/root/site/@encoding}">
<input type="hidden" name="from" value="poll"/>
<input type="hidden" name="action" value="propose"/>
<input type="hidden" name="id_poll" value="{$po/@id}"/>
<input type="hidden" name="id_topic" value="{/root/topic/@id}"/>
<ul class="form-inputs">
<xsl:call-template name="formInput">
<xsl:with-param name="varname">title</xsl:with-param>
<xsl:with-param name="required" select="true()"/>
</xsl:call-template>
<xsl:call-template name="formInput">
<xsl:with-param name="varname">description</xsl:with-param>
<xsl:with-param name="type">textarea</xsl:with-param>
</xsl:call-template>
<xsl:call-template name="formInput">
<xsl:with-param name="varname">description_long</xsl:with-param>
<xsl:with-param name="label">text</xsl:with-param>
<xsl:with-param name="type">textarea</xsl:with-param>
<xsl:with-param name="size">large</xsl:with-param>
</xsl:call-template>
<xsl:if test="/root/site/@captcha">
<li class="clearfix">
<xsl:call-template name="captchaWrapper"/>
</li>
</xsl:if>
<li class="buttons"><input type="submit" value="{key('label','submit')/@tr}" name="action_sign"/></li>
</ul>
</form>
</xsl:if>
</xsl:otherwise>
</xsl:choose>
</xsl:template>


<!-- ###############################
     POLL QUESTIONS GROUP           
     ############################### -->
<xsl:template name="pollQuestionsGroup">
<xsl:if test="$po/login">               
<xsl:call-template name="loginFirst">   
<xsl:with-param name="node" select="$po/login"/>
</xsl:call-template>                            
</xsl:if>                                       

<xsl:if test="$po/@id_type='4' and $po/@active='1'">
<form action="{$po/@submit}" method="post" id="poll-form-{$po/@id}" class="poll-form" accept-charset="{/root/site/@encoding}">
<input type="hidden" name="from" value="poll"/>                                                                               
<input type="hidden" name="action" value="group"/>                                                                            
<input type="hidden" name="seq" value="{$po/questions_group/@seq}"/>                                                          
<input type="hidden" name="id_questions_group" value="{$po/questions_group/@id}"/>                                            
<input type="hidden" name="id_poll" value="{$po/@id}"/>                                                                       
<input type="hidden" name="id_topic" value="{/root/topic/@id}"/>                                                              
<h2 id="qgt{$po/questions_group/@id}" class="questions-group-title"><xsl:value-of select="$po/questions_group/@name"/></h2>                                                                   
<table border="1" cellpadding="5" cellspacing="0" class="group-question-table" id="gqtable{$po/questions_group/@id}">         
<caption><xsl:value-of select="$po/questions_group/@label"/></caption>                                                        
<thead>                                                                                                                       
<tr>                                                                                                                          
<th><xsl:value-of select="key('label','poll_questions')/@tr"/></th>                                                           
<xsl:for-each select="$po/votenames/votename">                                                                                
<th class="group-question-choice"><xsl:value-of select="@name"/></th>                                                         
</xsl:for-each>                                                                                                               
</tr>                                                                                                                         
</thead>                                                                                                                      
<tbody>                                                                                                                       
<xsl:for-each select="$po/questions_group/questions/question">                                                                
<xsl:variable name="id_question" select="@id"/>                                                                               
<tr id="id_question{$id_question}_row">                                                                                       
<xsl:attribute name="class">row<xsl:value-of select="(position() mod 2)"/></xsl:attribute>                                    
<td class="group-question">                                                                                                   
<div id="id_question{$id_question}_title" class="question-title"><xsl:value-of select="@question"/></div>                     
<xsl:if test="description!=''">                                                                                               
<div class="question-desc"><em><xsl:value-of select="description"/></em></div>                                                
</xsl:if>                                                                                                                     
</td>                                                                                                                         
<xsl:for-each select="votes/vote">                                                                                            
<td>                                                                                                                          
<xsl:if test="@selected"><xsl:attribute name="class">selected</xsl:attribute></xsl:if>                                        
<input type="radio" id="vote" name="id_question{$id_question}" value="{@id}">                                                 
<xsl:if test="@selected"><xsl:attribute name="checked">checked</xsl:attribute></xsl:if>                                       
</input>                                                                                                                      
<label class="vote-label" for="vote"><xsl:value-of select="@name"/></label>                                                   
</td>                                                                                                                         
</xsl:for-each>                                                                                                               
</tr>                                                                                                                         
</xsl:for-each>                                                                                                               
</tbody>                                                                                                                      
</table>                                                                                                                      
<xsl:call-template name="pollSteps"/>
<ul id="poll-buttons" class="form-inputs">
<li class="buttons">                      
<xsl:if test="$po/questions_group/@seq &gt; 0">
<input type="submit" name="action_previous" value="{key('label','previous')/@tr}" class="previous-button"/>
</xsl:if>                                      
<xsl:if test="$po/questions_group/@seq &lt; $po/@num_groups">                                              
<input type="submit" name="action_next" value="{key('label','next')/@tr}" class="next-button"/>            
</xsl:if>                                                                                                  
<xsl:if test="$po/questions_group/@seq = $po/@num_groups">                                                 
<input type="submit" name="action_next" value="{key('label','next')/@tr}" class="next-button"/>            
</xsl:if>                                                                                                  
</li>                                                                                                      
</ul>                                                                                                      
</form>                                                                                                    
</xsl:if>                                                                                                  

</xsl:template>


<!-- ###############################
     POLL PERSON REGISTER
     ############################### -->
<xsl:template name="pollPersonRegister">
<form action="{$po/@submit}" method="post" id="poll-form-{$po/@id}" class="poll-form" accept-charset="{/root/site/@encoding}">
<input type="hidden" name="from" value="poll"/>
<input type="hidden" name="action" value="register"/>
<input type="hidden" name="id_poll" value="{$po/@id}"/>
<input type="hidden" name="id_topic" value="{/root/topic/@id}"/>
<ul class="form-inputs">
<fieldset>
<legend><xsl:value-of select="key('label','register')/@tr"/></legend>
<xsl:call-template name="formInput">
<xsl:with-param name="varname">name1</xsl:with-param>
<xsl:with-param name="label">name</xsl:with-param>
<xsl:with-param name="required" select="true()"/>
<xsl:with-param name="value" select="/root/user/@name1"/>
</xsl:call-template>
<xsl:call-template name="formInput">
<xsl:with-param name="varname">name2</xsl:with-param>
<xsl:with-param name="label">surname</xsl:with-param>
<xsl:with-param name="required" select="true()"/>
<xsl:with-param name="value" select="/root/user/@name2"/>
</xsl:call-template>
<xsl:call-template name="formInput">
<xsl:with-param name="varname">email</xsl:with-param>
<xsl:with-param name="label">email</xsl:with-param>
<xsl:with-param name="required" select="true()"/>
<xsl:with-param name="value" select="/root/user/@email"/>
</xsl:call-template>
</fieldset>
<xsl:call-template name="pollPersonRegisterParams"/>
</ul>
<xsl:call-template name="pollSteps"/>
<ul id="poll-buttons" class="form-inputs">
<xsl:if test="/root/site/@captcha">
<li class="clearfix">
<xsl:call-template name="captchaWrapper"/>
</li>
</xsl:if>
<li class="buttons"><input type="submit" value="{key('label','submit')/@tr}"/></li>
</ul>
</form>
</xsl:template>


<!-- ###############################
     POLL PERSON PARAMS
     ############################### -->
<xsl:template name="pollPersonParams">
</xsl:template>


<!-- ###############################
     POLL PERSON REGISTER PARAMS
     ############################### -->
<xsl:template name="pollPersonRegisterParams">
</xsl:template>


<!-- ###############################
     POLL PERSON RESULTS
     ############################### -->
<xsl:template name="pollPersonResults">
<xsl:call-template name="pollPersonResultsChart"/>
<xsl:call-template name="pollPersonResultsTable"/>
</xsl:template>


<!-- ###############################
     POLL PERSON RESULTS CHART
     ############################### -->
<xsl:template name="pollPersonResultsChart">
<script type="text/javascript">
swfobject.embedSWF(
"/tools/open-flash-chart.swf", "poll_results_chart",
"700", "500", "9.0.0", "/tools/expressInstall.swf",
{"data-file":"/poll/ofc_data.php?t=<xsl:value-of select="$po/results/@token"/>"} );
</script>
<div id="poll_results_chart"></div>
</xsl:template>


<!-- ###############################
     POLL PERSON RESULTS TABLE
     ############################### -->
<xsl:template name="pollPersonResultsTable">
<table border="0" cellpadding="3" cellspacing="1" id="poll_results_table">
<tr><th>Group</th><th>Total</th></tr>
<xsl:for-each select="$po/results/questions_groups/questions_group">
<tr>
<xsl:attribute name="class">row<xsl:value-of select="(position() mod 2)"/></xsl:attribute>
<td><xsl:value-of select="@name"/></td>
<td align="right"><xsl:value-of select="@total_perc"/>%</td>
</tr>
</xsl:for-each>
</table>

</xsl:template>


<!-- ###############################
     POLL RESULTS
     ############################### -->
<xsl:template name="pollResults">
<h2><xsl:value-of select="$po/results/@label"/></h2>
<xsl:if test="$po/results/@threshold"><p><xsl:value-of select="$po/results/@threshold"/></p></xsl:if>
<xsl:if test="$po/results/question">
<ol>
<xsl:for-each select="$po/results/question">
<li>
<h3>
<xsl:call-template name="createLink">
<xsl:with-param name="node" select="."/>
<xsl:with-param name="name" select="@title"/>
<xsl:with-param name="condition" select="$po/@id_type='3'"/>
</xsl:call-template>
</h3>
<div class="votes">
<xsl:choose>
<xsl:when test="$po/@id_type &gt; 1">
<xsl:value-of select="concat($po/results/@label_avg,': ',@avg, ' (',@votes,' ',$po/results/@label_votes,')')"/>
</xsl:when>
<xsl:otherwise>
<xsl:value-of select="concat($po/results/@label_votes,': ',@votes)"/>
</xsl:otherwise>
</xsl:choose>
</div>
</li>
</xsl:for-each>
</ol>
</xsl:if>
</xsl:template>


<!-- ###############################
     POLL STEPS
     ############################### -->
<xsl:template name="pollSteps">
<div class="poll-steps">
<xsl:value-of select="$po/steps/@label"/>
</div>
</xsl:template>


<!-- ###############################
     POLL THANKS
     ############################### -->
<xsl:template name="pollThanks">
<div id="poll-thanks"><xsl:value-of select="$po/thanks" disable-output-escaping="yes"/></div>
<xsl:if test="$po/comment">
<div><xsl:value-of select="$po/comment" disable-output-escaping="yes"/></div>
</xsl:if>
</xsl:template>

</xsl:stylesheet>
