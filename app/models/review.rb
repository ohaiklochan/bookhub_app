class Review < ApplicationRecord
    belongs_to :reader
    belongs_to :book
    validate :one_review_per_reader_per_book
    validates_presence_of :rating, :title, :content

    def one_review_per_reader_per_book
        book_reviews = reader.reviews.select { |review| review.book_id == self.book_id }
        if book_reviews.size >= 2
            errors.add(:review_id, "cannot be created since you've already reviewed this book!")
        end
    end
end
