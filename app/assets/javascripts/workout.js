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
      mets = workout_data.mets;
      $("#workout_mets").val(mets);
      time = workout_data.time;
      $("#workout_time").val(time);
      cal = workout_data.cal;
      $("#workout_cal").val(cal);
      $('#create_workout').prop('disabled', false);
    })
  });
});

function update_cal(){
  var cal = $('#workout_mets').val() * $('#workout_time').val() * 1.05 * gon.bodyweight;
  $('#workout_cal').val(cal).round(1);
}
$(function() {
$('input[type="number"]').on('keyup change', function() {
  update_cal();
});
});