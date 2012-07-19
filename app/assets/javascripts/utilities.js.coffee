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
		$modal = $("#item-modal-" + $item.data('id'))
		$modal.modal('show')
		$modal.on('hide', () -> $('html').css('overflow-y', 'scroll'))
		$('html').css('overflow', 'hidden')
		return false
	)

	$('body').on('focus.customtypeahead.tags', '[data-provide="tag-typeahead"]',  (e) ->
		$this = $(this)
		return if $this.data('typeahead')
		e.preventDefault()
		$this.typeahead({ source: $("#tag-data").data('tags').split(",") })
	)

	$('body').on('focus.customtypeahead.streams', '[data-provide="stream-typeahead"]',  (e) ->
		$this = $(this)
		return if $this.data('typeahead')
		e.preventDefault()
		$this.typeahead({ source: $("#current-user-stream-data").data('streams').split(",") })
	)
