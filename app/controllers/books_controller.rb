class BooksController < ApplicationController
  def index
  end

  def show
  end

  def edit

  end

  def new
  end

  def create
    @post_book = Book.new(book_params)
    @post_book.user_id = current_user.id
    if @post_book.save
      flash[:notice] = "Book was successfully created."
      redirect_to book_path(@post_book)
    else
      render :index
    end
  end

  def update
  end

  def destroy
  end

  private
  def book_params
    params.require(:book).permit(:title, :body)
  end

end
