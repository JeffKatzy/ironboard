class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include ApplicationHelper
  
  protect_from_forgery with: :exception

  helper_method :current_user, :user_signed_in?, :user_authorized, :permission_to_edit?

  def root
    @events = Event.upcoming.sort_by_day
  	render 'layouts/index'
  end

  private

  def current_user 
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end 

  def user_signed_in?
    session[:user_id]
  end

  def user_authorized
    if !user_signed_in?
      redirect_to root_path, notice: "Login or sign up first!"
    end

  end	

end
