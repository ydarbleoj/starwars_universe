class CreatePlanets < ActiveRecord::Migration[5.2]
  def change
    create_table :planets do |t|
      t.integer :planet_id
      t.string :name
      t.string :diameter
      t.string :rotation_period
      t.string :orbital_period
      t.string :gravity
      t.string :population
      t.string :climate
      t.string :terrain
      t.string :surface_water
      t.text :residents, array: true, default: []
      t.text :films, array: true, default: []
      t.string :url
      t.string :created
      t.string :edited

      t.timestamps
    end
  end
end
