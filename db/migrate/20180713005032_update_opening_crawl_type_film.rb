class UpdateOpeningCrawlTypeFilm < ActiveRecord::Migration[5.2]
  def change
    change_column :films, :opening_crawl, :text
  end
end
