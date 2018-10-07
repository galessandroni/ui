$(function() {

  // map expand
  $(".subtopics-header").click(function () {
    $link = $(this);
    $container = $link.parent();
    $content = $container.next();
    if($content.css('display')=='none') {
      $(".subtopics").slideUp("slow");
      $(".subtopics-header").removeClass('fa-minus-square').addClass('fa-plus-square');
    }
    $content.slideToggle("slow");
    $link.toggleClass('fa-plus-square fa-minus-square');
  });
});
