$(function() {
  // Start topic/cancel links
  $("#meta a.new-topic, #topics a.new-topic").click(function(event) {
    $("#newtopic").slideToggle(0.8);
    event.preventDefault();
  });

  // Live post preview
  $('.reply .preview').html( "foo");
  $('.reply').keyup(function() {
    $('.reply .preview').html( $('.reply textarea').val().replace("\n", "<br>") );
  });
});
