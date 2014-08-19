module MansionsHelper

	def in_mansion? (user, mansion)
		user.mansions.include?(mansion)
	end

	def room_available?(mansion)
		mansion.users.count < mansion.bedrooms
	end

	def prices_per_occupants(mansion)
	  #  x=1
		 # until x > mansion.bedrooms.to_i 
		 # 	price=(mansion.price.scan(/[.0-9]/).join().to_i)/(x)
		 #   print "#{x} People: #{price}" 
		 #   x+=1
		 #  end

		 price(mansion)/occupants()
		end


	def occupants(mansion)
		mansion.bedrooms.count
	end


	def price(mansion)
		mansion.price.scan(/[.0-9]/).join().to_i
	end


		# bedrooms=mansion.bedrooms.to_i
		# price= mansion.price.scan(/[.0-9]/).join().to_i)




end
