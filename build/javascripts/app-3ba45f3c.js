$(document).foundation({
  orbit: {
    animation: 'slide',
    timer_speed: 8000,
    pause_on_hover: true,
    animation_speed: 500,
    stack_on_small: true,
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
