class Starship < ApplicationRecord
  validates_presence_of :starship_id

  def show_attributes
    self.attributes.except('id', 'starship_id', 'created_at', 'updated_at')
  end
end
