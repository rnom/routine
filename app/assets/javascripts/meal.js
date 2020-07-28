$(function() {
  $("#meal_name").on("keyup", function() {
    var input = $("#meal_name").val();
    $.ajax({
      type: 'GET',
      url: '/meals/new',
      data: { name: input },
      dataType: 'json'
    })
    .done(function(meal_data) {
      protein = meal_data.protein;
      $("#meal_protein").val(protein);
      fat = meal_data.fat;
      $("#meal_fat").val(fat);
      carb = meal_data.carb;
      $("#meal_carb").val(carb);
      cal = meal_data.cal;
      $("#meal_cal").val(cal);
      $('#create_meal').prop('disabled', false);
    })
  });
});