window.embedly = () ->
 # render embedly embeds, but switch youtube thumbs to youtube video...
 $('.embed').embedly({key:"309c8f118a624159a31ec483f7ae5ceb", elems: $(this),  success: (oembed, dict) ->
	 $el = this.elems[0]
	 if oembed.thumbnail_url != undefined && oembed.thumbnail_url.match("img.youtube.com")
		 console.log('trying to use youtube image!!')
		 yt = "http://www.youtube.com/watch?v=" + oembed.thumbnail_url.match(/vi\/(.*)\//)[1]
		 $el.attr('href', yt)
		 $(this.elems[0]).embedly({key: "309c8f118a624159a31ec483f7ae5ceb" })
	 else
		 $el.replaceWith(oembed.code)
 })



jQuery ->
 $('[rel=tooltip]').tooltip()
 window.embedly()
