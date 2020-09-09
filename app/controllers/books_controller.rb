class BooksController < ApplicationController
  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.reader_id = session[:reader_id]
    if @book.valid?
      @book.save
      redirect_to book_path(@book)
    else
      redirect_to new_book_path
    end
  end

  def edit
    unless @journey.reader_id == current_reader.id
      flash[:error] = "Only the reader who created this can edit or delete this!"
      redirect_to books_path
    end
  end

  def update
    if @book.update(book_params)
      redirect_to book_path(@book)
    else
      redirect_to edit_book_path
    end
  end

  def destroy
    if current_user
      @book.destroy
      redirect_to book_path
    end
  end

  def index
    @books = Book.all
  end

  def show
  end

  private

  def book_params
    params.require(:book).permit(:title, :genre, :description)
  end
end
