class AddPriceToMansions < ActiveRecord::Migration
  def change
    add_column :mansions, :price, :integer
  end
end
