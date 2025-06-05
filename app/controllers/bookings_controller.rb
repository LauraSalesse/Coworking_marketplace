class BookingsController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def renter_bookings
    @bookings = Booking.where(user: current_user)
  end

  def create
    @desk = Desk.find(params[:desk_id])

    # Parse the two dates from params. If the user enters invalid dates, parsing returns nil.
    start_date = (Date.parse(params[:start_date]) rescue nil)
    end_date   = (Date.parse(params[:end_date]) rescue nil)

    @booking = Booking.new(
      user: current_user,
      desk: @desk,
      start_date: start_date,
      end_date: end_date
    )

    if @booking.save
      redirect_to renter_bookings_path, notice: "Booking created successfully!"
    else
      redirect_to desk_path(@desk), alert: "Could not create booking. Please select valid dates."
    end
  end
end
