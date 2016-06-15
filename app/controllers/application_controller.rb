class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # request forgery protection and filtering of sensitive request parameters.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  # all rails controllers inherits from ApplicationController
  private

  def require_signin
    unless current_user
      # store intended_url in the session
      # assign value to session with url requested under the key intended_url
      session[:intended_url] = request.url
      redirect_to new_session_url, alert: "Please sign in first!"
    end
  end

  def current_user
    # call the find only if there is user_id in the session
    # checking if user_id is present in the session 
    if session[:user_id]
      if @current_user
        @current_user
      else
        # finding user from database using user_id assigning user to @current_user instance var
        @current_user = User.find(session[:user_id]) 
      end
    end
  end

  def current_user?(user)
    current_user == user 
  end
  
  # used helper method to be called from any view or layout
  helper_method :current_user
  helper_method :current_user?

  def require_admin
    unless current_user_admin?
      redirect_to root_url, alert: "Unauthorized access!"
    end
  end

  def current_user_admin?
    current_user && current_user.admin?
  end

  helper_method :current_user_admin?
end

