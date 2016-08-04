class UsersController < ApplicationController
  def create
    @user = User.new(user_params)

    if @user.save
      render :show
    else
      flash[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def new
    @new_user = true
    render :new
  end

  def show
    @user = current_user
    render :show
  end


  private
  def user_params
    params.require(:user).permit(:email, :password)
  end
end
