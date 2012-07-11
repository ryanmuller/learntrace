document.initializeItems = () ->
  $('.img-container').hover(() ->
    $('.actions', this).show()
  , () ->
    $('.actions', this).hide())

jQuery ->
  $('#todo-items, #doing-items, #done-items').sortable({
    connectWith: '.sortable-board',
    receive: (event, ui) ->
      pin_id = $('.pin', event.target).attr('data-id')
      status = $(this).attr('data-status')
      $.post('/pins/'+pin_id, { "_method": "PUT", pin: { status: status }})
  }).disableSelection()

  document.initializeItems()
