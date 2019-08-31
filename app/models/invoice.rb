class Invoice < ApplicationRecord
  
  belongs_to :company
  belongs_to :invoice_type
  belongs_to :person
  belongs_to :payment_type
  
  before_create :verify_pay
  validate :min_amount
  
  validates_presence_of :company, :amount, :due_date, :description, :invoice_type, :person
    
  def person_name
    person.try(:name)
  end
  
  def person_name=(name)
    self.person = Person.find_by(name: name) if name.present?
  end

  def verify_pay
    if self.create_paied
      self.person_paied = current_user.id
      self.pay_day = DateTime.now
      self.amount_paied = self.amount
    end
  end

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