class CreatePledges < ActiveRecord::Migration
  def change
    create_table :pledges do |t|
      t.integer :user_id
      t.integer :mansion_id
      t.date :start_date
      t.date :end_date
      t.integer :total_price
    end
  end
end
