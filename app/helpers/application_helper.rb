module ApplicationHelper
	def user_to_user_compatibility(user1, user2)
	points = 0
	user1.personality_traits.each do |user1trait|
		user2.personality_traits.each do |user2trait|
			if user2trait == user1trait
				points += 1
			end
		end
	end
	return points
end

# pledge is the pledge object where everybody who applies to the mansion is

def overall_pledge_compatibility(pledge)
	puts "start of method"
	total_points = 0
	mansion_mates = pledge
	puts "assigned mansion mates to pledge"
	mansion_mates.each_with_index do |mate, index|
		puts "iterating" 
		index_of_next_mate = index + 1
		puts index_of_next_mate 
		next_mate_to_compare_with = mansion_mates[index_of_next_mate]
		puts next_mate_to_compare_with
		puts "HHHHHHHHHHHH"
		until next_mate_to_compare_with == nil
			puts "start of until bla bla"
			points = user_to_user_compatibility(mate, next_mate_to_compare_with)
			puts points
			total_points += points
			puts total_points
			next_mate_to_compare_with = mansion_mates[index_of_next_mate += 1]
			puts "CHICHI"
			puts index_of_next_mate
			puts "WAKAKAKAKAKAKAKAAK"
			puts next_mate_to_compare_with
			puts "WAKAKAKAKAKAKAKAAK"
		end
	end
	return total_points
	puts "end of method"
end

end


# def overall_pledge_compatibility(pledge)
# 	total_points = 0
# 	mansion_mates = pledge.users
# 	mansion_mates.each_with_index do |mate, index|
# 		index_of_next_mate = index + 1
# 		next_mate_to_compare_with = mansion_mates[index_of_next_mate]
# 		until next_mate_to_compare_with == nil
# 			points = user_to_user_compatibility(mate, next_mate_to_compare_with)
# 			total_points += points
# 			next_mate_to_compare_with = mansion_mates[index_of_next_mate + 1]
# 		end
# 		return total_points
# 	end
# end

# end






