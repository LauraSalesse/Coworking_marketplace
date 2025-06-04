class BookingsController < ApplicationController
  #this needs to be called bookingsController otherwise Heroku crashes

  def renter_bookings
    @bookings = Booking.where(user: current_user)
  end
end
