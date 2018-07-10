class CreateStarships < ActiveRecord::Migration[5.2]
  def change
    create_table :starships do |t|
      t.integer :starship_id
      t.string :model
      t.string :starship_class
      t.string :manufacturer
      t.string :cost_in_credits
      t.string :length
      t.string :crew
      t.string :passengers
      t.string :max_atmosphering_speed
      t.string :hyperdrive_rating
      t.string :mglt
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
