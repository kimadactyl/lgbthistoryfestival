// if(Modernizr.svg) {
//     $('#branding img[src*="png"]').attr('src', function() {
//         return $(this).attr('src').replace('.png', '.svg');
//     });
// }

var DEFAULT_FILTER = '.main-festival, .family-space, .films, .theatre, .fringe'

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

// Adapted from stack overflow
function insertParam(key, value)
{
  key = encodeURI(key); value = encodeURI(value);

  var kvp = document.location.search.substr(1).split('&');
  var i=kvp.length; var x; while(i--)
  {
    x = kvp[i].split('=');

    if (x[0]==key)
    {
      x[1] = value;
      if(value != ""){
        kvp[i] = x.join('=');
      } else {
        // if value is empty, remove key
        kvp.splice(i,1);
      }
      break;
    }
  }

  if(i<0) {kvp[kvp.length] = [key,value].join('=');}
  var path = document.location.pathname;
  // Not sure if this is the best way or not, but it doesn't force a refresh!
  var newurl = path + "?" + kvp.join('&'); //slightly faulty, prepends & to searchstring
  var title = document.title.toString();
  window.history.replaceState(null, title, newurl)
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

function filterBySpeaker(select) {
  //TODO!
  insertParam("speaker",select);
  if(select == ""){
    $("#program").mixItUp('filter', DEFAULT_FILTER);
  } else {
    $("#program").mixItUp('filter', "."+select);
  }
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
      filter: DEFAULT_FILTER
    }
  });

  $("#speakerlist").data("placeholder","Select a speaker").chosen({allow_single_deselect:true});

  $("#speakerlist").change(function() {
    filterBySpeaker($(this).val());
  });
  var speaker = getParameterByName("speaker");
  // doesn't work
  if(speaker){
    $("#speakerlist>option[value="+speaker+"]").attr('selected',true);
    $("#speakerlist").trigger('chosen:updated')
  }

});
