style = """
	<style type="text/css">
		#panel-comments {
			display: none;
			position: fixed;
			bottom: 0;
			z-index: 999999;
			
			width: 100%;
			height: 40px;

			border: 0;
			background: #fff;
			
			-moz-box-shadow: rgba(0, 0, 0, 0.2) 0 -5px 6px 0;
			-webkit-box-shadow: rgba(0, 0, 0, 0.2) 0 -5px 6px 0;
			-o-box-shadow: rgba(0, 0, 0, 0.2) 0 -5px 6px 0;
			box-shadow: rgba(0, 0, 0, 0.2) 0 -5px 6p;
		}
		
		#panel-close-button {
			position: absolute;
			top: 10px;
			right: 10px;
			color: #999;
			cursor: auto;
			display: block;
			font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif;
			font-size: 18px;
			height: 10px;
			width: 11px;
			line-height: 10px;
			text-decoration: none;
		}
		
		#panel-status {
			text-align: center;
			padding-top: 10px;
			font-family: Verdana;
			font-size: 12px;
		}
		
		#panel-frame {
			display: none;
			width: 100%;
			height: 100%;
			border: 0;
		}
	</style>
"""

$("head").append style

panel_comments_html = """
	<div id="panel-comments">
		<div id="panel-close">
			<a href="#" id="panel-close-button">&times;</a>
		</div>
		<div id="panel-status">
			Loading...
		</div>
		<iframe id="panel-frame" />
	</div>
"""

panel_comments = $("#panel-comments")
if panel_comments.length
	if panel_comments.is(":visible")
		panel_comments.slideUp "fast"
	else
		panel_comments.slideDown "fast"
else
	panel_comments = $(panel_comments_html)
	panel_status = panel_comments.find("#panel-status")
	panel_frame = panel_comments.find("#panel-frame")
	
	panel_comments.appendTo("body")
	panel_comments.slideDown "fast"
	
# The tag below will be replaced by the specialized code for each panel.
	# Put specialized code here. Do not change the indent level of the code below.
	$.getJSON "http://www.reddit.com/api/info.json?count=1&jsonp=?&url=" + encodeURI(window.location), (data) ->
		link = data?.data?.children[0]?.data?.permalink
		if (link)
			panel_frame.attr "src", "http://www.reddit.com" + link
		else
			panel_frame.attr "src", "http://www.reddit.com/submit?url=" + encodeURIComponent(document.location) + "&title=" + encodeURIComponent(document.title)

	panel_frame.bind "load", ->
		panel_status.fadeOut "fast"
		panel_frame.fadeIn "fast"
		panel_comments.animate {height: "60%"}

panel_close_button = panel_comments.find("#panel-close-button")
panel_close_button.click ->
	panel_comments.slideUp "fast"
