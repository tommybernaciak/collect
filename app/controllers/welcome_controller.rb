class WelcomeController < ApplicationController
  
  def index
    @posts = Post.all.paginate(page: params[:page])
    @post = current_user.posts.build if signed_in?
  end

  # static pages
  def help
  end

  def about
  end

  def contact
  end
end
