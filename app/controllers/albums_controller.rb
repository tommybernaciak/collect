class AlbumsController < ApplicationController
	before_action :set_album, only: [:show, :edit, :update, :destroy]

	# GET
  def index
    @search = Album.search(params[:q])
    @albums = @search.result
  end

  # GET
  def show
    @album = Album.find(params[:id])
  end

  # GET
  def new
    @album = Album.new
  end

  # GET
  def edit
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

  # PATCH/PUT
  def update
    respond_to do |format|
      if @album.update(album_params)
        format.html { redirect_to @album, notice: 'Album updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  def collectors
    @title = "collectors"
    @user = User.find(params[:id])
    @users = @user.users.paginate(page: params[:page])
    render 'show_follow'
  end

private
#    # Use callbacks to share common setup or constraints between actions.
    def set_album
      @album = Album.find(params[:id])
    end
# Never trust parameters from the internet, only allow the white list through.
    def album_params
      params.require(:album).permit(:title, :artist, :format)
    end

end
