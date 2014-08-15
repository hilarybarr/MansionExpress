class ChangeMansionPriceToString < ActiveRecord::Migration
  def change
  	remove_column :mansions, :price
  	add_column :mansions, :price, :string
  end
end
