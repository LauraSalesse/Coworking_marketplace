class DesksController < ApplicationController
  before_action :authenticate_user!, only: %i[new create]

  def index
    @desks = Desk.all
  end

  # used to show one specific desk:
  def show
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

  private

  def desk_params
      params.require(:desk).permit(
      :title,
      :description,
      :address,
      :location,
      :shared,
      :price,
      photos: []
    )
  end
end
