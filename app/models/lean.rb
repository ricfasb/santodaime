class Lean < ApplicationRecord
  belongs_to :company
  belongs_to :person
  belongs_to :product

  validates_presence_of :company, :person, :product
end
