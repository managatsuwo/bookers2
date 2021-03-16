class BooksController < ApplicationController
  def new
  end

  def create
    @book= Book.new(book_params)
    @book.user_id= current_user.id
   if @book.save
     redirect_to books_path
     flash[:notice] ="successfully"
   else
      @books = Book.all
      render :index
   end
  end

  def index
   @book = Book.new
   @books= Book.all
  end

  def show

  end

  def destroy
     book = Book.find(params[:id])
     if book.destroy
        redirect_to books_path
        flash[:notice] ="successfully"
     else
       render :index
     end
  end

  def edit
    @book= Book.find(params[:id])
  end
  private

  def book_params
   params.require(:book).permit(:title,:body)
  end

end
