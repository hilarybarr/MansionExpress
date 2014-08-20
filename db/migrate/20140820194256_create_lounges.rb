class CreateLounges < ActiveRecord::Migration
  def change
    create_table :lounges do |t|
    	t.references :mansion

      t.timestamps
    end
  end
end
