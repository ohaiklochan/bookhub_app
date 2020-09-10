class BooksController < ApplicationController
  helper_method :sort_column
  before_action :redirect_if_not_admin, only: [:new, :create, :edit, :update]

  def index
    set_books_array
  end

  def new
    @book = Book.new
    @book.author_number
  end

  def create
    @book = current_user.books.build(book_params)
    if @book.save
      redirect_to book_path(@book)
    else
      @book.author_number
      render :new
    end
  end

  def show
    @book = Book.find_by_id(params[:id])
  end

  def edit
    @book = Book.find_by_id(params[:id])
    @book.author_number
  end

  def update
    @book = Book.find_by_id(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book)
      flash[:message] = "Book successfully updated."
    else
      @book.author_number
      render :edit
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :genre, :description, :authors_attributes => [:first_name, :last_name])
  end

  def sort_column
    Book.column_names.include?(params[:sort]) ? params[:sort] : "title"
  end

  def set_books_array
    if params[:title]
      @books = Book.find_by_title(params[:title])
    elsif params[:author_id] && @author = Author.find_by_id(params[:author_id])
      @books = @author.books.order(sort_column + " " + sort_direction)
    else
      @books = Book.order(sort_column + " " + sort_direction)
    end
  end
end
