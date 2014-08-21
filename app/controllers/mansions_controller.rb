class MansionsController < ApplicationController
  before_action :set_mansion, only: [:show, :edit, :update, :destroy]
  # GET /mansions
  # GET /mansions.json

  def index
    #@mansions = Mansion.all
    location=params[:location]
    if Mansion.all.pluck("country").include?(location.titleize)
      @location=params[:location].titleize
      @mansions=Mansion.where(country: @location)
    elsif Mansion.all.pluck("city").include?(location.titleize)
      @location=params[:location].titleize
      @mansions=Mansion.where(city: @location)
    elsif Mansion.all.pluck("region").include?(location.titleize)
      @location=params[:location].titleize
      @mansions=Mansion.where(region: @location)
    elsif params[:location]==""
      @location="the universe"
      @mansions=Mansion.all
    else
      flash[:no_location]="That location does not have mansions yet. Try again."
      redirect_to root_path
     end

    @hash = Gmaps4rails.build_markers(@mansions) do |mansion, marker|
      marker.lat mansion.latitude
      marker.lng mansion.longitude
    end
  end 

  # GET /mansions/1
  # GET /mansions/1.json
  def show
    @mansion = Mansion.find(params[:id])
    @users = @mansion.users
    
    @hash = Gmaps4rails.build_markers(@mansion) do |mansion, marker|
      marker.lat mansion.latitude
      marker.lng mansion.longitude
    end    
  end

  # GET /mansions/new
  def new
    @mansion = Mansion.new
  end

  # GET /mansions/1/edit
  def edit
  end

  # POST /mansions
  # POST /mansions.json
  def create
    @mansion = Mansion.new(mansion_params)

    respond_to do |format|
      if @mansion.save
        @lounge = Lounge.create(mansion_id: @mansion.id)

        format.html { redirect_to @mansion, notice: 'Mansion was successfully created.' }
        format.json { render :show, status: :created, location: @mansion }
      else
        format.html { render :new }
        format.json { render json: @mansion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /mansions/1
  # PATCH/PUT /mansions/1.json
  def update
    respond_to do |format|
      if @mansion.update(mansion_params)
        format.html { redirect_to @mansion, notice: 'Mansion was successfully updated.' }
        format.json { render :show, status: :ok, location: @mansion }
      else
        format.html { render :edit }
        format.json { render json: @mansion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mansions/1
  # DELETE /mansions/1.json
  def destroy
    @mansion.destroy
    respond_to do |format|
      format.html { redirect_to mansions_url, notice: 'Mansion was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def book
    mansion = Mansion.find(params[:id])
    # DROPDOWNS
    @genders = PersonalityTrait.where(category: "gender")
    @relationship_status = PersonalityTrait.where(category: "relationship status")
    # CHECKBOXES
    @random_traits = PersonalityTrait.where(category: "random traits")
  end

  def leave
    mansion = Mansion.find(params[:id])
    current_user.mansions.delete(mansion)
    current_user.save
    redirect_to :back
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mansion
      @mansion = Mansion.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def mansion_params
      params.require(:mansion).permit(:name, :description, :address, :region, :city, :bedrooms, :bathrooms, :square_feet, :available_date, :photo, :price, :source)
    end

    
end
