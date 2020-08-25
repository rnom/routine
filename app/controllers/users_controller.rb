class UsersController < ApplicationController

  def new
    @user = User.new
  end
  
  def create
    @user = User.new
    @user.save
  end

  def edit
  end

  def update
    if current_user.update(user_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def show
    @user = User.find(params[:id])
    @n_day = Date.today.beginning_of_week(:monday)

    @chart_cal = []
    @cal_target = []
    7.times do
      @meals = Meal.where(created_at: @n_day.all_day, user_id: current_user.id)
      @sum_cal = @meals.sum(:cal).round(0)
      array = [@n_day, @sum_cal]
      @chart_cal << array
      array = [@n_day, 1800]
      @cal_target << array
      @n_day += 1
    end
    
    @chart_protein = []
    @protein_target = []
    @n_day = Date.today.beginning_of_week(:monday)
    7.times do
      @meals = Meal.where(created_at: @n_day.all_day, user_id: current_user.id)
      @sum_protein = @meals.sum(:protein).round(0)
      array = [@n_day, @sum_protein]
      @chart_protein << array
      array = [@n_day, 150]
      @protein_target << array
      @n_day += 1
    end

    @chart_fat = []
    @fat_target = []
    @n_day = Date.today.beginning_of_week(:monday)
    7.times do
      @meals = Meal.where(created_at: @n_day.all_day, user_id: current_user.id)
      @sum_fat = @meals.sum(:fat).round(0)
      array = [@n_day, @sum_fat]
      @chart_fat << array
      array = [@n_day, 60]
      @fat_target << array
      @n_day += 1
    end

    @chart_carb = []
    @carb_target = []
    @n_day = Date.today.beginning_of_week(:monday)
    7.times do
      @meals = Meal.where(created_at: @n_day.all_day, user_id: current_user.id)
      @sum_carb = @meals.sum(:carb).round(0)
      array = [@n_day, @sum_carb]
      @chart_carb << array
      array = [@n_day, 90]
      @carb_target << array
      @n_day += 1
    end

    # @workouts = Workout.where(created_at: @n_day.all_day, user_id: current_user.id)
  end

  private

  def user_params
    params.require(:user).permit(:nickname, :email, :bodyweight, :height)
  end

end
