class CreateSpecies < ActiveRecord::Migration[5.2]
  def change
    create_table :species do |t|
      t.integer :species_id
      t.string :name
      t.string :classification
      t.string :designation
      t.string :average_height
      t.string :average_lifespan
      t.string :eye_colors
      t.string :hair_colors
      t.string :skin_colors
      t.string :language
      t.string :homeworld
      t.text :people, array: true, default: []
      t.text :films, array: true, default: []
      t.string :url
      t.string :created
      t.string :edited

      t.timestamps
    end
  end
end
