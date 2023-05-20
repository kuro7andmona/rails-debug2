class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:update, :edit]

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def index
    @users = User.all
    @book = Book.new
    @user = current_user
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: "You have updated user successfully."
    else
      render :edit
    end
  end

  def create
    @user = User.new(user_params)
     @book.user_id = current_user.id
    if @user.save
      redirect_to users_path
    else
      render :index
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image, :password, :password_confirmation)
  end

  def ensure_correct_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path(current_user)
    end
  end
end