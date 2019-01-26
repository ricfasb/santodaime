class DriverLicense < ActiveRecord::Base    
    belongs_to :licensable, :polymorphic => true, optional: true
end
