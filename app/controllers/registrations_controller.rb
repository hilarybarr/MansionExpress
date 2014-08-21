class RegistrationsController < Devise::RegistrationsController
  def new
  	@genders = PersonalityTrait.where(category: "gender")
		@relationship_status = PersonalityTrait.where(category: "relationship status")
		@random_traits = PersonalityTrait.where(category: "random traits")
    super
  end

  def create
  	@user = User.create(params['user'])
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
		end
		#super
		redirect_to root_path
	end

  def update
    super
  end
end 