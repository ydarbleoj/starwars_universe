class Person < ApplicationRecord
  validates_presence_of :person_id


  def show_attributes
    self.attributes.except('id', 'person_id', 'created_at', 'updated_at')
  end
end
