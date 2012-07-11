jQuery ->
  $(window).scroll ->
    height = Math.min($('.scroll-col').eq(0).height(),
                      $('.scroll-col').eq(1).height(),
                      $('.scroll-col').eq(2).height())
    console.log(height)
    if not ($('#loader').hasClass('loading') || $("#main-board").hasClass("no-load"))  and $(window).scrollTop() > height - $(window).height() - 50
      $('#loader').addClass('loading')
      $.getScript('/items')
   $(window).scroll
