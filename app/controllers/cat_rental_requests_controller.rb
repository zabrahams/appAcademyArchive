class CatRentalRequestsController < ApplicationController
  def new
    @crr = CatRentalRequest.new
    render :new
  end

  def create
    @crr = CatRentalRequest.new(crr_params)
    if @crr.save
      redirect_to cat_url(@crr.cat_id)
    else
      render :new
    end
  end

  private
  def crr_params
    params.require(:cat_rental_request).permit(:cat_id, :start_date, :end_date)
  end
end
