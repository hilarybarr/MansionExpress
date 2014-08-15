class CreateMansionAmenities < ActiveRecord::Migration
  def change
    create_table :mansion_amenities do |t|

    	t.string :name

      t.timestamps
    end
  end
end
