class SessionsController < ApplicationController
  def create
    @user = User.find_by_credentials(session_params[:email],
      session_params[:password])

    if @user
      log_in_user!(@user)
      redirect_to user_url(@user)
    else
      flash[:errors] = ["email or password incorrect"]
      render :new
    end

  end

  def new
    # flash.now[:errors] = []
    @new_user = false
    render :new
  end

  def destroy
    if current_user
      current_user.reset_session_token!
      session[:session_token] = nil
    end
    redirect_to new_session_url
  end

  private
  def session_params
    params.require(:session).permit(:email, :password)
  end
end
