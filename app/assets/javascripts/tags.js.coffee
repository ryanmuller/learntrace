jQuery ->
   
  if $("#tag-input").length > 0
    d = $("#tag-input").data('tags').split(",")
    $("#tag-input").typeahead({ 
      source: d,
      onselect: (e) ->
        $("#main-board").load('/items/tag_filter', { tag: e }, () -> LearnstreamUtils.initialize_items())
        $("#main-board").addClass('no-load')
      }).keyup((e) ->
        if e.keyCode == 27
          $("#tag-input").val('')
        if ($("#tag-input").val() == "" and $("#main-board").hasClass("no-load"))
          $("#main-board").load('/items/tag_filter', {tag: ""}, () -> LearnstreamUtils.initialize_items())
          $("#main-board").removeClass("no-load")
      )
        


  if $("#tag-typehead").length > 0
    d = $("#tag-typehead").data('tags').split(",")
    $("#tag-typehead").typeahead({ source: d })
