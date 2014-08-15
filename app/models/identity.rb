class Identity < ActiveRecord::Base
	has_many :board_messages
	belongs_to :guest
	belongs_to :mansion_owner
end