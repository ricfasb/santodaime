class PaymentType < ApplicationRecord
    validates_presence_of :description
    
end
