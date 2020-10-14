class MealsController < ApplicationController
  before_action :set_meal, only: [:show, :edit, :update, :destroy]
  
  def index
    flash.discard(:notice)
    @meal = Meal.new
    @meal_data = Meal.find_by('name LIKE(?)', "%#{params[:name]}%")
    respond_to do |format|
      format.html
      format.json
    end

    @n_day = Date.today
    @@n_day = @n_day
    @meals = Meal.where(created_at: @n_day.all_day, user_id: current_user.id)
    @allmeals = Meal.all
    @sum_protein = @meals.sum(:protein).round(2)
    @sum_fat = @meals.sum(:fat).round(2)
    @sum_carb = @meals.sum(:carb).round(2)
    @sum_cal = @meals.sum(:cal).round(2)
    @chart = {"Protein" => @sum_protein, "Fat" => @sum_fat, "Carb" => @sum_carb}

    @workout = Workout.new
    @workouts = Workout.where(created_at: @n_day.all_day, user_id: current_user.id)
    @workout_cal = @workouts.sum(:cal).round(2)
    @tdee = current_user.tdee
    gon.bodyweight = current_user.bodyweight

    @target_fat = (current_user.tdee*0.25/9).round(2)
    @target_protein = (current_user.bodyweight*2).round(2)
    @target_carb = ((current_user.tdee-(@target_fat*9+@target_protein*4))/4).floor(0)

    @remaining_protein = (@target_protein-@sum_protein).round(2)
    @remaining_fat = (@target_fat-@sum_fat).round(2)
    @remaining_carb = (@target_carb-@sum_carb).round(2)
    @remaining_cal = (@tdee+@workout_cal-@sum_cal).round(2)

  end

  def show
  end

  def new
    @meal = Meal.new
    @meal_data = Meal.find_by('name LIKE(?)', "%#{params[:name]}%")
    respond_to do |format|
      format.html
      format.json
    end
  end

  def edit
  end

  def create
    @meal = Meal.new(meal_params)

    respond_to do |format|
      if @meal.save
        @meal.update!(start_time: @meal.updated_at)
        format.html { redirect_to meals_path }
        format.json { render :index, status: :created, location: @meal }
      else
        format.html { render :new }
        format.json { render json: @meal.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @meal.update(meal_params)
        format.html { redirect_to meals_path}
        format.json { render :show, status: :ok, location: @meal }
      else
        format.html { render :edit }
        format.json { render json: @meal.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @meal.destroy
    respond_to do |format|
      format.html { redirect_to meals_path}
      format.json { head :no_content }
    end
  end

  def next
    @meal = Meal.new
    @meal_data = Meal.find_by('name LIKE(?)', "%#{params[:name]}%")
    respond_to do |format|
      format.html
      format.json
    end
    @@n_day = @@n_day+1
    @n_day = @@n_day
    @meals = Meal.where(created_at: @n_day.all_day, user_id: current_user.id)
    @allmeals = Meal.all
    @sum_protein = @meals.sum(:protein).round(2)
    @sum_fat = @meals.sum(:fat).round(2)
    @sum_carb = @meals.sum(:carb).round(2)
    @sum_cal = @meals.sum(:cal).round(2)
    @chart = {"Protein" => @sum_protein, "Fat" => @sum_fat, "Carb" => @sum_carb}

    @workout = Workout.new
    @workouts = Workout.where(created_at: @n_day.all_day, user_id: current_user.id)
    @workout_cal = @workouts.sum(:cal).round(2)
    @tdee = current_user.tdee
    gon.bodyweight = current_user.bodyweight

    @target_fat = (current_user.tdee*0.25/9).round(2)
    @target_protein = current_user.bodyweight*2
    @target_carb = (current_user.tdee-(@target_fat*9+@target_protein*4))/4.round(2)

    @remaining_protein = (@target_protein-@sum_protein).round(2)
    @remaining_fat = (@target_fat-@sum_fat).round(2)
    @remaining_carb = (@target_carb-@sum_carb).round(2)
    @remaining_cal = (@tdee+@workout_cal-@sum_cal).round(2)
  end

  def previous
    @meal = Meal.new
    @meal_data = Meal.find_by('name LIKE(?)', "%#{params[:name]}%")
    respond_to do |format|
      format.html
      format.json
    end
    @@n_day = @@n_day-1
    @n_day = @@n_day
    @meals = Meal.where(created_at: @n_day.all_day, user_id: current_user.id)
    @allmeals = Meal.all
    @sum_protein = @meals.sum(:protein).round(2)
    @sum_fat = @meals.sum(:fat).round(2)
    @sum_carb = @meals.sum(:carb).round(2)
    @sum_cal = @meals.sum(:cal).round(2)
    @chart = {"Protein" => @sum_protein, "Fat" => @sum_fat, "Carb" => @sum_carb}

    @workout = Workout.new
    @workouts = Workout.where(created_at: @n_day.all_day, user_id: current_user.id)
    @workout_cal = @workouts.sum(:cal).round(2)
    @tdee = current_user.tdee
    gon.bodyweight = current_user.bodyweight

    @target_fat = (current_user.tdee*0.25/9).round(2)
    @target_protein = current_user.bodyweight*2
    @target_carb = (current_user.tdee-(@target_fat*9+@target_protein*4))/4.round(2)

    @remaining_protein = (@target_protein-@sum_protein).round(2)
    @remaining_fat = (@target_fat-@sum_fat).round(2)
    @remaining_carb = (@target_carb-@sum_carb).round(2)
    @remaining_cal = (@tdee+@workout_cal-@sum_cal).round(2)
  end

  def calendar
    @allmeals = Meal.where(user_id: current_user.id)
    @target_fat = (current_user.tdee*0.25/9).round(2)
    @target_protein = current_user.bodyweight*2
    @target_carb = (current_user.tdee-(@target_fat*9+@target_protein*4))/4.round(2)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_meal
      @meal = Meal.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def meal_params
      params.require(:meal).permit(:name, :protein, :fat, :carb, :cal, :start_time).merge(user_id: current_user.id)
    end
end
