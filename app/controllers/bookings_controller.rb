class BookingsController < ApplicationController

	def create
		mansion = Mansion.find(params[:id])
		if current_user
			Booking.find_by(mansion_id: mansion.id)
			mansion.users << User.find(current_user.id)
		else
			@user = User.create(params[:info])
			session[:user_id] = @user.id
			sign_in @user
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
			Booking.find_by(mansion_id: mansion.id)
			mansion.users << User.find(current_user.id)
			redirect_to mansion_lounge_path
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

