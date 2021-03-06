class BooksController < ApplicationController
  before_action :authenticate_user!
  def new
  end
  def create
     @new_book= Book.new(book_params)
     @new_book.user_id= current_user.id
    if @new_book.save
     redirect_to book_path(@new_book)
     flash[:notice] ="You have created book successfully."
    else
      @books = Book.all
      render :index
    end
  end

  def index
    @new_book = Book.new
    @books= Book.all
  end

  def show
     @book = Book.find(params[:id])
     @new_book = Book.new
     @book_comment = BookComment.new
  end

  def destroy
     @book = Book.find(params[:id])
    if @book.destroy
       redirect_to books_path
       flash[:notice] ="successfully"
    else
       flash[:notice] ="error"
       render :index
    end
  end

  def edit
      @book= Book.find(params[:id])
    if
     current_user.id != @book.user_id
     redirect_to  books_path
    end
  end

    def update
     @book = Book.find(params[:id])
      if @book.update(book_params)
         redirect_to book_path(params[:id])
         flash[:notice] ="You have updated book successfully."
      else
          render :edit
      end
    end

  private

  def book_params
   params.require(:book).permit(:title,:body)
  end
end
