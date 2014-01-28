class CollectionsController < ApplicationController
	before_action :signed_in_user

  #def index
  #  @collections = Collection.all
  #end

	def create
    @album = Album.find(params[:collection][:album_id])
    current_user.collect!(@album)
    respond_to do |format|
      format.html { redirect_to @album }
      format.js
    end
  end

  def edit
    @collection = Collection.find(params[:id])
  end

  def update
    @collection = Collection.find(params[:collection][:id])
    if @collection.update(collection_params)
      Rails.logger.info(@collection.errors.messages.inspect)
      flash[:success] = "updated!"
      redirect_to current_user
    else
      Rails.logger.info(@collection.errors.messages.inspect)
      flash[:warning] = "not working"
      redirect_to current_user
    end
  end

  def destroy
    @album = Collection.find(params[:id]).album
    current_user.uncollect!(@album)
    respond_to do |format|
      format.html { redirect_to @album }
      format.js
    end
  end

  private
    def collection_params
      params.require(:collection).permit(:sell, :buy, :id, :to_buy, :for_sale)
    end
end
