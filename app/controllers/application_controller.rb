class ApplicationController < ActionController::Base
  protect_from_forgery
  before_action :user_signed_in?
  before_action :current_user
  before_action :authenticate_user!
end
