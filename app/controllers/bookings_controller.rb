class BookingsController < ApplicationController

	def create
		@user = User.create(params[:info])
		sign_in @user
		mansion = Mansion.find(params[:id])
		Booking.where(user_id: @user.id, mansion_id: mansion.id).first_or_create
		session[:user_id] = @user.id
		@traits = params[:trait]
		@traits.each do |trait|
			if trait.name
				@user.personality_traits << PersonalityTrait.find_by(name: trait)
			end
		end
		redirect_to show_booking_path
	end


	def show
		@user = User.find(session[:user_id])
		@users = Booking.find_by(mansion_id: params[:id]).mansion.users
		# we remove the user from the users pledge so that when we compare for percentage the same user isnt comparing to himself, the variable mates exclude the user that is comparing
		@mates = [] 
		@users.each do |mate|
			@mates << mate unless mate == @user
		end
	end

end

