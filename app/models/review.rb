class Review < ApplicationRecord
    validates :title, :description, :rating, :reviews, presence: true 
    belongs_to :user
    has_many :comments
    has_many :users, through: :comments 
    
  
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
  
  end
