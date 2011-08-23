style = """
	<style type="text/css">
		#reddit-panel {
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
		
		#reddit-panel .close-button {
			position: absolute;
			top: 10px;
			right: 10px;
			padding: 5px;
			background: #fff;
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
		
		#reddit-panel .status {
			text-align: center;
			padding-top: 10px;
			font-family: Verdana;
			font-size: 12px;
		}
		
		#reddit-panel .frame {
			display: none;
			width: 100%;
			height: 100%;
			border: 0;
		}
	</style>
"""

head = $("head")
if not head.length
	# Create head <-- this is necessary for images
	$("html").append $("<head></head>")
$("head").append style

panel_html = """
	<div id="reddit-panel" class="panel">
		<div class="close">
			<a href="#" class="close-button">&times;</a>
		</div>
		<div class="status">
			Loading...
		</div>
		<iframe class="frame" />
	</div>
"""

panel = $("#reddit-panel")
if panel.length
	if panel.is(":visible")
		panel.slideUp "fast"
	else
		panel.slideDown "fast"
else
	panel = $(panel_html)
	panel_status = panel.find(".status")
	panel_frame = panel.find(".frame")
	
	panel.appendTo("body")
	panel.slideDown "fast"
	
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
		panel.animate {height: "60%"}

panel_close_button = panel.find(".close-button")
panel_close_button.click ->
	panel.slideUp "fast"
