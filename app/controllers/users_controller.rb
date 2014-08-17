class UsersController < ApplicationController
	def show
		@user = User.find(params[:id])
		@mansions = @user.mansions
	end
end