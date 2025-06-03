class BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_desk

  def new
    @booking = @desk.bookings.build
    # render app/views/bookings/new.html.erb
  end

  def create
    @booking = @desk.bookings.build(booking_params)
    @booking.user = current_user
    if @booking.save
      redirect_to desk_booking_path(@desk, @booking), notice: "Booking confirmed!"
    else
      flash.now[:alert] = "Please fix errors below."
      render :new
    end
  end

  private

  def set_desk
    @desk = Desk.find(params[:desk_id])
  end

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end
end
