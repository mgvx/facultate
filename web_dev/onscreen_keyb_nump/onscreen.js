run_keyboard = function() {
  return $(function() {
	$write = $('.write');
    var capslock, shift;
    shift = false;
    capslock = false;
	$('.keyboard div').click( function(e) {
      var $this, character, event, input;
      $this = $(this);
      character = $this.html();
      if ($this.hasClass('left-shift') || $this.hasClass('right-shift')) {
        $('.letter').toggleClass('uppercase');
        $('.symbol span').toggle();
        shift = shift === true ? false : true;
        capslock = false;
        return false;
      }
      if ($this.hasClass('capslock')) {
        $('.letter').toggleClass('uppercase');
        if (shift === true) {
          $('.symbol span').toggle();
          shift = false;
        }
        capslock = true;
        return false;
      }
      if ($this.hasClass('delete')) {
        input = $write.val();
        $write.val(input.substr(0, input.length - 1));
        if ($write.attr("id") === "name") {
          $("#name").trigger('keydown');
        }
        return false;
      }
      if ($this.hasClass('clear')) {
        $write.val('');
        if ($write.attr("id") === "name") {
          $("#name").trigger('keydown');
        }
        return false;
      }
      if ($this.hasClass('symbol')) {
        character = $('span:visible', $this).html();
      }
      if ($this.hasClass('tab')) {
        character = '     ';
      }
      if ($this.hasClass('space')) {
        character = ' ';
      }
      if ($this.hasClass('uppercase')) {
        character = character.toUpperCase();
      }
      if (shift === true) {
        $('.symbol span').toggle();
        if (capslock === false) {
          $('.letter').toggleClass('uppercase');
        }
        shift = false;
      }
      $write.val($write.val() + character);
      if ($write.attr("id") === "name") {
        $("#name").trigger('keydown');
      }
    });
  });
};

run_numpad = function() {
  return $(function() {
	$write = $('.write');
    $('.numpad div').click( function(e) {
      var $this, character, input;
      $this = $(this);
      character = $this.html();
      if ($this.hasClass('delete')) {
        input = $write.val();
        $write.val(input.substr(0, input.length - 1));
        return false;
      }
      if ($this.hasClass('clear')) {
        $write.val('');
        return false;
      }
      $write.val($write.val() + character);
    });
  });
};