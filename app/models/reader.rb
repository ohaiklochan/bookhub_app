class Reader < ApplicationRecord
    has_many :authors
    has_many :books, through: :authors

    has_secure_password

    validates :username, presence: true
    validates :username, uniqueness: {message: "Username is already in use."}

end
