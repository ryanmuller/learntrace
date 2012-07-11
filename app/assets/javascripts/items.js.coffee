jQuery ->
  LearnstreamUtils.bind_form()
  LearnstreamUtils.initialize_items()


window.LearnstreamUtils = {
  bind_form: () ->
    $("form.new_pin").submit(() ->
      f = this
      $.post($(this).attr('action'), $(this).serialize(), (e) ->
        $(f).find('button').replaceWith('<button class="btn disabled"><i class="icon-ok"></i> Pinned!</button>')
      )
      return false
    )

  initialize_items: () ->
    $('.img-container').hover(() ->
      $('.actions', this).show()
    , () ->
      $('.actions', this).hide())
}
