class Book < ApplicationRecord
    has_many :rentals
    belongs_to :author
end
