class Book < ApplicationRecord
    belongs_to :reader
    belongs_to :authors
    has_many :reviews
    has_many :readers, through: :reviews
    validates_presence_of :title, :genre, :description
  
    scope :find_by_title, -> (title) { where("title LIKE ?", title) }
    scope :alpha, -> { order(:title) }
  
    def authors_attributes=(authors_attributes)
        authors_attributes.values.each do |author_attributes|
            if !author_attributes[:first_name].blank?
                author = Author.find_or_create_by(author_attributes)
                if !self.author_ids.include?(author.id)
                    self.authors << author
                end
            end
        end
    end
  
    def average_rating
        self.reviews.average(:rating).round(1) if self.reviews.size > 0
    end
  
    def author_number
        author_number = 8 - self.authors.size
        author_number.times { self.authors.build }
    end

end
