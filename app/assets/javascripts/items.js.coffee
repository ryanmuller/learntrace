jQuery ->
  LearnstreamUtils.initialize_items()


window.LearnstreamUtils = {
  bind_form: () ->
    $("form.new_pin").unbind('submit')
    $("form.edit_pin").unbind('submit')
    $(".comments-form").unbind('submit')
    $('.tag-submit-form').unbind('submit')

    $("form.new_pin").submit(() ->
      f = this
      return false if $(this).find('button').hasClass('disabled')
      id = $(this).data('item_id')
      $.post($(this).attr('action'), $(this).serialize(), (e) ->
        $('.pin-button-' + id).replaceWith('<button class="btn disabled"><i class="icon-ok"></i> Pinned!</button>')
      )
      return false
    )
    
    $("form.edit_pin").submit((e) ->
      f = this
      id = $(this).data('item_id')
      $.post($(this).attr('action'), $(this).serialize(), (e) ->
        $(f).find('button').replaceWith('<button class="btn disabled"><i class="icon-ok"></i> Unpinned!</button>')
      )
      $("#item-modal-" + id).modal('hide')
      
      return false
    )

    $(".comments-form").submit(() ->
      data = $(this).serialize()
      $.post($(this).attr('action'), data)
      $(this).find("#comment_content").val('')
      return false
    )

    # ajaxify tag submit...
    $('.tag-submit-form').submit(() ->
      data = $(this).serialize()
      $.post($(this).attr('action'), data)
      $(this).find("#tag-typehead").val('')
      return false
    )

  initialize_items: () ->
    LearnstreamUtils.bind_form()
    console.log('initializing')
    $('.item').each(() ->
      if ! $(this).hasClass('initialized')
        $(this).addClass('initialized')
        $(this).hover(() ->
          $('.actions', this).show()
        , () ->
          $('.actions', this).hide())
        
        $(this).find('.clickable').click((e) ->
            # get item element...
            $item = $(this).parents('.item')
            $modal = $("#item-modal-" + $item.data('id'))
    
            
            $modal.modal('show')
            $modal.on('hide', () -> $('html').css('overflow-y', 'scroll'))
            $('html').css('overflow', 'hidden')
          
            return false)
  
    )
    
}
