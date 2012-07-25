jQuery ->
	$(".new_item").submit((e) ->
		$('#stream-pins').append('<div class="date calculating-thumb">Calculating Thumbnail...</div>')
		$('#stream-pins').append('<div class="row-fluid item-task calculating-thumb"><div class="span2 pin-micro"><img src="/assets/no-thumbnail.png"></div><div class="span10"><a href="#">' + $(this).find('#item_name').val() + '</a></div></div>')

		$('.nav-tabs a[href="#stream-items"]').tab('show')
		
		$('#stream-pins').scrollTop(9999)
		$button = $(this).find('.form-actions > input')
		$button.val('calculating thumb...')
		$button.addClass('disabled')
	)
