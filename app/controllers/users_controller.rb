class UsersController < ApplicationController
    before_action :correct_user,only: [:edit, :update]
def index
  @users = User.all
  @book = Book.new
  @user = current_user
end

def edit
    @user = User.find(params[:id])
end

def show
    @user = User.find(params[:id])
    @new_book = Book.new
    @books = @user.books
end

def create
   @book = Book.new(book_params)
   @book.user = current_user
   if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book)
   else
      @books = Book.all
      @user = current_user
     render :index
   end
end

def update
    @user = User.find(params[:id])
    if @user.update(user_params)
    flash[:notice] = "You have updated user successfully."
    redirect_to user_path(@user)

    else
    render :edit
    end

end

  private
    def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)

    end
  def correct_user
    user = User.find(params[:id])
    if current_user.id != user.id
        redirect_to user_path(current_user.id)
    end
  end
end
