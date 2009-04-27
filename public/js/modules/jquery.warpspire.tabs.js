jQuery.fn.tabs = function(){
  
  var getAnchor = function(str) {
    return /#([a-z][\w.:-]*)$/i.exec(str)[1];
  }
  
  return this.each(function(){
    var selectedLink = null;
    var selectedContainer = null;
    
    $(this).find('ul.tabs li a').each(function(){
      // Find & hide the container
      var container = $('#' + getAnchor(this.href));
      if (container == []) return;
      container.hide();
      
      // Setup the click handlers for the tab links
      $(this).click(function(){
        if (selectedContainer) selectedContainer.hide();
        if (selectedLink) selectedLink.removeClass('selected');
        
        selectedContainer = container.show();
        selectedLink = $(this).addClass('selected');
        return false;
      });
      
      if ($(this).hasClass('selected')) $(this).click();
    });
    
    // Show one tab by default
    if (selectedContainer == null) $($(this).find('ul.tabs li a')[0]).click();
  });
}