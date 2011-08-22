style = """
	<style type="text/css">
		#hn-comments {
			display: none;
			position: fixed;
			bottom: 0;
			z-index: 999999;
			
			width: 100%25;
			height: 40px;

			border: 0;
			background: #fff;
			
			-moz-box-shadow: rgba(0, 0, 0, 0.2) 0 -5px 6px 0;
			-webkit-box-shadow: rgba(0, 0, 0, 0.2) 0 -5px 6px 0;
			-o-box-shadow: rgba(0, 0, 0, 0.2) 0 -5px 6px 0;
			box-shadow: rgba(0, 0, 0, 0.2) 0 -5px 6p;
		}
		
		#hn-status {
			text-align: center;
			padding-top: 10px;
			font-family: Verdana;
			font-size: 12px;
		}
		
		#hn-frame {
			display: none;
			width: 100%25;
			height: 100%25;
			border: 0;
		}
	</style>
"""

$("head").append style

hn_comments_html = """
	<div id="hn-comments">
		<div id="hn-status">
			Loading...
		</div>
		<iframe id="hn-frame" />
	</div>
"""

hn_comments = $("#hn-comments")
if hn_comments.length
	if hn_comments.is(":visible")
		hn_comments.slideUp "fast"
	else
		hn_comments.slideDown "fast"
else
	hn_comments = $(hn_comments_html)
	hn_status = hn_comments.find("#hn-status")
	hn_frame = hn_comments.find("#hn-frame")
	
	$.getJSON "http://api.ihackernews.com/getid?format=jsonp&callback=?&url=" + encodeURI(window.location), (data) ->
		
		hn_comments.appendTo("body")
		hn_comments.slideDown "fast"
		
		if (data.length)
			hn_frame.attr "src", "http://news.ycombinator.com/item?id=" + data[0]
		else
			hn_frame.attr "src", "http://news.ycombinator.com/submitlink?u=" + encodeURIComponent(document.location) + "&t=" + encodeURIComponent(document.title)
		
		hn_frame.bind "load", ->
			hn_status.fadeOut "fast"
			hn_frame.fadeIn "fast"
			hn_comments.animate {height: "400px"}