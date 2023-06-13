class BooksController < ApplicationController
before_action :authenticate_user!
  def new
    @books = Book.new
  end

  def show
    @new_book = Book.new
    @book = Book.find(params[:id])
    @user = @book.user
    @book_comment = BookComment.new
  end

  def index
    @books = Book.all
    #いいね投稿順に表示
    to = Time.current.at_end_of_day
    from = (to - 6.day).at_beginning_of_day
    @books = Book.includes(:favorites).
      sort_by {|x|
        x.favorites.includes(:favorites).where(created_at: from...to).size
       }.reverse
    @book = Book.new
    @user = current_user

  end


  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book.id), notice: "You have created book successfully."
    else
      @user = current_user
      @books = Book.all
      render :index
    end
  end

  def edit
    @book = Book.find(params[:id])
    @user = current_user
    if @user != @book.user
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book.id), notice: "You have updated book successfully."
    else
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body, :image, :user_id)
  end
end
