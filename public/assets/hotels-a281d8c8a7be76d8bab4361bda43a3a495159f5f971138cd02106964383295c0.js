$(document).ready(function (){

  //load more hotels
  $(".pager > li > a ").click(function (e) {
    e.preventDefault();
    var pageId = $(this).attr('data-page');

    $.ajax({
      type: "POST",
      url: window.location.pathname,
      data: { page: pageId },
      dataType: "script",
      success: function (msg) {
      },
      error: function(msg) { 
        console.log(msg.responseText);
      }
    });
  });

});

