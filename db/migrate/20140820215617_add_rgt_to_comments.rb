class AddRgtToComments < ActiveRecord::Migration
  def change
    add_column :comments, :rgt, :integer
  end
end
