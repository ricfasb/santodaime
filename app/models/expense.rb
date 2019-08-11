class Expense < ApplicationRecord
  belongs_to :company

  validates_presence_of :description
  validate :min_amount

  def min_amount
    if amount.nil? || amount == 0
      errors.add(:amount, 'zerado não é permitido')
    end
  end

end
