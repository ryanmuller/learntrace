jQuery -> 

  $(".comments-form").submit(() ->
    data = $(this).serialize()
    console.log(this)
    console.log(data)
    $.post($(this).attr('action'), data)
    $(this).find("#comment_content").val('')
    return false
  )
