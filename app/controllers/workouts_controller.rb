class WorkoutsController < ApplicationController
  before_action :set_workout, only: [:show, :edit, :update, :destroy]

  def index
    @workouts = Workout.all
  end

  def show
  end

  def new
    @workout = Workout.new
    @workout_data = Workout.find_by('menu LIKE(?)', "%#{params[:menu]}%")
    respond_to do |format|
      format.html
      format.json
    end
  end

  def edit
  end

  def create
    @workout = Workout.new(workout_params)

    respond_to do |format|
      if @workout.save
        format.html { redirect_to meals_path, notice: 'Workout was successfully created.' }
        format.json { render :show, status: :created, location: @workout }
      else
        format.html { render :new }
        format.json { render json: @workout.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @workout.update(workout_params)
        format.html { redirect_to @workout, notice: 'Workout was successfully updated.' }
        format.json { render :show, status: :ok, location: @workout }
      else
        format.html { render :edit }
        format.json { render json: @workout.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @workout.destroy
    respond_to do |format|
      format.html { redirect_to workouts_url, notice: 'Workout was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def next
    @workout = Workout.new
    @workout_data = Workout.find_by('name LIKE(?)', "%#{params[:name]}%")
    respond_to do |format|
      format.html
      format.json
    end
    @@n_day = @@n_day+1
    @n_day = @@n_day
    @workouts = Workout.where(created_at: @n_day.all_day)
    @allworkouts = Workout.all
    # @sum_protein = @workouts.sum(:protein).round(1)
    # @sum_fat = @workouts.sum(:fat).round(1)
    # @sum_carb = @workouts.sum(:carb).round(1)
    # @sum_cal = @workouts.sum(:cal).round(1)
    # @chart = {"Protein" => @sum_protein, "Fat" => @sum_fat, "Carb" => @sum_carb}
  end

  def previous
    @workout = Workout.new
    @workout_data = Workout.find_by('name LIKE(?)', "%#{params[:name]}%")
    respond_to do |format|
      format.html
      format.json
    end
    @@n_day = @@n_day-1
    @n_day = @@n_day
    @workouts = Workout.where(created_at: @n_day.all_day)
    @allworkouts = Workout.all
    # @sum_protein = @workouts.sum(:protein).round(1)
    # @sum_fat = @workouts.sum(:fat).round(1)
    # @sum_carb = @workouts.sum(:carb).round(1)
    # @sum_cal = @workouts.sum(:cal).round(1)
    # @chart = {"Protein" => @sum_protein, "Fat" => @sum_fat, "Carb" => @sum_carb}
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_workout
      @workout = Workout.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def workout_params
      params.require(:workout).permit(:menu, :weight, :set, :bodypart, :cal, :user_id)
    end
end
