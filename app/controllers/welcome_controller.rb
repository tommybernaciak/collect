class WelcomeController < ApplicationController
  
  def index
    @posts = Post.all.paginate(page: params[:page])
  end

  # static pages
  def help
  end

  def about
  end

  def contact
  end
end
