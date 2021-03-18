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
    @users= User.all
    @book = Book.new
    #@profile_images = @user.profile_images.page(params[:page]).reverse_order

  end

  def edit
    @user = User.find(params[:id])
  end
  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user)
  end
  private

  def user_params
   params.require(:user).permit(:name,:introduction,:profile_image)
  end
end