class Product < ApplicationRecord
  belongs_to :company

  validates_presence_of :name, :quantity
  validates_numericality_of :quantity, :only_integer => true, :greater_than => 0


end
