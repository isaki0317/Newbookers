class BooksController < ApplicationController
  
  before_action :authenticate_user!
  
  def index
    @user = current_user
    @books = Book.all
    @post_book = Book.new
  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @post_book = Book.new
    @post_comment = PostComment.new
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user == current_user
      render :edit
    else
      redirect_to books_path
    end
  end

  def create
    @post_book = Book.new(book_params)
    @post_book.user_id = current_user.id
    if @post_book.save
      flash[:notice] = "Book was successfully created."
      redirect_to book_path(@post_book)
    else
      @books = Book.all
      @user = current_user
      render :index
    end
  end

  def update
    @book =  Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "User was successfully updated."
      redirect_to book_path(@book)
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    if @book.destroy
      redirect_to books_path
    end
  end

  private
  def book_params
    params.require(:book).permit(:title, :body, :user_id)
  end

end
