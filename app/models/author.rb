class Author < ApplicationRecord
    has_many :books
    has_many :readers, through: :books
end
