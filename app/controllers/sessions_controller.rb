class SessionsController < ApplicationController
  def new

  end

  def create
    # class method on user model
    #checking if the user was authenticated return true or false
    if user = User.authenticate(params[:email], params[:password])
      # session user_id
      # value to key is id of the user object
      session[:user_id] = user.id
      flash[:notice] = "Welcome back, #{user.name}!"
      # read the value of intended_url in the session hash
      # if have intended_url will redirect otherwise redirect to user profile
      redirect_to(session[:intended_url] || user)
      session[:intended_url] = nil
    else
      # render the flash on the same request otherwise wait for another request
      flash[:alert] = "Invalid email/password combination!"
      render :new
    end
  end

  def facebook
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    redirect_to user
  end

  # delete user_id from session hash
  def destroy
    # assign value of nil which remove key user_id from the session
    session[:user_id] = nil
    redirect_to root_url, notice: "You're now signed out!"
  end

end
