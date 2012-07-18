jQuery ->
	console.log('initializing from utilities.js')

  # bind item hover, which updates using jquery "live" for 
	# new elements added to DOM later.
	$('.item').live({
		mouseenter: () -> $('.actions', this).show(),
		mouseleave: () ->
			$('.actions', this).hide()
	})

	$('.item').find('.clickable').live("click", (e) ->
		$item = $(this).parents('.item')
		console.log($item)
		$modal = $("#item-modal-" + $item.data('id'))
		console.log($modal)
		$modal.modal('show')
		$modal.on('hide', () -> $('html').css('overflow-y', 'scroll'))
		$('html').css('overflow', 'hidden')
		return false
	)
