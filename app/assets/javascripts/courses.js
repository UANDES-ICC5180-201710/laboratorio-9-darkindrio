// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
//
$(document).ready(function() {
  var $addPersonForm = $('#addPersonAndEnrollment form');

  var allInputs = $( ":button" );
  for(i =0 ; i< allInputs.length; i++){
    var currentValue = $(allInputs[i]).attr("value")
    if (currentValue == "true"){
      $(allInputs[i]).removeClass('like');
      $(allInputs[i]).addClass('like');
    }
    else if (currentValue == "false"){
      $(allInputs[i]).removeClass('like');
    }
  }
  

  $addPersonForm.on('ajax:success', function(e, data, status, xhr)  {
    var $newHtml = $(data);
    $addPersonForm.html($newHtml.find('form#new_person').html());
  }).on('ajax:error', function(e, xhr, status, error) {
    alert(error);
  });

});


function addLike(c_id){
  var course_id = c_id
  var buttonId = "#heart"+course_id
  $.ajax({
          type: "POST",
          dataType: "json",
          url: "/add_like",
          data: {
            course_id: course_id
          },
          success: function(json) {
            var state = json.state;
            var isLike = json.isLike
            if(state == "success"){
              if(isLike == "true"){
                $(buttonId).removeClass('like');
                $(buttonId).addClass('like');
              }
              else{
                $(buttonId).removeClass('like');
              }

            }
            else{
              alert("Error en algun parametro del formulario")
            }
            
          },
          error: function(json) {
              alert('error');
          }
      });
}