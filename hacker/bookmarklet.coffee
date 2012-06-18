style = """
	<style type="text/css">
		#hacker-panel {
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
		
		#hacker-panel .close-button {
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
		
		#hacker-panel .status {
			text-align: center;
			padding-top: 10px;
			font-family: Verdana;
			font-size: 12px;
		}
		
		#hacker-panel .frame {
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
	<div id="hacker-panel" class="panel">
		<div class="close">
			<a href="#" class="close-button">&times;</a>
		</div>
		<div class="status">
			Loading...
		</div>
		<iframe class="frame" />
	</div>
"""

panel = $("#hacker-panel")
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
	$.getJSON "http://api.thriftdb.com/api.hnsearch.com/items/_search?filter[fields][type]=submission&sortby=points desc&limit=1&callback=?&q=" + encodeURI(window.location), (data) ->
		if (data.hits)
			panel_frame.attr "src", "http://news.ycombinator.com/item?id=" + data.results[0].item.id
		else
			panel_frame.attr "src", "http://news.ycombinator.com/submitlink?u=" + encodeURIComponent(document.location) + "&t=" + encodeURIComponent(document.title)

	panel_frame.bind "load", ->
		panel_status.fadeOut "fast"
		panel_frame.fadeIn "fast"
		panel.animate {height: "60%"}

panel_close_button = panel.find(".close-button")
panel_close_button.click ->
	panel.slideUp "fast"
