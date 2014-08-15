class PersonalityTrait < ActiveRecord::Base
	has_many :personality_trait_users
	has_many :guests, through: :personality_trait_users, source: :user
end
