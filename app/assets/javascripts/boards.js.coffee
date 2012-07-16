jQuery ->
  $('#todo-items, #doing-items, #done-items').sortable({
    connectWith: '.sortable-board',
    receive: (event, ui) ->
      pin_id = ui.item.data('id')
      status = $(this).attr('data-status')
      $.post('/pins/'+pin_id, { "_method": "PUT", pin: { status: status }})
  }).disableSelection()
  $('[data-toggle="modal"]').click(() ->
    $modal = $($(this).attr('href'))
    console.log($modal)
    $modal.on('show', () -> $('html').css('overflow', 'hidden'))
    $modal.on('hide', () -> $('html').css('overflow', 'scroll'))
  )
 


$(window).load(() ->
  max_height = 0
  $('#todo-items, #doing-items, #done-items').each(() ->
    if $(this).height() > max_height
      max_height = $(this).height()
    console.log($(this).height())
  )
  $('#todo-items, #doing-items, #done-items').each(() ->
    console.log(max_height)
    $(this).css('min-height', max_height)
  )
) 
