class BooksController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
    @books = if params[:show_unavailable] == 'true'
               Book.all
             else
               Book.where(available: true)
             end
    render json: @books
  end

  def show
    @book = Book.includes(:author).find(params[:id])
    render json: @book.as_json(except: :author_id, include: { author: { only: %i[id pen_name] } })
  end

  def create
    @book = Book.new(book_params)

    if @book.save
      render json: @book, status: :created
    else
      render json: @book.errors, status: :unprocessable_entity
    end
  end

  def update
    @book = Book.find(params[:id])

    if @book.update(book_params)
      render json: @book
    else
      render json: @book.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
  end

  private

  def book_params
    params.require(:book).permit(:title, :author_id, :description, :published_date, :available)
  end
end
