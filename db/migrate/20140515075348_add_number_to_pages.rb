class AddNumberToPages < ActiveRecord::Migration
  def change
    add_column :pages, :number, :integer
  end
end
