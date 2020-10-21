class UsersController < ApplicationController
  def index
  end

  def show
    @user = User.find(params[:id])
    @post_book = Book.new
    @books = Book.all
    @user_book = @user.books
  end

  def edit
    @user = User.find(params[:id])
  end

  def new
    @post_book = Book.new
  end

  def create

  end

  def update
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

end
