$(document).ready(function (){

  // init checkin and checkout date %>
  var start_day=new Date();
  var end_day= new Date();
  end_day.setDate(start_day.getDate() + 1);
  $(function () { 
    $("#checkin").datetimepicker({
      format:'YYYY-MM-DD',
      defaultDate:start_day
    });

    $("#checkout").datetimepicker({
      format:'YYYY-MM-DD',
      defaultDate:end_day
    });
    $('[data-toggle="popover"]').popover({"trigger": "hover"});
  })

  $("#search").click(function (e) {
    e.preventDefault();
    var location = $("#location").val() || '台北';
    window.location.href="/fishtrip/search/?q="+location;
  });

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

});

