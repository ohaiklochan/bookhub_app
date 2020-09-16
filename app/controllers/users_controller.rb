class UsersController < ApplicationController

  before_action :find_user, only: [:show, :edit, :update, :destroy]

  
  def new
    @user = User.new
  end

  def create 
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id 
      redirect_to reviews_path(@user)
    else 
      redirect_to new_user_path
      flash[:error] = "Username is not available, please use a unique username."
      # visit error message display & requirements
    end
  end
  
  def show
    validate
  end
  
  def edit
    validate 
  end

  def update
    if @user.valid?
      @user.update(username: params[:user][:username])
      redirect_to user_path(@user)
    else 
      redirect_to edit_user_path 
    end
  end

  def destroy 
    @user.destroy 
    redirect_to root_path 
    flash[:error] = "Account deleted."
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end

  def find_user 
    @user = User.find_by_id(params[:id])
  end

end
