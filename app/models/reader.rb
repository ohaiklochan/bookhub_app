class Reader < ApplicationRecord
    has_many :books
    has_many :authors, through: :books

    has_secure_password

    # validates :username, presence: true
    # validates :username, uniqueness: {message: "Username is already in use."}

end
