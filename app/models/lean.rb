class Lean < ApplicationRecord
  belongs_to :company
  belongs_to :person
  belongs_to :product

  validates_presence_of :company, :person, :product


  def as_json(options={})    
    super(:only => [ :id, :person_id, :expected_return, :quantity, :created_at ],
          :include => {
            :product => {:only => [:id, :name]}
          }
    )
  end
end
