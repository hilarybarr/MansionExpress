class CreatePersonalityTraitUsers < ActiveRecord::Migration
  def change
    create_table :personality_trait_users do |t|

    	t.references :user
    	t.references :personality_trait 

      t.timestamps
    end
  end
end
