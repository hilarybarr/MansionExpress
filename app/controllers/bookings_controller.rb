class BookingsController < ApplicationController

	def create
		mansion = Mansion.find(params[:id])
		@user = User.create(params[:info])
		sign_in @user
		@traits = params[:trait]
		@traits.each do |trait|
			if trait
				@user.personality_traits << PersonalityTrait.find_by(name: trait)
			end
		end
		Booking.create(user_id: @user, mansion_id: mansion)
		session[:user_id] = @user.id
		redirect_to show_booking_path
	end

		

	def show
		#add current user logic
		@user = User.last # temporary fix cuz current_user is not working in the view
		@users = Booking.find_by(mansion_id: params[:id]).mansion.users
		#removing the user from the users pledge so that when we compare for percentage the same user isnt comparing to himself
		@mates = [] # the mates exclude the user that is comparing
		@users.each do |user|
			@mates << user unless user == @user
		end
	end

end

