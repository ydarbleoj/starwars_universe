class CreateVehicles < ActiveRecord::Migration[5.2]
  def change
    create_table :vehicles do |t|
      t.integer :vehicle_id
      t.string :name
      t.string :model
      t.string :vehicle_class
      t.string :manufacturer
      t.string :length
      t.string :cost_in_credits
      t.string :crew
      t.string :passengers
      t.string :max_atmosphere_speed
      t.string :cargo_capacity
      t.string :consumables
      t.text :films, array: true, default: []
      t.text :pilots, array: true, default: []
      t.string :url
      t.string :created
      t.string :edited

      t.timestamps
    end
  end
end
