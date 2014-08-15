class CreatePledges < ActiveRecord::Migration
  def change
    create_table :pledges do |t|
      t.integer :guest_id
      t.integer :mansion_id
      t.date :start_date
      t.date :end_date
      t.integer :total_price
      t.references :guest, index: true
      t.references :mansion, index: true

      t.timestamps
    end
  end
end
