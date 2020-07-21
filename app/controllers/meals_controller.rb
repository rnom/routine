class MealsController < ApplicationController
  before_action :set_meal, only: [:show, :edit, :update, :destroy]

  # GET /meals
  # GET /meals.json
  def index
    # @meals = Meal.all.group_by{|m| m.created_at.strftime('%Y%m%d') }
    # @meals = Meal.group("date(created_at)")
    @meals = Meal.where('created_at > ?', 9.hour.ago)
    @sum_protein = @meals.sum(:protein).round(1)
    @sum_fat = @meals.sum(:fat).round(1)
    @sum_carb = @meals.sum(:carb).round(1)
    @sum_cal = @meals.sum(:cal).round(1)
    @day = Date.today
    @chart = {"Protein" => @sum_protein, "Fat" => @sum_fat, "Carb" => @sum_carb}
    @meal = Meal.new
  end

  # GET /meals/1
  # GET /meals/1.json
  def show
  end

  # GET /meals/new
  def new
    @meal = Meal.new
    @meal_data = Meal.find_by('name LIKE(?)', "%#{params[:name]}%")
    # binding.pry
    respond_to do |format|
      format.html
      format.json
    end
  end

  # GET /meals/1/edit
  def edit
  end

  # POST /meals
  # POST /meals.json
  def create
    @meal = Meal.new(meal_params)

    respond_to do |format|
      if @meal.save
        format.html { redirect_to @meal, notice: 'Meal was successfully created.' }
        format.json { render :show, status: :created, location: @meal }
      else
        format.html { render :new }
        format.json { render json: @meal.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /meals/1
  # PATCH/PUT /meals/1.json
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

  # DELETE /meals/1
  # DELETE /meals/1.json
  def destroy
    @meal.destroy
    respond_to do |format|
      format.html { redirect_to meals_url, notice: 'Meal was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_meal
      @meal = Meal.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def meal_params
      params.require(:meal).permit(:name, :protein, :fat, :carb, :cal)
    end
end
