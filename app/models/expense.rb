class Expense < ApplicationRecord
  belongs_to :company

  validates_presence_of :description
  validate :min_amount

  def min_amount
    if amount.nil? || amount == 0
      errors.add(:amount, 'zerado não é permitido')
    end
  end

  def self.expenses_between_dates(date_ini, date_fin)
    where("COALESCE( expenses.date_expense, expenses.created_at) BETWEEN ? AND ?", date_ini, date_fin)    
  end

end
