class RemoveGenreIdFromTitles < ActiveRecord::Migration
  def change
    remove_column :titles, :genre_id
  end
end
