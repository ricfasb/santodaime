class CategoryTuition < ApplicationRecord
  belongs_to :category
  belongs_to :tuition
end
