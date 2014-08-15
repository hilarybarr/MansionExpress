class PersonalityTraitUser < ActiveRecord::Base
	belongs_to :user
	belongs_to :personality_trait
end
