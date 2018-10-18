$(function() {

  // map expand
  $(".subtopics-header").click(function () {
    $link = $(this);
    $content = $link.parent().next();
    if($content.css('display')=='none') {
      $(".subtopics").slideUp("slow");
      $(".items").slideUp("slow");
      $(".subtopics-header").removeClass('fa-minus-square').addClass('fa-plus-square');
    }
    $content.slideToggle("slow");
    $link.toggleClass('fa-plus-square fa-minus-square');
  });
  $(".latest-header").click(function () {
    $link = $(this);
    $container = $link.parent();
    $content = $container.next();
    if($content.css('display')=='none') {
      $(".subtopics").slideUp("slow");
      $(".items").slideUp("slow");
      $(".latest-header").removeClass('fa-minus-square').addClass('fa-plus-square');
    }
    $content.slideToggle("slow");
    $link.toggleClass('fa-plus-square fa-minus-square');
  });
  
});

function htmlLoad(divId,htmlUrl,cache,append=false) {
  $.ajax({
    url : htmlUrl,
    type : "GET",
    cache : cache,
    dataType: "html",
    success : function(data) {
      if(data) {
        if(append) {
          $('#'+divId).append(data);
        } else {
          $('#'+divId).html(data);
        }
      } else {
        console.log('No data from ' + htmlUrl)
      }
    },
    error: function(XMLHttpRequest, textStatus, errorThrown) { 
      console.log("Response: " + XMLHttpRequest.responseText + ' - ' + errorThrown);
    }
  });
}

// FACEBOOK  WIDGET
(function(d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0];
  if (d.getElementById(id)) return;
  js = d.createElement(s); js.id = id;
  js.src = 'https://connect.facebook.net/it_IT/sdk.js#xfbml=1&version=v3.1&appId=1752631701494360&autoLogAppEvents=1';
  fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));



// OLD STUFF

var phpeace = {
  pub_web : 'www.peacelink.it'
};

hs.graphicsDir = 'https://www.peacelink.it/js/highslide/graphics/';


function getHttpContent(url,elementid) {
	makeHttpRequest(url,'returnContent',elementid);
}

function makeHttpRequest(url, callback_function, output, return_xml) {
	var http_request = false;
	if (window.XMLHttpRequest) {
		http_request = new XMLHttpRequest();
		if (http_request.overrideMimeType) {
			http_request.overrideMimeType('text/xml');
		}
	} else if (window.ActiveXObject) {
		try {
			http_request = new ActiveXObject("Msxml2.XMLHTTP");
		} catch (e) {
			try {
				http_request = new ActiveXObject("Microsoft.XMLHTTP");
			} catch (e) {}
		}
	}

	if (!http_request) {
		return false;
	}
	http_request.onreadystatechange = function() {
		if (http_request.readyState == 4) {
			if (http_request.status == 200) {
				if (return_xml) {
					eval(callback_function + '(\'' +output + '\',http_request.responseXML)');
				} else {
					eval(callback_function + '(\'' + output + '\',http_request.responseText)');
				}
			}
		}
	}
	http_request.open('GET', url, true);
	http_request.send(null);
}

function returnContent(where,what) {
	document.getElementById(where).innerHTML = what;
}

/*
 ======================================================================
 RSS JavaScript Ticker object
 Author: George at JavaScriptKit.com/ DynamicDrive.com
 Created: Feb 5th, 2006. Updated: Feb 5th, 2006
 Adapted for PhPeace by Francesco Iannuzzelli
 ======================================================================
*/

function createAjaxObj(){
var httprequest=false
if (window.XMLHttpRequest){ 
httprequest=new XMLHttpRequest()
if (httprequest.overrideMimeType)
httprequest.overrideMimeType('text/xml')
}
else if (window.ActiveXObject){ 
try {
httprequest=new ActiveXObject("Msxml2.XMLHTTP");
} 
catch (e){
try{
httprequest=new ActiveXObject("Microsoft.XMLHTTP");
}
catch (e){}
}
}
return httprequest
}

// -------------------------------------------------------------------
// Main RSS Ticker Object function
// rss_ticker(RSS_id, cachetime, divId, delay)
// -------------------------------------------------------------------

