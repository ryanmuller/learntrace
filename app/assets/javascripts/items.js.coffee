jQuery ->
  LearnstreamUtils.initialize_items()


window.LearnstreamUtils = {
  bind_form: () ->
    $("form.new_pin").unbind('submit')
    $("form.edit_pin").unbind('submit')
    $("form.new_pin").submit(() ->
      f = this
      return false if $(this).find('button').hasClass('disabled')
      $.post($(this).attr('action'), $(this).serialize(), (e) ->
        $(f).find('button').replaceWith('<button class="btn disabled"><i class="icon-ok"></i> Pinned!</button>')
      )
      return false
    )
    
    $("form.edit_pin").submit(() ->
      f = this
      $.post($(this).attr('action'), $(this).serialize(), (e) ->
        $(f).find('button').replaceWith('<button class="btn disabled"><i class="icon-ok"></i> Unpinned!</button>')
      )
      return false
    )

  initialize_items: () ->
    LearnstreamUtils.bind_form()
    $('.item').hover(() ->
      $('.actions', this).show()
    , () ->
      $('.actions', this).hide())
}
