class Api::V1::UserProfilesController < ApplicationController
  before_action :found_user_profile, only: [:edit, :update, :show, :destory]
  def update
    if @user_profile.update(params_user_profile)
      render json: {success: true}
    else
      render json: {errors: @user_profile.errors, success:false}
    end
  end
  def edit
    
  end
  
  private
    def found_user_profile
      @user_profile = UserProfile.find_by(id: params[:id])
      if @user_profile
        @user_profile
      else
        render json: {erros: "Not found User Profile"}
      end
    end

    def params_user_profile
      params.require(:user_profile).permit(:name, :date_of_birth, :phone, :address)
    end
end
