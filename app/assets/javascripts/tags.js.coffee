
jQuery ->


  $(document).ready ->

    d = $("#tag-input").data('tags').split(",")
    $("#tag-input").typeahead({ 
      source: d,
      onselect: (e) ->
        $("#main-board").html("<h2>loading...</h2>")
        $("#main-board").load('/items/tag_filter', { tag: e })
        $("#main-board").addClass('no-load')
        console.log('finished')
      }).keyup((e) ->
        console.log(e)
        if e.keyCode == 27
          $("#tag-input").val('')
        if ($("#tag-input").val() == "" and $("#main-board").hasClass("no-load")) 
          $("#main-board").load('/items/tag_filter', {tag: ""})
          $("#main-board").removeClass("no-load")
        
      )
