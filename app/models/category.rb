class Category < ActiveRecord::Base
    validates_presence_of :description
    validates_uniqueness_of :id
    
    has_many :category_tuitions, :dependent => :destroy
    accepts_nested_attributes_for :category_tuitions, allow_destroy: true
    
end
