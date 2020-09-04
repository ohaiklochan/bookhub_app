class ReadersController < ApplicationController
  def new
    @reader = Reader.new
  end

  def create
    @reader = Reader.new(reader_params)
    if @reader.save
      session[:reader_id] = @reader.id
      redirect_to books_path(@reader)
    else
      redirect_to new_reader_path
      flash[:error] = "Username is not available. Please try again"
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def index
  end

  def show
  end

  private

  def reader_params
    params.require(:reader).permit(:username, :password)
end
