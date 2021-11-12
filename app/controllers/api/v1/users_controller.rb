class Api::V1::UsersController < ApplicationController
  before_action :found_user, only: [:edit, :update, :show, :destroy]
  def index
    @users = User.all.paginate(page: params[:page])
    @total = User.all.count
    render json: {lists: @users, totalUser: @total}
  end

  def def new
    @user = User.new
    @user_profile = @user.new
    render json: {user: @user, user_profile: @user_profile}
  end
  

  def show
    @user_profile = @user.user_profile
    render json: {user: @user, user_profile: @user_profile}
  end
  

  def create
    @user = User.new(user_params)
    if @user.save
      @user.create_user_profile(name: params[:full_name])
      payload = {user_id: @user.id}
      token = encode(payload)
      render json: {
        token: token,
        user: @user,
        success: true
      }
    else
      render json: {errors: @user.errors, success: false}
    end
  end

  def update
    if @user.update(user_params)
      render json: {success: true, user: @user}
    else
      render json: {errors: @user.errors, success: false}
    end
  end

  def destroy
    if @user.status == 1
      if @user.update(status: 0)
        render json: {success: true}
      else
        render json: {success: false}
      end
    else
      if @user.update(status: 1)
        render json: {user: @user, success: true}
      else
        render json: {success: false}
      end
    end
  end
  

  private
    def user_params
      params.require(:user).permit(:username, :email, :role, :password, :password_confirmation)
    end
    
    def found_user
      @user = User.find_by(id: params[:id])
      if @user
        @user
      else
        render json: {error: "Not found user"}
      end
    end
end
