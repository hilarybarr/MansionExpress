class BookingsController < ApplicationController
	def create

		mansion = Mansion.find(params[:id])
		user = User.create(params[:account])
		@traits = params[:stuff]
		@traits.each do |trait|
			user.personality_traits << PersonalityTrait.find(name: trait)
		end
		Booking.create(user_id: user, mansion_id: mansion)
	end

		

	def show

		#add current user logic
		@user = User.last
		@pledge = Booking.find_by(mansion_id: params[:id])
	end

end
