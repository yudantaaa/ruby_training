class RentalsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @rental = Rental.includes([:user,:book]).all
    render json: @rental.as_json(except: [:user_id, :book_id, :created_at, :updated_at], include: { user: { only: [:id, :name]}, book: { only: [:id, :title] } })
 end

  def show
    @rental = Rental.includes([:user,:book]).find(params[:id])
    render json: @rental.as_json(except: [:user_id, :book_id], include: { user: { only: [:id, :name]}, book: { only: [:id, :title] } })
  end

  def create
    @rental = Rental.new(rental_params)
    @rental.book.update(available: false)
    if @rental.save
      render json: @rental, status: :created
    else
      render json: @rental.errors, status: :unprocessable_entity
    end
  end

  def update
    @rental = Rental.find(params[:id])

    if @rental.update(rental_params)
      render json: @rental
    else
      render json: @rental.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @rental = Rental.find(params[:id])
    @rental.destroy
  end

  private

  def rental_params
    params.require(:rental).permit(:user_id, :book_id, :rented_at, :due_date, :returned_at)
  end
end
