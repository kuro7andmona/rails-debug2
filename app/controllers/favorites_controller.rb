class FavoritesController < ApplicationController

before_action :authenticate_user!

  #belongs_to :user
  #sbelongs_to :book

  def create
   @book = Book.find(params[:book_id])
   favorite = current_user.favorites.new(book_id: @book.id)
   favorite.save
   #redirect_to books_path
  end

  def destroy
    @book = Book.find(params[:book_id])
    favorite = current_user.favorites.find_by(book_id: @book.id)
    favorite.destroy
    #redirect_to books_path
  end
end