function rss_ticker(RSS_id, cachetime, divId, delay, showDescription){
this.RSS_id=RSS_id //Array key indicating which RSS feed to display
this.cachetime=cachetime //Time to cache feed, in minutes. 0=no cache.
this.tickerid=divId //ID of ticker div to display information
this.delay=delay //Delay between msg change, in miliseconds.
this.mouseoverBol=0 //Boolean to indicate whether mouse is currently over ticker (and pause it if it is)
this.showdesc=(showDescription=="1")? true : false
this.pointer=0
this.ajaxobj=createAjaxObj()
this.getAjaxcontent()
}

// -------------------------------------------------------------------
// getAjaxcontent()- Makes asynchronous GET request to "rssfetch.php" with the supplied parameters
// -------------------------------------------------------------------

rss_ticker.prototype.getAjaxcontent=function(){
if (this.ajaxobj){
var instanceOfTicker=this
var parameters="url="+encodeURIComponent(this.RSS_id)+"&ttl="+this.cachetime
this.ajaxobj.onreadystatechange=function(){instanceOfTicker.initialize()}
this.ajaxobj.open('GET', "/js/rss_fetch.php?"+parameters, true)
this.ajaxobj.send(null)
}
}

// -------------------------------------------------------------------
// initialize()- Initialize ticker method.
// -Gets contents of RSS content and parse it using JavaScript DOM methods 
// -------------------------------------------------------------------

rss_ticker.prototype.initialize=function(){ 
	if (this.ajaxobj.readyState == 4){ //if request of file completed
		if (this.ajaxobj.status==200){ //if request was successful
			var xmldata=this.ajaxobj.responseXML;
			if(xmldata.getElementsByTagName("item").length==0){ //if no <item> elements found in returned content
				document.getElementById(this.tickerid).innerHTML="<!-- no news is good news -->";
				return
			}
			var instanceOfTicker=this;
			if(xmldata.firstChild.localName=='feature')
			{
				this.feeditems=xmldata.getElementsByTagName("item");
				for (var i=0; i<this.feeditems.length; i++){
					var itemTitle = this.feeditems[i].attributes.getNamedItem('event_type').textContent.toUpperCase() + ' - ' + this.feeditems[i].attributes.getNamedItem('title').textContent;
					this.feeditems[i].setAttribute("ctitle", itemTitle);
					this.feeditems[i].setAttribute("clink", this.feeditems[i].attributes.getNamedItem('url').textContent);
					var itemDesc = this.feeditems[i].attributes.getNamedItem('start_date').textContent;
					if(this.feeditems[i].attributes.getNamedItem('end_date').textContent != this.feeditems[i].attributes.getNamedItem('start_date').textContent){
						itemDesc += ' - ' + this.feeditems[i].attributes.getNamedItem('end_date').textContent;
					}
					itemDesc += ' - ' + this.feeditems[i].attributes.getNamedItem('place').textContent;
					this.feeditems[i].setAttribute("cdescription", itemDesc);
				}
			}
			else
			{
				this.feeditems=xmldata.getElementsByTagName("item");
				for (var i=0; i<this.feeditems.length; i++){
					this.feeditems[i].setAttribute("ctitle", this.feeditems[i].getElementsByTagName("title")[0].firstChild.nodeValue);
					this.feeditems[i].setAttribute("clink", this.feeditems[i].getElementsByTagName("link")[0].firstChild.nodeValue);
					var desc = this.feeditems[i].getElementsByTagName("description")[0].firstChild;
					this.feeditems[i].setAttribute("cdescription", (desc!=null)? desc.nodeValue:"");
				}
			}
		document.getElementById(this.tickerid).onmouseover=function(){instanceOfTicker.mouseoverBol=1;};
		document.getElementById(this.tickerid).onmouseout=function(){instanceOfTicker.mouseoverBol=0;};
		this.rotatemsg();
		}
	}
}

// -------------------------------------------------------------------
// rotatemsg()- Rotate through RSS messages and display them
// -------------------------------------------------------------------

