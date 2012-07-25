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

   

 #$('#stream-pins').sortable({
 #   cancel: ".date"
 #})
