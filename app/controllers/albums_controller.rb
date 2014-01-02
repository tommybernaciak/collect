class AlbumsController < ApplicationController
#	before_action :set_album, only: [:show, :edit, :update, :destroy]

	# GET
  def index
    @albums = Album.all
  end

  # GET
  def new
    @album = Album.new
  end

  # POST
  def create
    @album = Album.new(album_params)
    if @album.save
      flash[:success] = "album added!"
      redirect_to albums_url
    else
      render action: 'new'
    end
  end

  # DELETE
  def destroy
  	@album = Album.find(params[:id])
  	@album.destroy
  	redirect_to albums_url
  end
private
#    # Use callbacks to share common setup or constraints between actions.
#    def set_album
#      @album = Album.find(params[:id])
#    end
# Never trust parameters from the internet, only allow the white list through.
    def album_params
      params.require(:album).permit(:title, :artist)
    end

end
