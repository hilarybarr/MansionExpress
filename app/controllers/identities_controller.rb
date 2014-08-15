class IdentitiesController < ApplicationController
  def create
  end

  def update
  end

  def destroy
    @identity = Identity.find(params[:id])
    @identity.destroy
    redirect_to root_path 
  end

  private

  def identity_params
    params.require(:identity).permit(:email, :password)
  end
end