class UsersController < ApplicationController
  def show
  @user= User.find(params[:id])
  @books = @user.books
  @book = Book.new
  end
  
  def create
    @book= Book.new(book_params)
    @book.user_id= current_user.id
   if @book.save
     redirect_to book_path(@book)
     flash[:notice] ="successfully"
   else
      @books = Book.all
      render :index
   end
  end
  
  def destroy
     @book = Book.find(params[:id])
     if @book.destroy
        redirect_to books_path
        flash[:notice] ="successfully"
     else
       render :index
     end
  end
  
  def index
   @book= Users
  end
  private

  def book_params
   params.require(:book).permit(:title,:body)
  end
end
