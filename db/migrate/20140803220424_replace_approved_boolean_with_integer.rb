class ReplaceApprovedBooleanWithInteger < ActiveRecord::Migration
  def change
    remove_column :issues, :approved
    add_column :issues, :approved, :int, :default => 0
  end
end
