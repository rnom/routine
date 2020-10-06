$(function() {
  $("#workout_menu").on("keyup", function() {
    var input = $("#workout_menu").val();
    $.ajax({
      type: 'GET',
      url: '/workouts/new',
      data: { menu: input },
      dataType: 'json'
    })
    .done(function(workout_data) {
      // mets = workout_data.mets;
      // $("#workout_mets").val(mets);
      time = workout_data.time;
      $("#workout_time").val(time);
      cal = workout_data.cal;
      $("#workout_cal").val(cal);
      $('#create_workout').prop('disabled', false);
    })
  });
});

function update_cal(){
  var selected_mets = document.getElementById("workout_mets");
  var mets = selected_mets.value;
  var cal = mets * $('#workout_time').val() * 1.05 * gon.bodyweight;
  $('#workout_cal').val(cal);
}
$(function() {
  $('.workout_table_formrow').on('keyup change', function() {
    update_cal();
  });
});



