class ReviewsController < ApplicationController
  before_action :logged_in? 
  before_action :current_review, only: [:show, :edit, :update, :destroy] 

  def index
    if params[:title]
        @reviews = Review.find_by_title(params[:title])
    else
        @reviews = Review.order(sort_column + " ")
    end
    #   @review = Review.find_by_id(params[:id])
  end

  def new
      @review = Review.new 
  end

  def create
      @review = Review.new(review_params)
      @review.user_id = session[:user_id]
      if @review.valid?
          @review.save 
          redirect_to review_path(@review)
      else 
          redirect_to new_review_path 
      end
  end

  def show
  end

  def edit
      unless @review.user_id == current_user.id
          flash[:error] = "You cannot edit or delete this because you did not create it!"
          redirect_to reviews_path
      end
  end

    def update
        if @review.update(review_params)
            redirect_to review_path(@review)
        else 
            redirect_to edit_review_path 
        end
    end

    def destroy
        if current_user 
            @review.destroy 
            redirect_to reviews_path
        end
    end

    # def search
    #     @reviews = Review.search(params[:search])
    #     redirect_to search_review_path
    # end

  private

  def sort_column
    Review.order(:title).include?(params[:sort]) ? params[:sort] : "title"
  end

  def review_params
      params.require(:review).permit(:title, :description, :rating, :reviews, :search)
  end


end