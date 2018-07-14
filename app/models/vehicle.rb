class Vehicle < ApplicationRecord
  validates_presence_of :vehicle_id

  def show_attributes
    self.attributes.except('id', 'vehicle_id', 'created_at', 'updated_at')
  end
end
