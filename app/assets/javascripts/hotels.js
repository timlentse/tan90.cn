$(document).ready(function (){
  //load more hotels
  $(".pager > li > a ").click(function (e) {
    e.preventDefault();
    var pageId = $(this).attr('data-page');

    $.ajax({
      type: "POST",
      url: window.location.href,
      data: { page: pageId },
      dataType: "script",
      success: function (msg) {
      },
      error: function(msg) { 
        console.log(msg.responseText);
      }
    });
  });
  $("#search").click(function (e) {
    e.preventDefault();
    var location = $("#location").val();
    window.location.href="/search/?q="+location;
  });
});

