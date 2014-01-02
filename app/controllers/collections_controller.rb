class CollectionsController < ApplicationController
	before_action :signed_in_user

	def create
    @album = Album.find(params[:collection][:album_id])
    current_user.add_to_collection!(@album)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  def destroy
    @album = Collection.find(params[:id]).album
    current_user.delete_from_collection!(@album)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end


end
