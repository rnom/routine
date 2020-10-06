class MealsController < ApplicationController
  before_action :set_meal, only: [:show, :edit, :update, :destroy]
  
  def index
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
    @sum_protein = @meals.sum(:protein).floor(1)
    @sum_fat = @meals.sum(:fat).floor(1)
    @sum_carb = @meals.sum(:carb).floor(1)
    @sum_cal = @meals.sum(:cal).floor(1)
    @chart = {"Protein" => @sum_protein, "Fat" => @sum_fat, "Carb" => @sum_carb}

    @workout = Workout.new
    @workouts = Workout.where(created_at: @n_day.all_day, user_id: current_user.id)
    @workout_cal = @workouts.sum(:cal).floor(1)
    @tdee = current_user.tdee
    gon.bodyweight = current_user.bodyweight

    @target_fat = (current_user.tdee*0.25/9).floor(1)
    @target_protein = (current_user.bodyweight*2).floor(1)
    @target_carb = ((current_user.tdee-(@target_fat*9+@target_protein*4))/4).floor(0)

    @remaining_protein = (@target_protein-@sum_protein).floor(1)
    @remaining_fat = (@target_fat-@sum_fat).floor(1)
    @remaining_carb = (@target_carb-@sum_carb).floor(1)
    @remaining_cal = (@tdee+@workout_cal-@sum_cal).floor(1)

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
        format.html { redirect_to @meal, notice: 'Meal was successfully updated.' }
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
      format.html { redirect_to meals_url, notice: 'Meal was successfully destroyed.' }
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
    @sum_protein = @meals.sum(:protein).floor(1)
    @sum_fat = @meals.sum(:fat).floor(1)
    @sum_carb = @meals.sum(:carb).floor(1)
    @sum_cal = @meals.sum(:cal).floor(1)
    @chart = {"Protein" => @sum_protein, "Fat" => @sum_fat, "Carb" => @sum_carb}

    @workout = Workout.new
    @workouts = Workout.where(created_at: @n_day.all_day, user_id: current_user.id)
    @workout_cal = @workouts.sum(:cal).floor(1)
    @tdee = current_user.tdee
    gon.bodyweight = current_user.bodyweight

    @target_fat = (current_user.tdee*0.25/9).floor(1)
    @target_protein = current_user.bodyweight*2
    @target_carb = (current_user.tdee-(@target_fat*9+@target_protein*4))/4.floor(1)

    @remaining_protein = (@target_protein-@sum_protein).floor(1)
    @remaining_fat = (@target_fat-@sum_fat).floor(1)
    @remaining_carb = (@target_carb-@sum_carb).floor(1)
    @remaining_cal = (@tdee+@workout_cal-@sum_cal).floor(1)
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
    @sum_protein = @meals.sum(:protein).floor(1)
    @sum_fat = @meals.sum(:fat).floor(1)
    @sum_carb = @meals.sum(:carb).floor(1)
    @sum_cal = @meals.sum(:cal).floor(1)
    @chart = {"Protein" => @sum_protein, "Fat" => @sum_fat, "Carb" => @sum_carb}

    @workout = Workout.new
    @workouts = Workout.where(created_at: @n_day.all_day, user_id: current_user.id)
    @workout_cal = @workouts.sum(:cal).floor(1)
    @tdee = current_user.tdee
    gon.bodyweight = current_user.bodyweight

    @target_fat = (current_user.tdee*0.25/9).floor(1)
    @target_protein = current_user.bodyweight*2
    @target_carb = (current_user.tdee-(@target_fat*9+@target_protein*4))/4.floor(1)

    @remaining_protein = (@target_protein-@sum_protein).floor(1)
    @remaining_fat = (@target_fat-@sum_fat).floor(1)
    @remaining_carb = (@target_carb-@sum_carb).floor(1)
    @remaining_cal = (@tdee+@workout_cal-@sum_cal).floor(1)
  end

  def calendar
    # @allmeals = Meal.all
    @allmeals = Meal.where(user_id: current_user.id)
    @target_fat = (current_user.tdee*0.25/9).floor(1)
    @target_protein = current_user.bodyweight*2
    @target_carb = (current_user.tdee-(@target_fat*9+@target_protein*4))/4.floor(1)
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
