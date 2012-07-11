jQuery ->
  $('#todo-items, #doing-items, #done-items').sortable({
    connectWith: '.sortable-board',
    receive: (event, ui) ->
      pin_id = ui.item.data('id')
      status = $(this).attr('data-status')
      $.post('/pins/'+pin_id, { "_method": "PUT", pin: { status: status }})
  }).disableSelection()


