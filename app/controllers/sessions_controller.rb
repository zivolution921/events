class SessionsController < ApplicationController
  def new

  end

  def create
    # class method on user model
    #checking if the user was authenticated return true or false
    if user = User.authenticate(params[:email], params[:password])
      # session user_id
      # value to key is id of the user
      session[:user_id] = user.id
      flash[:notice] = "Welcome back, #{user.name}!"
      redirect_to user
    else
      # render the flash on the same request otherwise wait for another request
      flash[:alert] = "Invalid email/password combination!"
      render :new
    end
  end 

end
