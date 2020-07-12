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

  private

  def user_params
    params.require(:user).permit(:nickname, :email, :bodyweight, :height)
  end

end
