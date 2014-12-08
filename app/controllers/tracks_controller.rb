class TracksController < ApplicationController

  before_action :set_track, only: [:show, :edit, :update, :destroy]

  def new
    @track = Track.new
    render :new
  end

  def create
    @track = Track.new(track_params)
    if @track.save
      flash[:notice] = "Track: #{@track.title} created!"
      redirect_to track_url(@track)
    else
      flash.now[:errors] = @track.errors.full_messages
      render :new
    end
  end

  def show
    @album = @track.album
    render :show
  end

  def edit
    render :edit
  end

  def update
    if @track.update(track_params)
      flash[:notice] = "Track: #{@track.title} updated!"
      redirect_to track_url(@track)
    else
      flash.now[:errors] = @track.errors.full_messages
      render :edit
    end
  end

  def destroy
    flash[:notice] = "Track: #{@track.title} destroyed!"
    @album = @track.album
    @track.destroy
    redirect_to album_url(@album)
  end

  private

  def track_params
    params.require(:track).permit(:title, :album_id, :kind, :lyrics)
  end

  def set_track
    @track = Track.find(params[:id])
  end

end
