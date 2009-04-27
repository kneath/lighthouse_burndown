jQuery.fn.tokenForm = function(){
  return this.each(function(){
    var form = $(this);
    var loader = form.find('.loader');
    var message = form.find('.message');
    var state = 'check';
    
    var saveToken = function(){
      $.ajax({
        type: 'POST',
        url: '/tokens',
        data: form.serialize(),
        success: function(){
          loader.text('Token saved successfully!');
          message.text('Your token has been saved!').removeClass('error').addClass('success').show();
          setTimeout(function(){ loader.removeClass('success').hide() }, 2000);
          state = 'check';
        },
        error: function(){
          loader.text('Error saving token').addClass('error');
          message.text('Your token did not save properly. Please check your information and try again.').addClass('error');
          setTimeout(function(){ loader.removeClass('error').hide() }, 2000);
          state = 'check';
        }
      })
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