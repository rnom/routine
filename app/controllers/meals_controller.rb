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
    @meals = Meal.where('created_at > ?', @n_day)
    @allmeals = Meal.all
    @sum_protein = @meals.sum(:protein).round(1)
    @sum_fat = @meals.sum(:fat).round(1)
    @sum_carb = @meals.sum(:carb).round(1)
    @sum_cal = @meals.sum(:cal).round(1)
    @tests = Meal.all
    @chart = {"Protein" => @sum_protein, "Fat" => @sum_fat, "Carb" => @sum_carb}
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
    @meals = Meal.where(created_at: @n_day.all_day)
    @allmeals = Meal.all
    @sum_protein = @meals.sum(:protein).round(1)
    @sum_fat = @meals.sum(:fat).round(1)
    @sum_carb = @meals.sum(:carb).round(1)
    @sum_cal = @meals.sum(:cal).round(1)
    @chart = {"Protein" => @sum_protein, "Fat" => @sum_fat, "Carb" => @sum_carb}
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
    @meals = Meal.where(created_at: @n_day.all_day)
    @allmeals = Meal.all
    @sum_protein = @meals.sum(:protein).round(1)
    @sum_fat = @meals.sum(:fat).round(1)
    @sum_carb = @meals.sum(:carb).round(1)
    @sum_cal = @meals.sum(:cal).round(1)
    @chart = {"Protein" => @sum_protein, "Fat" => @sum_fat, "Carb" => @sum_carb}
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_meal
      @meal = Meal.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def meal_params
      params.require(:meal).permit(:name, :protein, :fat, :carb, :cal, :start_time)
    end
end
