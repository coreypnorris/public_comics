class AddOriginalBodyToComment < ActiveRecord::Migration
  def change
    add_column :comments, :original_body, :string
  end
end
