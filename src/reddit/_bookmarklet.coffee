	# Put specialized code here. Do not change the indent level of the code below.
	$.getJSON "http://www.reddit.com/api/info.json?count=1&jsonp=?&url=" + encodeURI(window.location), (data) ->
		link = data?.data?.children[0]?.data?.permalink
		if (link)
			panel_frame.attr "src", "http://www.reddit.com" + link
		else
			panel_frame.attr "src", "http://www.reddit.com/submit?url=" + encodeURIComponent(document.location) + "&title=" + encodeURIComponent(document.title)