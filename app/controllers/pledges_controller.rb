class PledgesController < ApplicationController
  def create
    @mansion = Mansion.find(params[:mansion_id])
    # @answer = Answer.find(params[:answer_id])
    @pledge = @mansion.pledges.create!(pledge_params)
    respond_to do |format|
      format.html { redirect_to @mansion }
      format.js
    end
  end

  def destroy
    @pledge = Pledge.find(params[:id])
    @pledge.destroy
    redirect_to root_path 
  end

  private

  def pledge_params
    params.require(:pledge).permit(:start_date, :end_date, :total_price)
  end
end