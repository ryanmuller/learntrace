jQuery ->
  $(window).scroll ->
    return false if $("#loader").length == 0
    height = Math.min($('.scroll-col').eq(0).height(),
                      $('.scroll-col').eq(1).height(),
                      $('.scroll-col').eq(2).height())
    if not ($('#loader').hasClass('loading') || $("#main-board").hasClass("no-load"))  and $(window).scrollTop() > height - $(window).height() - 50
      $('#loader').addClass('loading')
      $.getScript('/items')
   $(window).scroll
