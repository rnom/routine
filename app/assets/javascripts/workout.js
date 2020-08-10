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
      weight = workout_data.weight;
      $("#workout_weight").val(weight);
      set = workout_data.set;
      $("#workout_set").val(set);
      bodypart = workout_data.bodypart;
      $("#workout_bodypart").val(bodypart);
      cal = workout_data.cal;
      $("#workout_cal").val(cal);
      $('#create_workout').prop('disabled', false);
    })
  });
});