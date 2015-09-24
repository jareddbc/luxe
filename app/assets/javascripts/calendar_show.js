
$( document ).ready(function() {
  $('.calendar').toggle()
    $('.calendar_button').click(function() {
      $('.calendar').toggle("slow")
      console.log("clicked")
      // $(".hidden").removeClass('hidden');
    });
});