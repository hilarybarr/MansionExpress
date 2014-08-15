class Pledge < ActiveRecord::Base
	has_many :board_messages
	belongs_to :user
	belongs_to :mansion
end