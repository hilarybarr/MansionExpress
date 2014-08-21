class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :short_bio, :text
    add_column :users, :hobbies, :text
    add_column :users, :quirk, :text
  end
end
