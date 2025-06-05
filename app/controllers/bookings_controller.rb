class BookingsController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def renter_bookings
    @bookings = Booking.where(user: current_user)
  end

  def create
    @desk = Desk.find(params[:booking][:desk_id])

    # Parse the two dates from params. If the user enters invalid dates, parsing returns nil.
    start_date = (Date.parse(params[:booking][:start_date]) rescue nil)
    end_date   = (Date.parse(params[:booking][:end_date]) rescue nil)

    @booking = Booking.new(
      user: current_user,
      desk: @desk,
      start_date: start_date,
      end_date: end_date
    )

    if @booking.save
      nights = (@booking.end_date - @booking.start_date + 1).to_i
      desk_title = @booking.desk.title
      flash[:notice] = "you just booked the flat #{desk_title} for #{nights} night#{'s' if nights > 1}!"
      redirect_to renter_bookings_path, notice: "you just booked the flat '#{desk_title}' for #{nights} day#{'s' if nights > 1}! See the booking below"
    else
      redirect_to desk_path(@desk), alert: "Could not create booking. Please select valid dates."
    end
  end

  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy
    redirect_to renter_bookings_path, notice: "Your booking at #{@booking.desk.title} starting #{@booking.start_date} has been removed."
  end
end
