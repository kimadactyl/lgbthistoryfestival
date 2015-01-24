// if(Modernizr.svg) {
//     $('#branding img[src*="png"]').attr('src', function() {
//         return $(this).attr('src').replace('.png', '.svg');
//     });
// }

$(document).foundation({
  "magellan-expedition": {
    throttle_delay: 50,
    // FIX THIS!
    // Should get it from jQuery. For some reason $('#branding').outerHeight()
    // isn't giving the right height.
    fixed_top: 0,
    threshold: 0
  }
});

function getParameterByName(name) {
    var match = RegExp('[?&]' + name + '=([^&]*)').exec(window.location.search);
    return match && decodeURIComponent(match[1].replace(/\+/g, ' '));
}

// Front page arrows
$('.arrow').on('click', function(event){
  var target = $(this).parent().next();
  // Find the true visible height of #branding section and use that.
  var nav_deviation = $("#branding").outerHeight() + $("#branding").offset().top - $(window).scrollTop();

  // Dirty hack for edge case. condition borrowed from script.js
  if($(window).scrollTop() < $('#branding').height() + 200 - $('nav#primary').height()) {
    nav_deviation = 67;
  }

  var scrollMe = target.offset().top - nav_deviation;

  $('html, body').animate({
    scrollTop: scrollMe
  }, 1000);
});

// Background images
$(window).stellar({
  horizontalScrolling: false,
  verticalScrolling: true,
  responsive: true
});

// Readmore dropdowns
$('.index article').readmore({
  speed: 75,
  maxHeight: 0,
  moreLink: '<a href="#">Learn More</a>',
  afterToggle: function(trigger, element, expanded) {
    if(! expanded) { // The "Close" link was clicked
      $('html, body').animate( { scrollTop: element.offset().top }, {duration: 200 } );
    }
  }
});

// Check to see if any rows are empty and hide the times
function checkBlanks(){
  $(".timegroup").each(function() {
    if($('.timeblock li', this).children(':visible').length == 0) {
      $('h3.time', this).hide();
    } else {
      $('h3.time', this).show();
    }
  })
  $(".daytitle").each(function() {
    filter = $(this).next().find(".timeblock").children(':visible')
    if(filter.length == 0) {
      $(this).hide();
    } else {
      $(this).show();
      // Uncomment to debug filter errors.
      // console.log(filter.html() + "\n\n");
    }
  })
}

// Calendar
$( document ).ready(function() {

  checkBlanks();

  $('#program').mixItUp({
    animation: {
      enable: false
    },
    controls: {
      toggleFilterButtons: true
    },
    callbacks: {
      onMixEnd: function(state){
        checkBlanks();
      }
    },
    load: {
      filter: '.main-festival, .family-space, .films, .theatre, .fringe'
    }
  });

  $("#speakerlist").selectOrDie({placeholderOption:true});

});
