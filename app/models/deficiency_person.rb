class DeficiencyPerson < ActiveRecord::Base
    belongs_to :deficiencable, :polymorphic => true, optional: true 
end
