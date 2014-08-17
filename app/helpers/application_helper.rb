module ApplicationHelper
	def user_to_user_compatibility(user1, user2)
	points = 0
	user1.personalitytraits.each do |user1trait|
		user2.personalitytraits.each do |user2trait|
			if user2trait == user1trait
				points += 1
			end
		end
	end
	return points
end

# pledge is the pledge object where everybody who applies to the mansion is
def overall_pledge_compatibility(pledge)
	total_points = 0
	mansion_mates = pledge.users
	mansion_mates.each_with_index do |mate, index|
		index_of_next_mate = index + 1
		next_mate_to_compare_with = mansion_mates[index_of_next_mate]
		until next_mate_to_compare_with == nil
			points = user_to_user_compatibility(mate, next_mate_to_compare_with)
			total_points += points
			next_mate_to_compare_with = mansion_mates[index_of_next_mate + 1]
		end
		return total_points
	end
end

end









