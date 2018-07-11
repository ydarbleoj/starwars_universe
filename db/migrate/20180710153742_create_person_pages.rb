class CreatePersonPages < ActiveRecord::Migration[5.2]
  def change
    create_table :page_caches do |t|
      t.string :url
      t.string :previous
      t.string :next
      t.text :ids, array: true, default: []

      t.timestamps
    end
    add_index :page_caches, :url
  end
end
