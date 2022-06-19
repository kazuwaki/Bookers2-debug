class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
    @following_users = @user.following_user
    @follower_users = @user.follower_user
    @today_book = @books.created_today
    @yesterday_book = @books.created_yesterday
    @this_week_book = @books.created_this_week
    @last_week_book = @books.created_last_week
    @data = [['6日前',@books.created_6days.count],['5日前',@books.created_5days.count],['4日前',@books.created_4days.count],['3日前',@books.created_3days.count],['2日前',@books.created_2days.count],['昨日',@yesterday_book.count],['今日',@today_book.count]]
  end

  def index
    @users = User.all
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(current_user), notice: "You have updated user successfully."
    else
      render :edit
    end
  end

  def follows
    user = User.find(params[:id])
    @users = user.following_user.reverse_order
  end

  def followers
    user = User.find(params[:id])
    @users = user.follower_user.reverse_order
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    @books = @user.books
    redirect_to user_path(current_user)unless @user == current_user
  end
end
