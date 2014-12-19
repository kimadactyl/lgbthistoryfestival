$(window).scroll(function() {
// If the current scroll position is more than the branding height minus the nav height,
// add the sticky class to branding so we can mess with it, and hide the zigzags
if ($(window).scrollTop() > $('#branding').height() + 200 - $('nav#primary').height()){  
    $('body').addClass("sticky");
    $('#topborder').hide();
    $('#branding').hide();
    $('#branding').slideDown();
    // I can't 100% justify this number but I feel that [branding height] times two works.
    // Basically, you've scrolled [branding height] and then the actual [branding height] makes two.
    // If that makes sense.
    $('section#main #slide-1 .small-12').css('padding-top', $('#branding').outerHeight() * 2)
  }
  else{
    $('body').removeClass("sticky");
    $('#topborder').show();
    $('#branding').show();
    $('section#main #slide-1 .small-12').css('padding-top', 0)
  }
});
