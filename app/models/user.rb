class User < ApplicationRecord

    has_many :reviews  
    has_many :comments
    has_many :commented_reviews, through: :comments, source: :review 

    has_secure_password 

    validates :username, presence: true 
    validates :username, uniqueness: {message: "Username already in use, please try again." }
end
