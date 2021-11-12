class Api::V1::SessionsController < ApplicationController

  def new
    if logged_in?
      redirect_to home_path
    end
  end

  def create
    @user = User.find_by(email: user_params[:username])
    if @user && @user.authenticate(user_params[:password])
      payload = {user_id: @user.id}
      token = encode(payload)
      render json: {
        token: token,
        user: @user,
        login: true
      }
    else
      render json: {
        login: false
      }
    end
  end

  def token_authenticate
    token = request.headers["Authenticate"]
    user = User.find_by(id: decode(token)["user_id"])
    if user
      render json: {
        user: user,
        login: true
      }
    else
      render json: {login: false}      
    end
  end

  def destroy
    log_out
    redirect_to root_path
  end

  private
    def user_params
      params.require(:user).permit(:username, :password)
    end 
end
