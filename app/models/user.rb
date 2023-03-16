class User < ApplicationRecord
    has_secure_password
    has_many :rents

    validates :email, presence: true, uniqueness: true
end
