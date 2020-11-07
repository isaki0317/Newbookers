class PostCommentsController < ApplicationController
    
    def create
      @book = Book.find(params[:book_id])
      comment = current_user.post_comments.build(post_comment_params)
      comment.book_id = @book.id
      comment.save
      # 同期の場合↓
      # redirect_to book_path(book)
    end
    
    def destroy
      @comment = PostComment.find_by(id: params[:id], book_id: params[:book_id])
      @comment.destroy
      # @commentに紐づいているbookの情報を代入してjs形式のページ更新に使用している
      @book = @comment.book
      # 同期の場合↓
      # redirect_to book_path(params[:book_id])
    end
    
    private
    def post_comment_params
      params.require(:post_comment).permit(:comment)
    end
    
end
