class CollectionsController < ApplicationController
	before_action :signed_in_user

	def create
    @album = Album.find(params[:collection][:album_id])
    current_user.collect!(@album)
    respond_to do |format|
      format.html { redirect_to @album }
      format.js
    end
  end

  def update
    @album = Album.find(params[:collection][:album_id])
    current_user.collect!(@album)
    @collection.update_attributes(params[:to_buy])
    respond_to do |format|
      format.html { redirect_to @album }
      format.js
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
      params.require(:collection).permit(:to_buy, :for_sale)
    end
end
