class BookingsController < ApplicationController

	def create
		if current_user
			Booking.where(user_id: @user.id, mansion_id: mansion.id).first_or_create
		else
			@user = User.create(params[:info])
			session[:user_id] = @user.id
			sign_in @user
			mansion = Mansion.find(params[:id])
			Booking.where(user_id: @user.id, mansion_id: mansion.id).first_or_create
			@fluff = params[:fluff]
			@user.short_bio = @fluff[0]
			@user.hobbies = @fluff[1]
			@user.quirk = @fluff[2]
			@user.save			
			@traits = params[:trait]
			if @traits[0] == "" || @traits[1] == "" 
				redirect_to(:back)
				flash[:notice] = "You have to select stuff from the dropdowns"
			else
				@traits.each do |trait|
					@user.personality_traits << PersonalityTrait.find_by(name: trait)
				end
			redirect_to show_booking_path
			end
		end
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

