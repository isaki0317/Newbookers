class FavoritesController < ApplicationController
    
    def create
      @book = Book.find(params[:book_id])
      favorite = current_user.favorites.new(book_id: params[:book_id])
      favorite.save
      # redirect_back(fallback_location: root_path)
      @book.create_notification_by(current_user)
      respond_to do |format|
        format.html {redirect_to request.referrer}
        format.js
      end
    end
    
    def destroy
      @book = Book.find(params[:book_id])
      favorite = current_user.favorites.find_by(book_id: params[:book_id])
      favorite.destroy
      # redirect_back(fallback_location: root_path)
    end
    
end
