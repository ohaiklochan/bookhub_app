class Author < ApplicationRecord
    has_many :books, through: :readers
    belongs_to :readers
    validates_presence_of :first_name, :last_name
  
    scope :find_by_first_name, -> (first_name) { where("first_name LIKE ?", first_name) }
    scope :find_by_last_name, -> (last_name) { where("last_name LIKE ?", last_name) }
  
    def full_name
        if self.last_name
            self.first_name + " " + self.last_name
        else
            self.first_name
        end
    end
end
