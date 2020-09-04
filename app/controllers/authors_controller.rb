class AuthorsController < ApplicationController
  def new
    @authors = Author.new
  end

  def create
    @authors = Author.new(author_params)
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
end
