class UsersController < ApplicationController
  def index
    @users = User.all
    @user = current_user
    @post_book = Book.new
  end

  def show
    @user = User.find(params[:id])
    @post_book = Book.new
    @books = Book.all
    @user_book = @user.books
  end

  def edit
    @user = User.find(params[:id])
    if @user == current_user
      render :edit
    else
      redirect_to user_path(current_user)
    end
  end

  def new
    @post_book = Book.new
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "User was successfully updated."
      redirect_to user_path(@user)
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

end
