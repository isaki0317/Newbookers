class UsersController < ApplicationController
  
  before_action :authenticate_user!
  
  def index
    @users = User.all
    @user = current_user
    @post_book = Book.new
  end

  def show
    @user = User.find(params[:id])
    @post_book = Book.new
    @books = Book.all
    @favorite_books = @user.favorite_books
  end

  def edit
    @user = User.find(params[:id])
    if @user == current_user
      render :edit
    else
      redirect_to user_path(current_user)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "User was successfully updated."
      redirect_to user_path(@user)
    else
      # @users = User.all
      render :edit
    end
  end
  
  def follows
    user = User.find(params[:id])
    @users = user.followings
  end

  def followers
    user = User.find(params[:id])
    @users = user.followers
  end
  
  def search
    if params[:name].present?
      @users = User.where('name LIKE ?', "%#{params[:name]}%")
    else
      @users = User.none
    end
  end
  
  def follows_book
     @follows_books = Book.where(user_id: [current_user.id, *current_user.following_ids])
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

end
