class ReadersController < ApplicationController

  def new
    @reader = Reader.new
  end

  def create
    @reader = Reader.new(reader_params)
    if @reader.save
      session[:reader_id] = @reader.id
      redirect_to user_path(@reader)
    else
      render :new
    end
  end

  def show
    redirect_if_not_logged_in
    @reviews = Review.newest_to_oldest.first(10)
  end

  private

    def reader_params
      params.require(@reader).permit(:username, :email, :password, :admin)
    end

end
