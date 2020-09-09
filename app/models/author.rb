class Author < ApplicationRecord
    has_many :books
    has_many :reviews
    belongs_to :readers
end
