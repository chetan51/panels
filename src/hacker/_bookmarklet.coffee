	# Put specialized code here. Do not change the indent level of the code below.
	$.getJSON "http://api.thriftdb.com/api.hnsearch.com/items/_search?filter[fields][type]=submission&sortby=points desc&limit=1&callback=?&q=" + encodeURI(window.location), (data) ->
		if (data.hits)
			panel_frame.attr "src", "http://news.ycombinator.com/item?id=" + data.results[0].item.id
		else
			panel_frame.attr "src", "http://news.ycombinator.com/submitlink?u=" + encodeURIComponent(document.location) + "&t=" + encodeURIComponent(document.title)