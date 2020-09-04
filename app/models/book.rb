class Book < ApplicationRecord
    belongs_to :reader
    belongs_to :authors
end
