class CreateGenresTitlesJoinTable < ActiveRecord::Migration
  def change
    create_table :genres_titles, id: false do |t|
    t.integer :genre_id, null: false
    t.integer :title_id, null: false
  end
end
