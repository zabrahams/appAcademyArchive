class AlbumsController < ApplicationController

  before_action :require_login
  before_action :set_album, only: [:show, :edit, :update, :destroy]
  before_action :require_admin, only: [:new, :create, :edit, :update, :destroy]
  

  def new
    @album = Album.new
    render :new
  end

  def create
    @album = Album.new(album_params)
    if @album.save
      flash[:notice] = "Album: #{@album.title} created"
      redirect_to album_url(@album)
    else
      flash.now[:errors] = @album.errors.full_messages
      render :new
    end
  end

  def show
    @band = @album.band
    @tracks = @album.tracks
    render :show
  end

  def edit
    render :edit
  end

  def update
    if @album.update(album_params)
      flash[:notice] = "Updated #{@album.title}"
      redirect_to album_url(@album)
    else
      flash[:errors] = @album.errors.full_messages
      render :edit
    end
  end

  def destroy
    flash[:notice] = "#{@album.title} destroyed!!!!!"
    @band = @album.band
    @album.destroy
    redirect_to band_url(@band)
  end

  private

  def set_album
    @album = Album.find(params[:id])
  end

  def album_params
    params.require(:album).permit(:title, :kind, :band_id)
  end

end
