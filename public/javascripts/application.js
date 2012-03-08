jQuery.ajaxSetup({ 
  'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")}
})
jQuery.fn.submitWithAjax = function() {
  this.submit(function() {
    $.post(this.action, $(this).serialize(), null, "script");
    return false;
  })
  return this;
};
$(document).ready(function() {
  $("#new_player").submitWithAjax();
  $("#new_game").submitWithAjax();

  $('#add_games').click(function() {
    $('#add_games_form').toggle('slow');
    return false;
  });

  $('#add_players').click(function() {
    $('#add_players_form').toggle('slow');
    return false;
  });

  $('.question').click(function() {
    $(this).children().toggle();
  });
})