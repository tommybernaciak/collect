class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :signed_in_user

  # GET
  def index
    @posts = Post.all
  end

  # GET
  def show
  end

  # GET
  def new
    @post = Post.new
  end

  # GET
  def edit
  end

  # POST
  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "post created!"
      redirect_to root_url
    else
      render action: 'new'
    end
  end

  # PATCH/PUT
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:content)
    end
end
