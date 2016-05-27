class UsersController < ApplicationController
  # will run before every action in the controller
  # before_action method excecuted from top to buttom if one is false that the rest dont run
  before_action :require_signin, except: [:new, :create]
  before_action :require_current_user, only: [:edit, :update, :destroy]
  
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to @user, notice: "Thanks for signing up!"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: "Account successfully updated!"
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    # logout the user_id to nil
    session[:user_id] = nil
    redirect_to root_url, alert: "Account successfully deleted!"
  end

  private

  def require_current_user
    # user identified by the params id lookup for the user 
    @user = User.find(params[:id])
    # unless the current_user is the same as the user that is manipulated
    unless current_user?(@user)
      redirect_to root_url
    end
  end

  def user_params
    # permitted list that can be mass assigned from a form
    # return hash of permitted parameters
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
