jQuery ->
	LearnstreamUtils.initialize_items()


window.LearnstreamUtils = {

	initialize_items: () ->
		console.log('initializing')
		$('.item').each(() ->
			if ! $(this).hasClass('initialized')
				$(this).addClass('initialized')
				$(this).hover(() ->
					$('.actions', this).show()
				, () ->
					$('.actions', this).hide())

				$(this).find('.clickable').click((e) ->
					$item = $(this).parents('.item')
					$modal = $("#item-modal-" + $item.data('id'))
					$modal.modal('show')
					$modal.on('hide', () -> $('html').css('overflow-y', 'scroll'))
					$('html').css('overflow', 'hidden')
					return false
				)

		)
}
