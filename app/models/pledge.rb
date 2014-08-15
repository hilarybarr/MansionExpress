class Pledge < ActiveRecord::Base
	has_many :board_messages
	belongs_to :guest
	belongs_to :mansion
end