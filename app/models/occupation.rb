class Occupation < ActiveRecord::Base
  has_one :address, as: :addressable, :dependent => :destroy
  
  belongs_to :occupatiable, :polymorphic => true, optional: true

  accepts_nested_attributes_for :address
end
