class Species < ApplicationRecord
  validates_presence_of :species_id

  def show_attributes
    self.attributes.except('id', 'species_id', 'created_at', 'updated_at')
  end
end
