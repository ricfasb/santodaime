class Invoice < ApplicationRecord
  belongs_to :invoice_type
  belongs_to :person

  validates_presence_of :amount, :due_date, :description, :invoice_type, :person
    
  def as_json(options={})    
    super(:only => [ :id, :due_date, :amount, :description ],
          :include => {
            :invoice_type => {:only => [:id, :description]}
          }
    )
  end

end