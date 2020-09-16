class Review < ApplicationRecord
    validates :title, :description, :rating, :reviews, presence: true 
    belongs_to :user
    has_many :comments
    has_many :users, through: :comments 
    scope :alpha, -> { order(:title) }
    scope :find_by_title, -> (title) { where("title LIKE ?", title) }

    
  
    def self.deleted_user
        Review.all.each do |reviews|
            if reviews.user == nil 
                reviews.destroy
            end
        end
    end
  
  
    def self.ranked_reviews 
        reviews = Review.order("reviews DESC")
        return reviews 
    end

    def self.search(search)
        if search
            review = Review.find_by(title: search)
            if review
                self.where(review_id: review)
            else
                Review.all
            end
        else
            Review.all
        end
    end
  
  end
