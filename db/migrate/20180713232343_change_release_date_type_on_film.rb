class ChangeReleaseDateTypeOnFilm < ActiveRecord::Migration[5.2]
  def change
    change_column :films, :release_date, :string
  end
end
