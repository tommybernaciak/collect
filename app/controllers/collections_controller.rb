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

  def destroy
    @album = Collection.find(params[:id]).album
    current_user.uncollect!(@album)
    respond_to do |format|
      format.html { redirect_to @album }
      format.js
    end
  end


end
