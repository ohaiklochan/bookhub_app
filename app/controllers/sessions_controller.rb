class SessionsController < ApplicationController
  before_action :redirect_if_logged_in, except: :destroy

  def new
  end

  def create
    reader = Reader.find_by(:username => params[:reader][:username])
    if reader && reader.authenticate(params[:reader][:password])
      session[:reader_id] = reader.id
      redirect_to reader_path(reader)
    else
      @error = "Incorrect username or password."
      render :new
    end
  end

  def omnilogin
    @reader = Reader.from_omniauth(auth)
    if @reader.save
      session[:reader_id] = @reader.id
      redirect_to reader_path(@reader)
    else
      flash[:error] = "That email already exists. Please login or sign up with a different email address."
      redirect_to login_path
    end
  end

  def destroy
    session.clear
    redirect_to root_path
  end

  private

    def auth
      request.env["omniauth.auth"]
    end
end
