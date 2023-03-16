class Rental < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validate :book_is_not_already_rented
  

  private

  def book_is_not_already_rented
    if book.present? && book.rentals.where(returned_at: nil).any?
      errors.add(:book, "is already rented")
    end
  end
  
end
