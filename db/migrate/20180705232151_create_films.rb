class CreateFilms < ActiveRecord::Migration[5.2]
  def change
    create_table :films do |t|
      t.integer :film_id
      t.string :title
      t.integer :episode_id
      t.string :opening_crawl
      t.string :director
      t.string :producer
      t.date :release_date
      t.text :species, array: true, default: []
      t.text :starships, array: true, default: []
      t.text :vehicles, array: true, default: []
      t.text :characters, array: true, default: []
      t.text :planets, array: true, default: []
      t.string :url
      t.string :created
      t.string :edited

      t.timestamps
    end
  end
end
