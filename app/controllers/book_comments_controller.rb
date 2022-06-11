class BookCommentsController < ApplicationController
  def create
    @book = Book.find(params[:book_id])
    @book_comment = current_user.book_comments.new(book_comment_params)
    @book_comment.book_id = @book.id
    @book_comment.save
    #binding.pry
    render :comment
  end


  def destroy
    #binding.pry
    @book_comment = BookComment.find(params[:id])
    @book_comment.destroy
    render :comment
  end

    private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end

end
