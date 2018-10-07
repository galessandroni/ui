$(function() {

  // map expand
  $(".subtopics-header").click(function () {
    $link = $(this);
    $container = $link.parent();
    $content = $container.next();
    if($content.css('display')=='none') {
      $(".subtopics").slideUp("slow");
    }
    $content.slideToggle("slow");
  });
});
