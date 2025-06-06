class BookingsController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def renter_bookings
    @bookings = Booking.where(user: current_user)
  end

  def create
    @desk = Desk.find(params[:booking][:desk_id])

    # transforming the string from the date picker into two variables start_date and end_date
    range = params[:booking][:date_range]
    start_date_str, end_date_str = range&.split(" to ")

    #creating the instances
    start_date = Date.parse(start_date_str) rescue nil
    end_date   = Date.parse(end_date_str) rescue nil

    #some checks in case the user didn't input both a start_date and end_date or end date is before start date
    if start_date.nil? || end_date.nil?
     flash[:alert] = "Please select a valid date range."
      return redirect_to desk_path(@desk)
    elsif start_date > end_date
      flash[:alert] = "End date cannot be before start date."
      return redirect_to desk_path(@desk)
    end

    # creating the booking
    @booking = Booking.new(
      user: current_user,
      desk: @desk,
      start_date: start_date,
      end_date: end_date
    )

    #checking if there is a conflict with other bookings
    conflict = Booking.where(desk: @desk)
              .where("start_date <= ? AND end_date >= ?", end_date, start_date)
              .exists?

    if conflict
      flash[:alert] = "This desk is already booked for those dates. Please choose other dates or an other desk"
      redirect_to desk_path(@desk)
    elsif @booking.save
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
