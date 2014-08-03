class AddApprovedToIssues < ActiveRecord::Migration
  def change
    add_column :issues, :approved, :boolean, :default => false
  end
end
