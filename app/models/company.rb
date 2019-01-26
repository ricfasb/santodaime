class Company < ActiveRecord::Base
  has_one :address, as: :addressable

  accepts_nested_attributes_for :address

  validates_presence_of :name

  def complete_address
    addr = "#{address.street}" unless address.street.nil?
    addr = addr + ", #{address.number}" unless address.number.blank?
    addr = addr + " - #{address.neighbourhood}" unless address.neighbourhood.blank?
    addr
  end
  
end
