$(document).ready(function(){
  $('table.timeline').timelineGraph();
  $('.tab-group').tabs();
  $('#token_form').tokenForm();
  
  var body_id = document.body.id;
  switch(body_id){
    case "home" :
      $('ul#nav li.home a').addClass('selected');
      break;
    case "setup" :
      $('ul#nav li.setup a').addClass('selected');
      break;
   default:
      $('ul#nav li.default a').addClass('selected');
  }
});