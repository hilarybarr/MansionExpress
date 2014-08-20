class AddLftToComments < ActiveRecord::Migration
  def change
    add_column :comments, :lft, :integer
  end
end
