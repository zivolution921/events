class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def require_signin
    unless current_user
      redirect_to new_session_url, alert: "Please sign in first!"
    end
  end

  def current_user
    # call the find only if there is something in the session
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  # used helper method to be called from any view or layout
  helper_method :current_user
end

