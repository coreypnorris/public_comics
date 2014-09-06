class RemoveHasManyAndBelongsTo < ActiveRecord::Migration
  def change
    drop_table :genres_titles
    add_column :titles, :genre_id, :integer
  end
end
