class CreateMansions < ActiveRecord::Migration
  def change
    create_table :mansions do |t|
      t.string :name
      t.text :description
      t.string :address
      t.string :continent
      t.string :city
      t.integer :bedrooms
      t.integer :bathrooms
      t.integer :square_feet
      t.date :available_date

      t.timestamps
    end
  end
end
