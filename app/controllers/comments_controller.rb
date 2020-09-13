class CommentsController < ApplicationController
  before_action :logged_in?

  def new
      @comment = Comment.new 
      @review = Review.find_by_id(params[:review_id])
  end

  def create 
      @comment = Comment.new(content: params[:comment][:content], user_id: current_user.id, review_id: params[:review_id])
      if @comment.save
          redirect_to review_comments_path(@comment.review_id)
      end 
  end

  def show 
      @comment = Comment.find_by_id(params[:review_id][:comment])
  end


  def index
      if params[:review_id] && review = Review.find_by(id: params[:review_id]) 
          @comments = review.comments.most_recent 
      else
          @comments = Comment.all
      end
  end
end
