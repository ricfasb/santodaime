class TuitionPerson < ApplicationRecord  
  extend Enumerize

  enumerize :status_payment, in: [:pending, :paid, :cancelled]

  belongs_to :person
  belongs_to :tuition
  
  def as_json(options={})
    #super(:only => [ ApplicationController.helpers.format_date(:due_date) ],
    super(:only => [ :id, :due_date, :amount ],
          :include => {
            :tuition => {:only => [:id, :description, :amount]},
            :person => {:only => [:id]}
          }
    )
  end

end
