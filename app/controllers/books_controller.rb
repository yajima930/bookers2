class BooksController < ApplicationController
    before_action :correct_user,only: [:edit, :update]

def index
   @book = Book.new
   @books = Book.all
   @user = current_user
end

def edit
    @book = Book.find(params[:id])
end

def show
    @book = Book.find(params[:id])
    @user = @book.user
    @new_book = Book.new
end
def  destroy
  @book = Book.find(params[:id])
  @book.destroy
  redirect_to books_path
end

def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
    flash[:notice] ="You have updated user successfully."
    redirect_to book_path(@book)
    else
    render :edit
    end
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

private
def correct_user
    user = Book.find(params[:id]).user
    if current_user.id != user.id
        redirect_to books_path
    end

end
def book_params
    params.require(:book).permit(:title, :body)
end
end