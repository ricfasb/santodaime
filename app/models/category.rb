class Category < ActiveRecord::Base
    validates_presence_of :description
    validates_uniqueness_of :id

    validate :generates_tuition

    def generates_tuition        
        if insert_tuition && tuition_id.nil?
            errors.add(:insert_tuition, 'Selecione a mensalidade')
        end
    end

end
