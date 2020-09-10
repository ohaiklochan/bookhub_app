class ReviewsController < ApplicationController
  helper_method :current_review
  before_action :current_review, only: [:show, :edit, :update, :destroy]
  before_action :set_books_array, only: [:new, :create]

  def index
    set_reviews_array
  end

  def new
    if params[:book_id] && @book = Book.find_by_id(params[:book_id])
      @review = @book.reviews.build
    else
      @error = "That book doesn't exist." if params[:book_id]
      @review = Review.new
    end
  end

  def create
    @review = current_reader.reviews.build(review_params)
    if @review.save
      redirect_to review_path(@review)
    else
      render :new
    end
  end

  def show
  end

  def edit
    if current_reader.id == current_review.reader.id
      render :edit
    else
      redirect_to reviews_path
    end
  end

  def update
    if current_review.update(review_params)
      redirect_to review_path(current_review)
      flash[:message] = "Review successfully updated."
    else
      render :edit
    end
  end

  def destroy
    if current_reader.id == current_review.reader.id
      current_review.delete
      flash[:message] = "Review successfully deleted."
    end
    redirect_to reviews_path
  end

  private
    def review_params
      params.require(:review).permit(:title, :description :book_id)
    end

    def current_review
      review = Review.find_by_id(params[:id])
    end

    def set_books_array
      @books = Book.alpha
    end

    def set_reviews_array
      if params[:reader_id] && current_reader.id.to_s == params[:reader_id]
        @reviews = current_reader.reviews.newest_to_oldest
      elsif params[:reader_id] && @user = Reader.find_by_id(params[:reader_id])
        @reviews = @user.reviews.newest_to_oldest
      elsif params[:book_id] && @book = Book.find_by_id(params[:book_id])
        @reviews = @book.reviews.newest_to_oldest
      else
        @error = "That book doesn't exist." if params[:book_id]
        @error = "That user doesn't exist." if params[:reader_id]
        @reviews = Review.all.newest_to_oldest
      end
    end

end
