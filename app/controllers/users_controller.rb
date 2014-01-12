class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :signed_in_user, only: [:edit, :update, :destroy, :following, :followers]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy

  def index
    @search = User.search(params[:q])
    @users = @search.result
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.paginate(page: params[:page])
    @albums = @user.albums.paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = "Welcome!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted."
    redirect_to users_url
  end

  #following users
  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  #collections
  def collected
    @title = "albums collected"
    @album = Album.find(params[:id])
    @albums = @album.albums.paginate(page: params[:page])
    render 'show_follow'
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:nick, :email, :password, :password_confirmation, :admin, :profile_photo)
    end

    #check if correct user is doing action
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    #check if current user is admin
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
