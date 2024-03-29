class BooksController < ApplicationController
  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @user = current_user
    @books =  Book.all
    @book.user = @user
    if @book.save
    redirect_to book_path(@book), notice:"You have created book successfully."
    else
    render :index
    end
  end

  def index
   @book = Book.new
   @books = Book.all
   @user = current_user

  end

  def show
   @book = Book.find(params[:id])
   @user = @book.user
  end

  def edit
   @book = Book.find(params[:id])
   redirect_to(books_path) unless @book.user == current_user
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
   @book = Book.find(params[:id])
   @book.destroy
   redirect_to books_path
  end

 private

 def book_params
    params.require(:book).permit(:title, :body)
 end



end
