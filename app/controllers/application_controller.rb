class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    @current_user ||= session[:user_id] && User.find_by_id(session[:user_id])
  end
  helper_method :current_user

  def authenticate_user!
    unless current_user
      redirect_to root_path, alert: "You must be logged in to perform that action."
    end
  end
  helper_method :authenticate_user!

  def api
    authenticate_user!
    @api ||= Soundcloud::API.new(current_user.token)
  end
  helper_method :api
end
