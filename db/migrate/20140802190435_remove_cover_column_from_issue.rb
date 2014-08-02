class RemoveCoverColumnFromIssue < ActiveRecord::Migration
  def change
    remove_column :issues, :cover
  end
end
