window.renderPin = () ->

	# render datepicker
	$('.rescheduler').datepicker()
		.on('changeDate', (ev) ->
			url = '/pins/'+$(ev.target).attr('data-id')
			data = { pin : { scheduled_at : ev.date.valueOf()/1000 } }
			$.ajax({ url : url, data : data, type : 'PUT' }))

	# render embedly embeds, but switch youtube thumbs to youtube video...
	$('.embed-me').embedly({key:"309c8f118a624159a31ec483f7ae5ceb", elems: $(this),  success: (oembed, dict) ->
		$el = this.elems[0]
	 if oembed.thumbnail_url != undefined && oembed.thumbnail_url.match("img.youtube.com")
		 yt = "http://www.youtube.com/watch?v=" + oembed.thumbnail_url.match(/vi\/(.*)\//)[1]
		 $el.attr('href', yt)
		 $(this.elems[0]).embedly({key: "309c8f118a624159a31ec483f7ae5ceb" })
	 else
		 $el.replaceWith(oembed.code)
	})



jQuery ->
	$('[rel=tooltip]').tooltip()
	window.renderPin()


	$('.pin-link').click(() ->
		state = History.getState()
		History.pushState({ stream: $(this).data('stream'), pin: $(this).data('pin') }, "Pin " + $(this).data('pin'),  "/" + state.cleanUrl.split("/")[3] + '/' + $(this).data('stream') + '/pins/' + $(this).data('pin'))
	)

	rootUrl = History.getRootUrl()
	console.log(rootUrl)
	if $("#stream-pin").length > 0
		console.log(History.getState())
		History.replaceState({ stream:  $("#stream-pin").data('stream'), pin: $("#stream-pin").data('pin') },  "Pin " + $("#stream-pin").data('pin'),  "/" + History.getState().cleanUrl.split("/")[3] + "/" + $("#stream-pin").data('stream') + '/pins/' + $("#stream-pin").data('pin'))

	$(window).bind('statechange', ()->
		state = History.getState()
		data = state.data
		console.log(state)
		console.log(data)
		$.get('/streams/' + data.stream + '/stream_pins/' + data.pin)
	)

