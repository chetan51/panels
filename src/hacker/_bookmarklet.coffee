	# Put specialized code here. Do not change the indent level of the code below.
	$.getJSON "http://api.ihackernews.com/getid?format=jsonp&callback=?&url=" + encodeURI(window.location), (data) ->
		if (data.length)
			panel_frame.attr "src", "http://news.ycombinator.com/item?id=" + data[0]
		else
			panel_frame.attr "src", "http://news.ycombinator.com/submitlink?u=" + encodeURIComponent(document.location) + "&t=" + encodeURIComponent(document.title)