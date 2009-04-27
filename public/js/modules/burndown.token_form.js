jQuery.fn.tokenForm = function(){
  return this.each(function(){
    var form = $(this);
    var loader = form.find('.loader');
    var message = form.find('.message');
    var state = 'check';
    
    var saveToken = function(){
      return;
    }
    
    var checkToken = function(){
      $.ajax({
        type: 'POST',
        url: '/token_validity',
        data: form.serialize(),
        success: function(){
          loader.text('Saving token...');
          saveToken();
        },
        error: function(){
          loader.text('Invalid token!').addClass('error');
          message.text('Your token does not appear to be valid. Please make sure you\'ve entered the correct values.').addClass('error').show();
          setTimeout(function(){ loader.removeClass('error').hide() }, 2000);
          state = 'check';
        }
      });
    }
    
    form.submit(function(){
      if (state == 'requesting') return false;
      checkToken();
      loader.text('Checking token validity...').show();
      state = 'requesting';
      return false;
    })
  });
}