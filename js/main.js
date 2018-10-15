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

function htmlLoad(divId,htmlUrl) {
  $.ajax({
    url : htmlUrl,
    type : "GET",
    cache : false,
    dataType: "html",
    success : function(data) {
      if(data) {
        $('#'+divId).html(data);
      } else {
        console.log('No data from ' + htmlUrl)
      }
    },
    error: function(XMLHttpRequest, textStatus, errorThrown) { 
      console.log("Response: " + XMLHttpRequest.responseText + ' - ' + errorThrown);
    }
  });
}
