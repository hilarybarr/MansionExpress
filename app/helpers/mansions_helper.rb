module MansionsHelper

	def js_alert
	 render :js => "alert('This Therapist is assigned to a visit')"
  end
  
	def in_mansion? (user, mansion)
		user.mansions.include?(mansion)
	end

	def room_available?(mansion)
		mansion.users.count < mansion.bedrooms
	end

	def prices_per_occupants(mansion)
		 pricing_options=""
		  x=1
		 until x > mansion.bedrooms.to_i 
		  	price=(mansion.price.scan(/[.0-9]/).join().to_i)/(x)
		    pricing_options << "  #{x} People: $#{price}.   " 
		    x+=1
		   end
		  return pricing_options
		end

end
