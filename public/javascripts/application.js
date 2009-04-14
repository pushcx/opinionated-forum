$(function() {
  $("#meta a.new-topic, #topics a.new-topic").click(function(event) {
    $("#newtopic").slideToggle(0.8);
    event.preventDefault();
  });
});
