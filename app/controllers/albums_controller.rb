class AlbumsController < ApplicationController
  def create
    @album = Band.new(album_params)

    if @album.save
      redirect_to album_url(@album)
    else
      flash.now[:errors] = [@album.errors.full_messages]
      render :new
    end
  end

  def new
    render :new
  end

  def edit
  end

  def show
  end

  def destroy
  end

  private
  def album_params
    params.require(:album).permit(:band_id, :title)
  end
end
