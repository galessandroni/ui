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

function rssListLoad(divId,rssUrl,host) {
  var parameters="url="+encodeURIComponent(rssUrl)+"&ttl=30"
  var url=host+'/js/rss_fetch.php?'+parameters
  $.get(url, function(data) {
    var $XML = $(data);
    var mList = $('<ul/>')
    $XML.find("item").each(function() {
        var $this = $(this),
            item = {
                title:       $this.find("title").text(),
                link:        $this.find("link").text(),
                description: $this.find("description").text()
            };
        if(item.title && item.link) {
          mList.append($('<li/>').html('<a href="'+item.link+'">'+item.title+'</a><div>'+item.description+'</div>'));
        }
    });
    $('#'+divId).append(mList)
    if($('#'+divId+' li').length) {
      $('#'+divId).easyTicker({
        direction: 'up',
        speed: 'slow',
        interval: 4000,
        visible: 1,
        mousePause: 1
      })  
    }
  });
}

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

// hs.graphicsDir = 'https://www.peacelink.it/js/highslide/graphics/';

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

