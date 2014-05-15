class InitialMigration < ActiveRecord::Migration
  def change
    create_table :titles do |t|
      t.string :name
      t.integer :genre_id

      t.timestamps
    end

    create_table :issues do |t|
      t.integer :number
      t.string :cover
      t.integer :title_id

      t.timestamps
    end

    create_table :pages do |t|
      t.string :image
      t.integer :issue_id

      t.timestamps
    end

    create_table :genres do |t|
      t.string :name

      t.timestamps
    end
  end
end
