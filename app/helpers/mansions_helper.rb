module MansionsHelper
  
	def in_mansion? (user, mansion)
		user.mansions.include?(mansion)
	end

	def room_available?(mansion)
		mansion.users.count < mansion.bedrooms
	end

	def prices_per_occupants(mansion)
		 pricing_options=[]
		  x=1
		 until x > mansion.bedrooms.to_i 
		  	price=(mansion.price.scan(/[.0-9]/).join().to_i)/(x)
		  	if x==1
					pricing_options << "#{x} Person: $#{price}." 
				else
					pricing_options << "#{x} People: $#{price}." 
				end
		    x+=1
		   end
		  return pricing_options
		end

end
