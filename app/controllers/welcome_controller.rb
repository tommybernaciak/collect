class WelcomeController < ApplicationController
  
  def index
    @posts = Post.all.paginate(page: params[:page])
    if signed_in?
      @post = current_user.posts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end

  # static pages
  def help
  end

  def about
  end

  def contact
  end
end
