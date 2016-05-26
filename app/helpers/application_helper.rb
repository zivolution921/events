module ApplicationHelper
  def current_user
    # call the find only if there is something in the session
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
