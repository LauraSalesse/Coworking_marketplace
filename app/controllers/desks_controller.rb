class DesksController < ApplicationController
  before_action :authenticate_user!, only: %i[new create edit update destroy]

  def index
    # If a search term was provided, filter by it; otherwise, show all.
    if params[:search].present?
      term = "%#{params[:search]}%"
      @desks = Desk.where("location ILIKE ? OR title ILIKE ?", term, term)
    else
      @desks = Desk.all
    end

    # Build markers only for desks that have coordinates
    @markers = @desks.geocoded.map do |desk|
      {
        lat: desk.latitude,
        lng: desk.longitude,
        info_window_html: render_to_string(
          partial: "desks/info_window",
          locals: { desk: desk }
        )
      }
    end
  end

  def show
    @desk = Desk.find(params[:id])
  end

  def confirm
    @desk = Desk.find(params[:id])
  end

  def new
    @desk = Desk.new
  end

  def create
    @desk = current_user.desks.build(desk_params)
    if @desk.save
      redirect_to @desk, notice: "Your space has been listed successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @desk = current_user.desks.find(params[:id])
  end


  def update
    @desk = current_user.desks.find(params[:id])

    # Update regular attributes (without photos)
    if @desk.update(desk_params)
      # Handle photos separately - only if new ones were uploaded
      if params[:desk][:photos].present?
        @desk.photos.attach(params[:desk][:photos])
      end
      redirect_to @desk, notice: "Your listing has been updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end


  def destroy
    @desk = Desk.find(params[:id])
    @desk.destroy
    redirect_to mydesks_path, notice: "Your listing has been removed."
  end

  # (Added by max)
  def mydesks
    @desks = current_user.desks

    if params[:month].present? && params[:year].present?
      @current_month = params[:month].to_i
      @current_year = params[:year].to_i
    else
      @current_month = Date.today.month
      @current_year = Date.today.year
    end
  end

  private

  def desk_params
    params.require(:desk).permit(
      :title,
      :description,
      :address,
      :location,
      :shared,
      :price,
      # photos are deleted here
    )
  end
end
