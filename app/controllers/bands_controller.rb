class BandsController < ApplicationController

  def index
    @bands = Band.alphabetical.to_a
  end

  def show
    @band = Band.find(params[:id])
  end

  def new
    authorize! :new, @band
    @band = Band.new
  end

  def edit
    authorize! :update, @band
    @band = Band.find(params[:id])
  end

  def create
    authorize! :new, @band
    params[:band][:genre_ids] ? genres = params[:band][:genre_ids] : genres = Array.new
    @band = Band.new(band_params) if Band.check_genres(genres)
    
    if @band.save
      redirect_to(@band, :notice => 'Band was successfully created.')
    else
      params[:band][:genre_ids] = nil
      render :action => "new"
    end
  end

  def update
    authorize! :update, @band
    @band = Band.find(params[:id])
    Band.check_genres(params[:band][:genre_ids])
    if @band.update_attributes(band_params)
      redirect_to(@band, :notice => 'Band was successfully updated.')
    else
      render :action => "edit"
    end
  end

  def destroy
    authorize! :destroy, @band
    @band = Band.find(params[:id])
    @band.destroy
  end

  private
  def band_params
    params.require(:band).permit(:name, :description, :playing_next, :when_playing_next, :photo, :song, :genre_ids => [])
  end

end
