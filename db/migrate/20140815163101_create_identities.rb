class CreateIdentities < ActiveRecord::Migration
  def change
    create_table :identities do |t|
      t.string :email
      t.string :password
      t.references :guest, index: true
      t.references :mansion_owner, index: true
    end
  end
end
