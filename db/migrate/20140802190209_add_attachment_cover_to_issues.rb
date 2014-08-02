class AddAttachmentCoverToIssues < ActiveRecord::Migration
  def self.up
    change_table :issues do |t|
      t.attachment :cover
    end
  end

  def self.down
    remove_attachment :issues, :cover
  end
end
