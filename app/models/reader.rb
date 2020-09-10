class Reader < ApplicationRecord
    has_many :authors
    has_many :reviews
    has_many :books, through: :authors
    has_secure_password
    validates_presence_of :username, :email
    validates :username, :email, :uniqueness => true
  
    def self.from_omniauth(auth)
        @reader = Reader.find_or_create_by(:uid => auth[:uid]) do |reader|
            if !Reader.find_by(:username => auth[:info][:first_name])
                reader.username = auth[:info][:first_name]
            else
                reader.username = auth[:info][:first_name] + auth[:uid]
            end
            reader.email = auth[:info][:email]
            reader.password = SecureRandom.hex
        end
    end
end
