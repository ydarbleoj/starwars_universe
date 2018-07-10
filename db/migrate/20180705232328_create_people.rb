class CreatePeople < ActiveRecord::Migration[5.2]
  def change
    create_table :people do |t|
      t.integer :person_id
      t.string :name
      t.string :birth_year
      t.string :eye_color
      t.string :gender
      t.string :hair_color
      t.string :height
      t.string :mass
      t.string :skin_color
      t.string :homeworld
      t.text :films, default: [], array: true
      t.text :species, default: [], array: true
      t.text :starships, default: [], array: true
      t.text :vehicles, default: [], array: true
      t.string :url
      t.string :created
      t.string :edited
      t.timestamps
    end
    add_index :people, :person_id
  end
end
