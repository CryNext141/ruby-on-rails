class UsersController < ApplicationController
  before_action :authenticate_user!

  def userpage
    @user = User.find(params[:id])
  end
end