rss_ticker.prototype.rotatemsg=function(){
var instanceOfTicker=this
if (this.mouseoverBol==1) 
setTimeout(function(){instanceOfTicker.rotatemsg()}, 100)
else{
var tickerDiv=document.getElementById(this.tickerid)
var tickercontent='<a href="'+this.feeditems[this.pointer].getAttribute("clink")+'">'+this.feeditems[this.pointer].getAttribute("ctitle")+'</a>'
if(this.showdesc)
tickercontent+="<div class=\"tkdesc\">"+this.feeditems[this.pointer].getAttribute("cdescription")+"</div>"
tickerDiv.innerHTML=tickercontent
this.pointer=(this.pointer<this.feeditems.length-1)? this.pointer+1 : 0
setTimeout(function(){instanceOfTicker.rotatemsg()}, this.delay) 
}
}

// -------------------------------------------------------------------
// Main RSS Lister Object function
// rss_lister(RSS_id, divId, items_limit)
// -------------------------------------------------------------------

function rss_lister(RSS_id, cachetime, divId, items_limit){
this.RSS_id=RSS_id //Array key indicating which RSS feed to display
this.cachetime=cachetime //Time to cache feed, in minutes. 0=no cache.
this.items_limit=items_limit //How many items to display
this.listerid=divId //ID of ticker div to display information
this.pointer=0
this.ajaxobj=createAjaxObj()
this.getAjaxcontent()
}

// -------------------------------------------------------------------
// getAjaxcontent()- Makes asynchronous GET request to "rssfetch.php" with the supplied parameters
// -------------------------------------------------------------------

rss_lister.prototype.getAjaxcontent=function(){
if (this.ajaxobj){
var instanceOfLister=this
var parameters="url="+encodeURIComponent(this.RSS_id)+"&ttl="+this.cachetime
this.ajaxobj.onreadystatechange=function(){instanceOfLister.initialize()}
this.ajaxobj.open('GET', "/js/rss_fetch.php?"+parameters, true)
this.ajaxobj.send(null)
}
}

// -------------------------------------------------------------------
// initialize()- Initialize lister method.
// -Gets contents of RSS content and parse it using JavaScript DOM methods 
// -------------------------------------------------------------------

rss_lister.prototype.initialize=function(){ 
if (this.ajaxobj.readyState == 4){ //if request of file completed
if (this.ajaxobj.status==200){ //if request was successful
var xmldata=this.ajaxobj.responseXML
if(xmldata.getElementsByTagName("item").length==0){ //if no <item> elements found in returned content
document.getElementById(this.listerid).innerHTML="<!-- no news is good news -->"
return
}
var instanceOfLister=this
this.feeditems=xmldata.getElementsByTagName("item")

var listerDiv=document.getElementById(this.listerid)
var listercontent='<ul class="rss-list">'
this.feeditems=xmldata.getElementsByTagName("item")
for (var i=0; i<Math.min(this.feeditems.length,this.items_limit); i++){
listercontent+='<li><a href="'+this.feeditems[i].getElementsByTagName("link")[0].firstChild.nodeValue+'">'+this.feeditems[i].getElementsByTagName("title")[0].firstChild.nodeValue+'</a>'
var desc = this.feeditems[i].getElementsByTagName("description")[0].firstChild
if(desc!=null)
	listercontent+="<div class=\"ltdesc\">"+desc.nodeValue+"</div>"
listercontent+="</li>"
}
listercontent+="</ul>"

listerDiv.innerHTML=listercontent
}
}
}


// ARTICLES BOXES POPUP 

function open_popup(src,width,height) {
  if ( document.all || document.getElementById || document.layers ) { if ( width>screen.width ) { width = screen.width - 200; } }
  features = 'location=0,statusbar=0,menubar=0,scrollbars=1,width=' + width +',height=' + height + ',screenX=100,screenY=100';
  var theWindow = window.open(src.getAttribute('href'), src.getAttribute('target') || '_blank', features);
  theWindow.focus();
  return theWindow;
}


// POLLS
function styleToggle(b)
{
	for (var i = 0; i< b.form.length; i++)
	{
		if (b.form[i].name == b.name)
		{
			b.form[i].parentNode.style.fontWeight = b.form[i].checked? 'bold' : '';
		}
	}
}


String.prototype.htmlEntities = function () {
   return this.replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;');
};

