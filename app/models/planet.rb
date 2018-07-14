class Planet < ApplicationRecord
  validates_presence_of :planet_id

  def show_attributes
    self.attributes.except('id', 'planet_id', 'created_at', 'updated_at')
  end
end
