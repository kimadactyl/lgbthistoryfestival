$(document).foundation({
  orbit: {
    animation: 'slide',
    timer_speed: 5000,
    pause_on_hover: true,
    animation_speed: 500,
  }
});

$("form#contribute").validate({
    errorClass: 'error',
    rules: {
      about: {
          required: true,
          minlength: 50
      },
      email: {
        required: true,
        email: true
      }
    }
});
