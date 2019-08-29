class City < ActiveRecord::Base
  belongs_to :state

  def self.cities_by_state(state)
    joins("INNER JOIN states ON cities.state_id = states.id").where("states.uf = ?", state)
  end
end
