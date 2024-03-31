class ApplicationController < ActionController::Base
  include Pundit::Authorization

  protect_from_forgery prepend: true
  before_action :authenticate_user!
end