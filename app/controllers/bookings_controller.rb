class BookingsController < ApplicationController

  def show
    @booking = Booking.find(params[:id])
  end

  def new
    @desk = Desk.find(params[:desk_id])
    @booking = Booking.new
  end

  def create
    @desk = Desk.find(params[:desk_id])
    @booking = Booking.new(booking_params)
    @booking.desk = @desk
    @booking.user = current_user
    @booking.total_price = @booking.calculate_total_price
    if @booking.start_date < Date.today
      flash[:alert] = "You can't book a desk in the past"
      redirect_to desk_path(@desk)
    elsif @booking.end_date < @booking.start_date
      flash[:alert] = "You can't book a desk with an end date before the start date"
      redirect_to desk_path(@desk)
    elsif @booking.save
      redirect_to "/dashboard", status: :see_other
    else
      render "desks/show"
    end
  end

  def update
    @booking = Booking.find(params[:id])

    if params[:confirmed] == "true"
      @booking.confirmed = true
      @booking.save
    elsif params[:confirmed] == "false"
      @booking.confirmed = false
      @booking.save
    else
      @booking.update(booking_params)
    end

    redirect_to "/dashboard", status: :see_other
  end

  def destroy
    @booking = Booking.find(params[:id])

    @booking.destroy
    redirect_to "/dashboard", status: :see_other
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :total_price)
  end
end
