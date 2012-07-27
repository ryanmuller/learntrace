jQuery ->
	# bind item hover, which updates using jquery "on" for 
	# new elements added to DOM later.
	$('body').on("mouseenter", ".item", () -> $('.actions', this).show())
	$('body').on("mouseleave", ".item", () -> $('.actions', this).hide())

	$('body').on('click', '.clickable', (e) ->
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


	$('.item').on('click', ".dropdown-menu input", (e) ->
		# prevent it from submitting the form... instead must hit enter.
		return false
	)
	$('.item').on('click', '.dropdown-menu > li > a', (e) ->
		$form = $(this).parents('form')
		$form.find('[name="pin[stream_id]"]').val($(this).data('stream'))
		$form.submit()
		return false
	)
