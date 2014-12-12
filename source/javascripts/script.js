$(window).scroll(function() {
// If the current scroll position is more than the branding height minus the nav height,
// add the sticky class to branding so we can mess with it, and hide the zigzags
if ($(window).scrollTop() > $('#branding').height() - $('nav').height()){  
    $('body').addClass("sticky");
    $('#topborder').hide();
    $('section#main #slide-1 .small-12').css('padding-top', $('#branding').outerHeight() * 2)
  }
  else{
    $('body').removeClass("sticky");
    $('#topborder').show();
    $('section#main #slide-1 .small-12').css('padding-top', 0)
  }
});