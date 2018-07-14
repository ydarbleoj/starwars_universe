class Film < ApplicationRecord
  validates_presence_of :film_id


  def show_attributes
    self.attributes.except('id', 'film_id', 'created_at', 'updated_at')
  end
end
