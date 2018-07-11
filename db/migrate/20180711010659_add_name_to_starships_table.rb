class AddNameToStarshipsTable < ActiveRecord::Migration[5.2]
  def change
    add_column :starships, :name, :string
    add_index :starships, :starship_id
  end
end
