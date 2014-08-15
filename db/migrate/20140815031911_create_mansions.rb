class CreateMansions < ActiveRecord::Migration
  def change
    create_table :mansions do |t|
    	t.decimal :price
    	t.text :description
    	t.string :address
    	t.string :continent
    	t.string :city
    	t.integer :bedroom
    	t.integer :bathroom
    	t.integer :square_foot
    	t.datetime :available_date
    	
      t.timestamps
    end
  end
end
