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

// Calendar
$( document ).ready(function() {

  // Check to see if any rows are empty and hide the times
  function checkBlanks(){
    $(".timegroup").each(function() {
      if($('.timeblock li', this).children(':visible').length == 0) {
        $('h3.time', this).hide();
      } else {
        $('h3.time', this).show();
      }
    })
    $(".schedule h2").each(function() {
      if($(this).next().height() == 0) {
        $(this).hide();
      } else {
        $(this).show();
      }
    })
  }
  // Wire up buttons to trigger appropriate sections
  function toggleProgram($trigger, $element){
    $trigger.click(function(){
      // Toggle the program boxes
      $element.toggle();
      // Toggle the key box
      $trigger.toggleClass('disabled');
      // Toggle the on/off icon
      $('span.status i', $trigger).toggleClass('fi-check');
      $('span.status i', $trigger).toggleClass('fi-x');
      // Check for blank time rows
      checkBlanks();
    })
  }

  $("li.bio-boxes").click(function() {
    var these = $("."+this.id);
    console.log(these)
    $(".program li.event").not(these).hide();
    $(these).show();
    checkBlanks();
  })

  // Check for click events on expanded/contracted selector
  $("input[name='expanded']").click(function() {
    if($(this).attr("value")=="0"){
      $("ul.program .description").hide();
    }
    if ($(this).attr("value")=="1"){
      $("ul.program .description").show();
    }
  });

  // Click event to expand.
  $("ul.program li").click(function() {
    $(this).children(".description").toggle();
  })

  $("ul.key li").hover(function() {
    $('span.status i', this).toggleClass('fi-check');
    $('span.status i', this).toggleClass('fi-x');
  });

  // Hide the extended defs
  $("ul.program .description").hide();

  // MAIN SCHEDULE LOGIC
  toggleProgram($("ul.key .main-festival"), $("ul.program .main-festival"));
  toggleProgram($("ul.key .family-space"), $("ul.program .family-space"));
  toggleProgram($("ul.key .films"), $("ul.program .films"));
  toggleProgram($("ul.key .theatre"), $("ul.program .theatre"));
  toggleProgram($("ul.key .conference"), $("ul.program .conference"));
  toggleProgram($("ul.key .fringe"), $("ul.program .fringe"));

  // Hide the conference initially
  $(".schedule ul.program .conference").toggle();
  // Toggle off the conference button
  $(".schedule ul.key .conference").toggleClass('disabled');
  checkBlanks();

  // Show family events if captured in URL
  var family = window.getParameterByName("family");
  if(family == 1) {
    // This is absoltely horrible and needs refactoring
    $(".schedule ul.program .event").hide();
    $(".schedule ul.program .family-space").show();
    $(".schedule ul.key li").addClass('disabled');
    $(".schedule ul.key .family-space").removeClass('disabled');
    $("span.status i").removeClass('fi-check');
    $("span.status i").addClass("fi-x");
    $(".family-space span.status i").addClass("fi-check");
    $(".family-space span.status i").removeClass("fi-x");
    checkBlanks();
  }
});
