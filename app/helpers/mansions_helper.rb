module MansionsHelper

	def in_mansion? (user, mansion)
		user.mansions.include?(mansion)
	end

	def room_available?(mansion)
		mansion.users.count < mansion.bedrooms
	end

end
