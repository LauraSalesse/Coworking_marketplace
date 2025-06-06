class BookingsController < ApplicationController
  before_action :authenticate_user!, only: %i[create edit update destroy]

  def renter_bookings
    @bookings = Booking.where(user: current_user)
  end

  def create
    @desk = Desk.find(params[:booking][:desk_id])

    # Parse dates from the form
    start_date = (Date.parse(params[:booking][:start_date]) rescue nil)
    end_date   = (Date.parse(params[:booking][:end_date]) rescue nil)

    @booking = Booking.new(
      user:       current_user,
      desk:       @desk,
      start_date: start_date,
      end_date:   end_date
    )

    conflict = Booking.where(desk: @desk)
                      .where("start_date <= ? AND end_date >= ?", end_date, start_date)
                      .exists?

    if conflict
      flash[:alert] = "This desk is already booked for those dates. Please choose other dates or another desk."
      redirect_to desk_path(@desk)

    elsif @booking.save
      nights    = (@booking.end_date - @booking.start_date + 1).to_i
      desk_title = @booking.desk.title
      flash[:notice] = "You just booked #{desk_title} for #{nights} day#{'s' if nights > 1}!"
      redirect_to renter_bookings_path

    else
      redirect_to desk_path(@desk), alert: "Could not create booking. Please select valid dates."
    end
  end

  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy
    redirect_to renter_bookings_path,
                notice: "Your booking at #{@booking.desk.title} starting #{@booking.start_date} has been removed."
  end

  # ──────────────────────────────────────────────────────────────────────────

  # GET /bookings/:id
  def show
    @booking = Booking.find(params[:id])
    @desk    = @booking.desk
  end

  # GET /bookings/:id/edit
  def edit
    @booking = Booking.find(params[:id])
    @desk    = @booking.desk
  end

  # PATCH /bookings/:id
  def update
    @booking = Booking.find(params[:id])
    @desk    = @booking.desk

    new_start = (Date.parse(params[:booking][:start_date]) rescue nil)
    new_end   = (Date.parse(params[:booking][:end_date])   rescue nil)

    conflict = Booking.where(desk: @desk)
                      .where.not(id: @booking.id)
                      .where("start_date <= ? AND end_date >= ?", new_end, new_start)
                      .exists?

    if conflict
      flash[:alert] = "Those dates conflict with another booking. Please pick different dates."
      render :edit, status: :unprocessable_entity

    elsif @booking.update(start_date: new_start, end_date: new_end)
      flash[:notice] = "Your booking dates have been updated."
      redirect_to booking_path(@booking)

    else
      flash.now[:alert] = "Could not update booking. Please select valid dates."
      render :edit, status: :unprocessable_entity
    end
  end
end
