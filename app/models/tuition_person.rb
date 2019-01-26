class TuitionPerson < ApplicationRecord  
  extend Enumerize

  enumerize :status_payment, in: [:pending, :paid]

  belongs_to :person
  belongs_to :tuition
  
  def as_json(options={})
    #super(:only => [ ApplicationController.helpers.format_date(:due_date) ],
    super(:only => [ :due_date ],
          :include => {
            :tuition => {:only => [:id, :amount]},
            :person => {:only => [:id]}
          }
    )
  end

end
