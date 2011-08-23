style = """
	<style type="text/css">
		#{{panel_id}}-panel {
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
		
		#{{panel_id}}-panel .close-button {
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
		
		#{{panel_id}}-panel .status {
			text-align: center;
			padding-top: 10px;
			font-family: Verdana;
			font-size: 12px;
		}
		
		#{{panel_id}}-panel .frame {
			display: none;
			width: 100%;
			height: 100%;
			border: 0;
		}
	</style>
"""

$("head").append style

panel_html = """
	<div id="{{panel_id}}-panel" class="panel">
		<div class="close">
			<a href="#" class="close-button">&times;</a>
		</div>
		<div class="status">
			Loading...
		</div>
		<iframe class="frame" />
	</div>
"""

panel = $("#{{panel_id}}-panel")
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
{{code}}

	panel_frame.bind "load", ->
		panel_status.fadeOut "fast"
		panel_frame.fadeIn "fast"
		panel.animate {height: "60%"}

panel_close_button = panel.find(".close-button")
panel_close_button.click ->
	panel.slideUp "fast"