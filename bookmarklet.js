(function() {
  var hn_close_button, hn_comments, hn_comments_html, hn_frame, hn_status, style;
  style = "<style type=\"text/css\">\n	#hn-comments {\n		display: none;\n		position: fixed;\n		bottom: 0;\n		z-index: 999999;\n		\n		width: 100%;\n		height: 40px;\n\n		border: 0;\n		background: #fff;\n		\n		-moz-box-shadow: rgba(0, 0, 0, 0.2) 0 -5px 6px 0;\n		-webkit-box-shadow: rgba(0, 0, 0, 0.2) 0 -5px 6px 0;\n		-o-box-shadow: rgba(0, 0, 0, 0.2) 0 -5px 6px 0;\n		box-shadow: rgba(0, 0, 0, 0.2) 0 -5px 6p;\n	}\n	\n	#hn-close-button {\n		position: absolute;\n		top: 10px;\n		right: 10px;\n		color: #999;\n		cursor: auto;\n		display: block;\n		font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif;\n		font-size: 18px;\n		height: 10px;\n		width: 11px;\n		line-height: 10px;\n		text-decoration: none;\n	}\n	\n	#hn-status {\n		text-align: center;\n		padding-top: 10px;\n		font-family: Verdana;\n		font-size: 12px;\n	}\n	\n	#hn-frame {\n		display: none;\n		width: 100%;\n		height: 100%;\n		border: 0;\n	}\n</style>";
  $("head").append(style);
  hn_comments_html = "<div id=\"hn-comments\">\n	<div id=\"hn-close\">\n		<a href=\"#\" id=\"hn-close-button\">&times;</a>\n	</div>\n	<div id=\"hn-status\">\n		Loading...\n	</div>\n	<iframe id=\"hn-frame\" />\n</div>";
  hn_comments = $("#hn-comments");
  if (hn_comments.length) {
    if (hn_comments.is(":visible")) {
      hn_comments.slideUp("fast");
    } else {
      hn_comments.slideDown("fast");
    }
  } else {
    hn_comments = $(hn_comments_html);
    hn_status = hn_comments.find("#hn-status");
    hn_frame = hn_comments.find("#hn-frame");
    $.getJSON("http://api.ihackernews.com/getid?format=jsonp&callback=?&url=" + encodeURI(window.location), function(data) {
      hn_comments.appendTo("body");
      hn_comments.slideDown("fast");
      if (data.length) {
        hn_frame.attr("src", "http://news.ycombinator.com/item?id=" + data[0]);
      } else {
        hn_frame.attr("src", "http://news.ycombinator.com/submitlink?u=" + encodeURIComponent(document.location) + "&t=" + encodeURIComponent(document.title));
      }
      return hn_frame.bind("load", function() {
        hn_status.fadeOut("fast");
        hn_frame.fadeIn("fast");
        return hn_comments.animate({
          height: "60%"
        });
      });
    });
  }
  hn_close_button = hn_comments.find("#hn-close-button");
  hn_close_button.click(function() {
    return hn_comments.slideUp("fast");
  });
}).call(this);
