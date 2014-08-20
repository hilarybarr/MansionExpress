class Lounge < ActiveRecord::Base
	belongs_to :mansion
	has_many :comments, :as => :commentable

	acts_as_commentable
end
