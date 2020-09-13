class SessionsController < ApplicationController

  def login
  end


  def create
    @user = User.find_by(username: params[:user][:username])

    if @user && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id 
      redirect_to reviews_path 
    else 
      flash[:error] = "User not found. Please login with the correct credentials."
      redirect_to login_path 
    end
  end

  def destroy 
    session.delete :user_id 
    redirect_to root_path 
  end

  def omniauth
    @user = User.find_or_create_by(uid: auth[:uid]) do |u|
      u.username = email_clear(auth[:info][:email])
      u.password = SecureRandom.hex
    end
    session[:user_id] = @user.id
    redirect_to reviews_path   
  end

  private
      
  def auth 
    request.env['omniauth.auth']
  end
end