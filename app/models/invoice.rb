class Invoice < ApplicationRecord
  belongs_to :invoice_type
  belongs_to :person
  validate :min_amount
  
  validates_presence_of :amount, :due_date, :description, :invoice_type, :person
    
  def min_amount
    if amount.nil? || amount == 0
      errors.add(:amount, 'zerado não é permitido')
    end
  end

  def as_json(options={})    
    super(:only => [ :id, :due_date, :amount, :description ],
          :include => {
            :invoice_type => {:only => [:id, :description]}
          }
    )
  end

end