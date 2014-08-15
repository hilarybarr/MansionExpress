class CreateIdentities < ActiveRecord::Migration
  def change
    create_table :identities do |t|
      t.string :first_name
      t.string :last_name
      t.string :gender
      t.text :birthdate
      t.text :email
      t.string :password_digest
      # t.references :mansionowner, index: true

      t.timestamps
    end
  end
end
