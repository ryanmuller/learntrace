jQuery -> 
  LearntristUtils.bind_form()


window.LearntristUtils = {
  bind_form: () ->
    console.log('binding forms!')
    $("form.new_pin").submit(() ->
      f = this
      $.post($(this).attr('action'), $(this).serialize(), (e) ->
        $(f).find('button').replaceWith('<i class="icon-ok"></i> Pinned!')
      )
      return false
    ) 
} 


