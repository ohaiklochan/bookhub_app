class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?, :validate, :owned_by_user?, :email_clear, :current_review

  
  def current_user
      @current_user ||= User.find_by_id(session[:user_id])
  end

  def logged_in?
      !!current_user
  end


  def validate 
      unless @user.id == current_user.id 
          flash[:error] = "Restricted area."
          redirect_to reviews_path
      end
  end 

  def owned_by_user?(reviews) 
      if @review != nil 
          if current_user.id == @review.user_id
              return true 
          else 
              false 
          end
      end
  end


  def email_clear(email)
      username = email.split(/@gmail.com/)
      username[0]
  end

  def current_review
      @review = Review.find_by_id(params[:id])
  end

end