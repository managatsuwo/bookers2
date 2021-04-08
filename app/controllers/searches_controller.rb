class SearchesController < ApplicationController
  before_action :authenticate_user!

  def finder
    @range = params[:range]
    @word = params[:word]
    if @range == "User"
      @users = User.looks(params[:search], params[:word])
    elsif @range == "Book"
      @books = Book.looks(params[:search], params[:word])
    end
  end

end