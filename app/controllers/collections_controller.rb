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
  end

  def update
    @collection = Collection.find(params[:id]).album
    if @collection.update_attributes(params[:for_sale])
      flash[:success] = "success"
      redirect_to current_user
    else
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

  #def add_to_buy
  #  @album = Collection.find(params[:id]).album
  #  current_user.buy!(@album)
  #  @album.update_attributes(to_buy: 'true')
  #  respond_to do |format|
  #    format.html { redirect_to @album }
  #    format.js
  #  end
  #end

#<%= form_for(current_user.collection(album_id: @album, :to_buy => true), remote: true) do |f| %>
#  <div><%= f.hidden_field :album_id %></div>
#  <div><%= f.hidden_field :to_buy%></div>
#  <%= f.submit "Add to my wishlist", class: "btn btn-large btn-primary" %>
#<% end %>

  #def add_to_sell
  #end

  private
    def collection_params
      params.require(:collection).permit(:to_buy, :for_sale)
    end
end
