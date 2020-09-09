class ReadersController < ApplicationController
  before_action :find_reader, only: [:show, :edit, :update, :destroy]

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
    validate
  end

  def update
    if @reader.valid?
      @reader.update(reader: params[:reader][:username])
      redirect_to reader_path(@reader)
    else 
      redirect_to edit_reader_path 
    end
  end

  def destroy
    @reader.destroy 
    redirect_to root_path 
    flash[:error] = "Account deleted."
  end

  def show
    validate
  end

  private

  def reader_params
    params.require(:reader).permit(:username, :password)
  end

  def find_reader
    @reader = Reader.find_by_id(params[:id])
  end
end
