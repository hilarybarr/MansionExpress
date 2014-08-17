class WelcomeController < ApplicationController
  def index
  	@user1 = User.first
  	@user2 = User.last
  end
end
