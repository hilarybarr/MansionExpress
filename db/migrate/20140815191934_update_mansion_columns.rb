class UpdateMansionColumns < ActiveRecord::Migration
  def change
  	rename_column :mansions, :continent, :region
  	add_column :mansions, :source, :string
  end
end
