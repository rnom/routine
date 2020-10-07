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
      time = workout_data.time;
      $("#workout_time").val(time);
      cal = workout_data.cal;
      $("#workout_cal").val(cal);
      $('#create_workout').prop('disabled', false);
    })
  });
});

function auto_cal(){
  var selected_mets = document.getElementById("workout_mets");
  var mets = selected_mets.value;
  var cal = mets * $('#workout_time').val() * 1.05 * gon.bodyweight;
  var cal_round = Math.round(cal)
  $('#workout_cal').val(cal_round);
}
$(function() {
  $('.workout_table_formrow').on('keyup change', function() {
    auto_cal();
  });
});
$(function() {
  $('.workouts_update_box').on('keyup change', function() {
    auto_cal();
  });
});





