class UsersController < ApplicationController
  before_action :authenticate_user!

  def userpage
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:user][:id])
    if @user.update(user_params)
      redirect_to userpage_user_path(@user), notice: 'Profile updated successfully'
    else
      render :edit
    end
  end



  def user_params
    params.require(:user).permit(:id, :nickname, :avatar)
  end
end
