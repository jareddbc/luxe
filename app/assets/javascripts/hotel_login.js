$( document ).ready(function() {
  $('.hotelslogin').toggle() //toggling the login form to start hidden //
    $('.SignupButton').click(function() {
     $('.hotelsignup').toggle("slow") // toggling the signup form to hidden
    $('.hotelslogin').toggle("slow") // toggiling the login form to visible
    });
    $('.loginButton2').click(function() {
       $('.hotelsignup').toggle("slow") // toggling the signup form to visible
       $('.hotelslogin').toggle("slow") // toggling the login form to hidden
  });
});


