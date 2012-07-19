jQuery ->



	$("#tag-search-form").submit(() ->
		$("#tag-search-loading").show()
		$("#main-board").hide()
	)
		
	$("#tag-search-input").keyup((e) ->
		if e.keyCode == 27
			$(this).val('')
		if ($(this).val() == "" and $("#main-board").hasClass("no-load"))
			$("#main-board").load('/items/tag_filter', { tag: "" })
			$("#main-board").removeClass('no-load')
	)

