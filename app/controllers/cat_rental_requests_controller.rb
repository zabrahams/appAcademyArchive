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

  def approve
    @crr = CatRentalRequest.find(params[:id])
    @crr.approve!
    redirect_to cat_url(@crr.cat_id)
  end

  def deny
    @crr = CatRentalRequest.find(params[:id])
    @crr.deny!
    redirect_to cat_url(@crr.cat_id)
  end


  private
  def crr_params
    params.require(:cat_rental_request).permit(:cat_id, :start_date, :end_date)
  end
end
