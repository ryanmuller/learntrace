jQuery ->
	$(document).on('click', "#stream-title", () ->
		$stream_id = $(this).data('id')
		console.log($(this))
		$(this).replaceWith('<input id="edit-stream-title" name="stream[name]" type="text" value="' + $(this).text() + '"></input>')
		$edit_input = $("#edit-stream-title")
		$edit_input.focus()
		$edit_input.keyup((e) ->
			if e.which == 13
				$.ajax({ url: '/streams/' + $stream_id, type: "PUT", data: { "stream[name]": $(this).val() } })
		)



	)
